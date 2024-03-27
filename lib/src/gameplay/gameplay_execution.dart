import 'package:tyrant_engine/src/gameplay/gameplay_visitor.dart';
import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/rules/action.dart';
import 'package:tyrant_engine/src/rules/outcomes.dart';
import 'package:tyrant_engine/src/rules/rule_engine.dart';

class GameplayExecution<T> {
  final RuleEngine ruleEngine;
  final GameplayVisitor<T> visitor;
  GameplayExecution(this.ruleEngine, this.visitor);

  T run(Game game) => newRound(game);

  T newRound(Game game) => visitor.visitRound(game, () => playerTurn(game));

  T playerTurn(Game game) => visitor.visitTurn(game, () => phase(game));

  T phase(Game game) {
    return visitor.visitPhase(game, () {
      var outcomes = ruleEngine.tick(
        game: game,
      );

      if (outcomes.isBranching) {
        return visitor.visitOutcomes(
            game, outcomes, (child) => _directGame(game, child.result));
      } else {
        return visitor.visitSingularOutcome(outcomes.randomOutcomes.single,
            () => performActions(outcomes.single));
      }
    });
  }

  T performActions(Game game) {
    late List<Action> actions;
    actions = ruleEngine.playerActions(game);

    if (actions.isEmpty) {
      return phase(game);
    }

    return visitor.visitActions(
        game, actions, (child) => _directAction(game, child));
  }

  T _directAction(Game oldGame, Action action) =>
      _directOutcome(oldGame, action.perform(oldGame));

  T _directOutcome(Game oldGame, Outcome<Game> outcome) {
    if (outcome.isSingular) {
      return visitor.visitSingularOutcome(outcome.randomOutcomes.single,
          () => _directGame(oldGame, outcome.single));
    } else {
      return visitor.visitOutcomes(
          oldGame, outcome, (newGame) => _directGame(oldGame, newGame.result));
    }
  }

  T _directGame(Game oldGame, Game newGame) {
    final winner = ruleEngine.winner(newGame);
    if (winner != null) {
      return visitor.visitWinner(newGame, winner);
    }

    if (oldGame.round != newGame.round) {
      return newRound(newGame);
    } else if (oldGame.turn != newGame.turn) {
      return playerTurn(newGame);
    } else if (oldGame.phase != newGame.phase) {
      return phase(newGame);
    } else {
      return performActions(newGame);
    }
  }
}
