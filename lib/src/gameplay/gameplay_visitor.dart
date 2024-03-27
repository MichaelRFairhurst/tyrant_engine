import 'package:tyrant_engine/src/gameplay/gameplay_execution.dart';
import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/model/player.dart';
import 'package:tyrant_engine/src/rules/action.dart';
import 'package:tyrant_engine/src/rules/outcomes.dart';
import 'package:tyrant_engine/src/rules/rule_engine.dart';

abstract class GameplayVisitor<T> {
  T visitAll(Game game, RuleEngine ruleEngine) {
    return GameplayExecution<T>(ruleEngine, this).run(game);
  }

  T visitRound(Game game, T Function() keepVisiting) => keepVisiting();
  T visitTurn(Game game, T Function() keepVisiting) => keepVisiting();
  T visitPhase(Game game, T Function() keepVisiting) => keepVisiting();
  T visitActions(
      Game game, List<Action> actions, T Function(Action) visitAction);
  T visitOutcomes(Game game, Outcome<Game> outcomes,
      T Function(RandomOutcome<Game>) visitRandomOutcome);
  T visitSingularOutcome(
          RandomOutcome<Game> outcome, T Function() keepVisiting) =>
      keepVisiting();
  T visitWinner(Game game, PlayerType winner);
}
