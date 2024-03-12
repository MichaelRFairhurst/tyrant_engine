import 'dart:math';

import 'package:tyrant_engine/src/cli/printer.dart';
import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/model/player.dart';
import 'package:tyrant_engine/src/rules/action.dart';
import 'package:tyrant_engine/src/rules/outcomes.dart';
import 'package:tyrant_engine/src/rules/rule_engine.dart';
import 'package:tyrant_engine/src/content/decks.dart' as decks;
import 'package:tyrant_engine/src/content/ships.dart' as ships;
import 'package:tyrant_engine/src/strategy/strategy.dart';

class TyrantEngine {
  final ruleEngine = RuleEngine();
  final printer = Printer();
  final random = Random();

  void run(Game game, PlayerStrategies strategies) {
    print('----- NEW GAME! ----');
    printer.printGame(game);
    print('');
    print('');

    while (true) {
      game = playerTurn(game, strategies.player(game.turn));

      if (game.firstPlayer.ship.hp < 1) {
        print('----GAME OVER!-----');
        printer.printGame(game);
        print('----Player 2 Wins!-----');
        return;
      }

      if (game.secondPlayer.ship.hp < 1) {
        print('----GAME OVER!-----');
        printer.printGame(game);
        print('----Player 1 Wins!-----');
        return;
      }

      if (game.turn == PlayerType.firstPlayer) {
        print('');
        print('!!!!!!!--------- NEW ROUND: ${game.round} ---------!!!!!!!');
        print('');
      }
    }
  }

  Game playerTurn(Game game, Strategy strategy) {
    print('--- NEW TURN: ${game.turn} ----');
    print('');

    final samePlayer = game.turn;
    while (game.turn == samePlayer) {
      print('[${game.phase}]');
      var outcomes = ruleEngine.tick(
        game: game,
      );
      game = pickOutcome(outcomes);

      printer.printGame(game);
      game = performActions(game, strategy);
    }

    printer.printGame(game);

    return game;
  }

  Game performActions(Game game, Strategy strategy) {
    late List<Action> actions;
    while (true) {
      actions = ruleEngine.playerActions(game);

      if (actions.isEmpty) {
        break;
      }

      final chosen = actions.length == 1
          ? actions.single
          : strategy.pickAction(game, actions);

      print('[ACTION: $chosen]');

      game = pickOutcome(chosen.perform(game));
      printer.printGame(game);
    }
    return game;
  }

  Game pickOutcome(Outcome<Game> outcomes) {
    if (outcomes.randomOutcomes.length == 1) {
      return outcomes.randomOutcomes.single.result;
    }

    final outcome = outcomes.randomOutcomes
        .toList()[random.nextInt(outcomes.randomOutcomes.length)];

    print('[Random outcome: ${outcome.explanation}]');
    print('');
    return outcome.result;
  }

  Game defaultGame() {
    return ruleEngine.initializeGame(
      playerDeck: decks.defaultDeck,
      playerBuild: ships.defaultBuild,
      enemyDeck: decks.defaultDeck,
      enemyBuild: ships.defaultBuild,
    );
  }
}
