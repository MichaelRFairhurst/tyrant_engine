import 'dart:math';

import 'package:tyrant_engine/src/algorithm/tree.dart' as minimax;
import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/rules/action.dart';
import 'package:tyrant_engine/src/rules/outcomes.dart';
import 'package:tyrant_engine/src/rules/rule_engine.dart';
import 'package:tyrant_engine/src/content/decks.dart' as decks;
import 'package:tyrant_engine/src/content/ships.dart' as ships;

class TyrantEngine {
  final ruleEngine = RuleEngine();
  final random = Random();

  void run(Game game) {
    while (true) {
      game = playerTurn(game);

      if (game.firstPlayer.ship.hp < 1 ||
          game.secondPlayer.ship.hp < 1 ||
          game.round == 30) {
        print('----GAME OVER!-----');
        print(game);
        return;
      }

      print('');
      print('!!!!!!!--------- NEW ROUND: ${game.round} ---------!!!!!!!');
      print('');
    }
  }

  Game playerTurn(Game game) {
    print('--- NEW TURN: ${game.turn} ----');

    final samePlayer = game.turn;
    while (game.turn == samePlayer) {
      print('[${game.phase}]');
      print('');
      var outcomes = ruleEngine.tick(
        game: game,
      );
      game = pickOutcome(outcomes);

      print('updated game: $game');
      print('');
      game = performActions(game);
    }

    return game;
  }

  Game performActions(Game game) {
    late List<Action> actions;
    while (true) {
      actions = ruleEngine.playerActions(game);

      if (actions.isEmpty) {
        break;
      }

      final chosen = pickAction(actions);

      if (chosen is EndPhaseAction) {
        break;
      }

      print('ACTION: $chosen');
      print('');

      game = pickOutcome(chosen.perform(game));
      print('STATE = $game');
      print('');
    }
    return game;
  }

  minimax.Branch<Game> gameToBranch(Game game) {
    // TODO: fix
    return decisionBranch(game);
  }

  minimax.Branch<Game> outcomeToBranch(Game game, Outcome<Game> outcome) {
    return minimax.ExpectedValueBranch<Game>(
        game,
        outcome.randomOutcomes
            .map((o) => minimax.Possibility<Game>(
                  o.probability,
                  gameToBranch(o.result),
                ))
            .toList());
  }

  minimax.Branch<Game> decisionBranch(Game game) {
    final actions = ruleEngine.playerActions(game);

    if (actions.isEmpty) {
      return minimax.DecisionBranch<Action, Game>(game, {}, true);
    }

    return minimax.DecisionBranch<Action, Game>(
        game,
        Map<Action, minimax.Branch<Game> Function()>.fromEntries(actions.map(
            (a) => MapEntry(a, () => outcomeToBranch(game, a.perform(game))))),
        true);
  }

  Game pickOutcome(Outcome<Game> outcomes) {
    // TODO: pick better ...
    return outcomes.randomOutcomes
        .toList()[random.nextInt(outcomes.randomOutcomes.length)]
        .result;
  }

  Action pickAction(List<Action> actions) {
    // TODO: pick better ...
    return actions[random.nextInt(actions.length)];
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
