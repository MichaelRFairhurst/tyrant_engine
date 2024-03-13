import 'dart:math';

import 'package:tyrant_engine/src/algorithm/expected_value_dice_roller.dart';
import 'package:tyrant_engine/src/cli/printer.dart';
import 'package:tyrant_engine/src/gameplay/accurate_dice_roller.dart';
import 'package:tyrant_engine/src/gameplay/dice_roller.dart';
import 'package:tyrant_engine/src/gameplay/gameplay_engine.dart';
import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/model/player.dart';
import 'package:tyrant_engine/src/rules/rule_engine.dart';
import 'package:tyrant_engine/src/strategy/minimax_strategy.dart';
import 'package:tyrant_engine/src/strategy/strategy.dart';

class TyrantEngine {
  final random = Random();

  Strategy minimaxStrategy([bool print = true, DiceRoller? diceSums]) {
    return MinimaxStrategy(
        RuleEngine(random, diceSums ?? ExpectedValueDiceRoller()), print);
  }

  void printGame(PlayerStrategies strategies, [Game? game]) {
    final ruleEngine = RuleEngine(random, AccurateDiceRoller());
    final printer = CliPrinter();
    final engine = GameplayEngine(printer, ruleEngine, random);
    game ??= engine.defaultGame();
    engine.run(game, strategies);
  }

  void compareStrategies(PlayerStrategies strategies, int count,
      {Game? game, DiceRoller? diceRoller}) {
    final ruleEngine = RuleEngine(random, diceRoller ?? AccurateDiceRoller());
    final engine = GameplayEngine(NoopPrinter(), ruleEngine, random);
    game ??= engine.defaultGame();

    int winCount = 0;
    for (int i = 0; i < count; ++i) {
      print('Game $i');
      final winner = engine.run(game, strategies);
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
