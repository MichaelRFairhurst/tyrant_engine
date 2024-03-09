import 'dart:math';

import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/model/player.dart';
import 'package:tyrant_engine/src/rules/action.dart';
import 'package:tyrant_engine/src/rules/outcomes.dart';
import 'package:tyrant_engine/src/rules/rule_engine.dart';
import 'package:tyrant_engine/src/content/decks.dart' as decks;
import 'package:tyrant_engine/src/content/ships.dart' as ships;

class TyrantEngine {
  final ruleEngine = RuleEngine();
  final random = Random();

  void run(Game game) {
    var round = 1;
    var player = PlayerType.player;

    while (true) {
      game = playerTurn(game, player, round);
      player =
          player == PlayerType.player ? PlayerType.enemy : PlayerType.player;

      if (game.playerType(player).ship.hp == 0 || round == 30) {
        print('----GAME OVER!-----');
        print(game);
        return;
      }

      if (player == PlayerType.player) {
        round++;
        print('');
        print('!!!!!!!--------- NEW ROUND: $round ---------!!!!!!!');
        print('');
      }
    }
  }

  Game playerTurn(Game game, PlayerType player, int round) {
    print('--- NEW TURN: $player ----');
    Phase? phase = ruleEngine.startingPhase;

    while (phase != null) {
      print('[$phase]');
      print('');
      var outcomes = ruleEngine.tick(
        game: game,
        player: player,
        round: round,
        phase: phase,
      );
      game = pickOutcome(outcomes);

      print('updated game: $game');
      print('');
      game = performActions(game, player, phase);
      phase = ruleEngine.nextPhase(phase);
    }

    return game;
  }

  Game performActions(Game game, PlayerType player, Phase phase) {
    late List<Action> actions;
    while (true) {
      actions = ruleEngine.playerActions(game, player, phase);

      if (actions.isEmpty) {
        break;
      }

      final chosen = pickAction(actions);

      if (chosen is EndPhaseAction) {
        break;
      }

      print('ACTION: $chosen');
      print('');

      game = pickOutcome(chosen.perform(game, player));
      print('STATE = $game');
      print('');
    }
    return game;
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
