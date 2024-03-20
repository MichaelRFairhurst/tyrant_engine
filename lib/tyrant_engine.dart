import 'dart:math';

import 'package:tyrant_engine/src/algorithm/expected_value_dice_roller.dart';
import 'package:tyrant_engine/src/algorithm/mcts.dart';
import 'package:tyrant_engine/src/cli/printer.dart';
import 'package:tyrant_engine/src/gameplay/accurate_dice_roller.dart';
import 'package:tyrant_engine/src/gameplay/dice_roller.dart';
import 'package:tyrant_engine/src/gameplay/gameplay_engine.dart';
import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/model/player.dart';
import 'package:tyrant_engine/src/parallel/mcts_service.dart';
import 'package:tyrant_engine/src/parallel/mcts_spec.dart';
import 'package:tyrant_engine/src/rules/rule_engine.dart';
import 'package:tyrant_engine/src/strategy/mcts_strategy.dart';
import 'package:tyrant_engine/src/strategy/minimax_strategy.dart';
import 'package:tyrant_engine/src/strategy/strategy.dart';

class TyrantEngine {
  final random = Random();

  Strategy minimaxStrategy({
    bool print = true,
    DiceRoller? diceRoller,
    bool maxOnly = false,
  }) {
    return MinimaxStrategy(
      ruleEngine: ruleEngine(diceRoller ?? ExpectedValueDiceRoller()),
      printStats: print,
      maxOnly: maxOnly,
    );
  }

  Future<MctsService> mctsService(MctsSpec spec) async {
    final service = MctsService(spec);
    await service.run();
    return service;
  }

  Mcts mcts(MctsSpec spec) =>
      Mcts(gameplayEngine(NoopPrinter()), spec.sampleCount);

  Future<Strategy> mctsStrategy(MctsSpec spec) async =>
      MctsStrategy(await mctsService(spec));

  GameplayEngine gameplayEngine(Printer printer) =>
      GameplayEngine(printer, ruleEngine(), random);

  RuleEngine ruleEngine([DiceRoller? diceRoller]) =>
      RuleEngine(random, diceRoller ?? AccurateDiceRoller());

  void printGame(PlayerStrategies strategies,
      {Game? game, DiceRoller? diceRoller}) {
    final printer = CliPrinter();
    final engine = GameplayEngine(printer, ruleEngine(diceRoller), random);
    game ??= engine.defaultGame();
    engine.run(game, strategies);
  }

  Future<void> compareStrategies(PlayerStrategies strategies, int count,
      {Game? game, DiceRoller? diceRoller}) async {
    final rules = ruleEngine(diceRoller);
    final engine = GameplayEngine(NoopPrinter(), rules, random);
    game ??= engine.defaultGame();

    int winCount = 0;
    for (int i = 0; i < count; ++i) {
      print('Game $i');
      final winner = await engine.run(game, strategies);
      final winnerType = strategies.player(winner).name;
      print('  winner: $winner ($winnerType)');
      if (winner == PlayerType.firstPlayer) {
        winCount++;
      }
    }

    final winPercent = (winCount / count) * 100;
    print('');
    print(
        'Player 1 (${strategies.firstPlayerStrategy.name}) won ${winPercent.toStringAsFixed(2)}% of matches.');
    print(
        'Player 2 (${strategies.secondPlayerStrategy.name}) won ${(100 - winPercent).toStringAsFixed(2)}% of matches.');
  }
}
