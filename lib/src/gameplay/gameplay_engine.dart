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

class GameplayEngine {
  final RuleEngine ruleEngine;
  final Printer printer;
  final Random random;

  GameplayEngine(this.printer, this.ruleEngine, this.random);

  Game defaultGame() {
    return ruleEngine.initializeGame(
      playerDeck: decks.defaultDeck,
      playerBuild: ships.defaultBuild,
      enemyDeck: decks.defaultDeck,
      enemyBuild: ships.defaultBuild,
    );
  }

  PlayerType run(Game game, PlayerStrategies strategies) {
    printer.initGame(game);

    while (true) {
      game = playerTurn(game, strategies.player(game.turn));

      if (game.firstPlayer.ship.hp <= 0) {
        printer.gameOver(game, PlayerType.secondPlayer);
        return PlayerType.secondPlayer;
      }

      if (game.secondPlayer.ship.hp <= 0) {
        printer.gameOver(game, PlayerType.firstPlayer);
        return PlayerType.firstPlayer;
      }

      if (game.turn == PlayerType.firstPlayer) {
        printer.newRound(game);
      }
    }
  }

  Game playerTurn(Game game, Strategy strategy) {
    printer.newTurn(game);

    final samePlayer = game.turn;
    while (game.turn == samePlayer) {
      printer.startPhase(game);
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

      printer.chosenAction(chosen);

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

    printer.randomOutcome(outcome);
    return outcome.result;
  }
}
