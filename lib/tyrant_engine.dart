import 'dart:math';

import 'package:tyrant_engine/src/algorithm/tree.dart' as minimax;
import 'package:tyrant_engine/src/cli/printer.dart';
import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/model/player.dart';
import 'package:tyrant_engine/src/rules/action.dart';
import 'package:tyrant_engine/src/rules/outcomes.dart';
import 'package:tyrant_engine/src/rules/rule_engine.dart';
import 'package:tyrant_engine/src/content/decks.dart' as decks;
import 'package:tyrant_engine/src/content/ships.dart' as ships;

class TyrantEngine {
  final ruleEngine = RuleEngine();
  final printer = Printer();
  final random = Random();

  void run(Game game) {
    print('----- NEW GAME! ----');
    printer.printGame(game);
    print('');
    print('');

    while (true) {
      game = playerTurn(game);

      if (game.firstPlayer.ship.hp < 1 ||
          game.secondPlayer.ship.hp < 1 ||
          game.round == 30) {
        print('----GAME OVER!-----');
        printer.printGame(game);
        return;
      }

      if (game.turn == PlayerType.firstPlayer) {
        print('');
        print('!!!!!!!--------- NEW ROUND: ${game.round} ---------!!!!!!!');
        print('');
      }
    }
  }

  Game playerTurn(Game game) {
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
      game = performActions(game);
    }

    printer.printGame(game);

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

      print('[ACTION: $chosen]');

      game = pickOutcome(chosen.perform(game));
      printer.printGame(game);
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
