import 'dart:math';

import 'package:tyrant_engine/src/cli/printer.dart';
import 'package:tyrant_engine/src/gameplay/gameplay_engine.dart';
import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/model/player.dart';
import 'package:tyrant_engine/src/strategy/strategy.dart';

class TyrantEngine {
  final random = Random();

  void printGame(PlayerStrategies strategies, [Game? game]) {
    final printer = CliPrinter();
    final engine = GameplayEngine(printer, random);
    game ??= engine.defaultGame();
    engine.run(game, strategies);
  }

  void compareStrategies(PlayerStrategies strategies, int count, [Game? game]) {
    final engine = GameplayEngine(NoopPrinter(), random);
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
