import 'package:tyrant_engine/src/algorithm/tree.dart';
import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/rules/action.dart';
import 'package:tyrant_engine/src/rules/outcomes.dart';
import 'package:tyrant_engine/src/rules/rule_engine.dart';
import 'package:tyrant_engine/src/strategy/strategy.dart';

class MinimaxStrategy implements Strategy {
  MinimaxStrategy(this.ruleEngine);

  final RuleEngine ruleEngine;

  Branch<Game> gameToBranch(Game game) {
    var outcomes = ruleEngine.tick(
      game: game,
    );

    if (outcomes.randomOutcomes.length > 1) {
      return outcomeToBranch(game, outcomes);
    }

    return decisionBranch(game);
  }

  Branch<Game> outcomeToBranch(Game game, Outcome<Game> outcome) {
    return ExpectedValueBranch<Game>(
        game,
        outcome.randomOutcomes
            .map((o) => Possibility<Game>(
                  o.probability,
                  gameToBranch(o.result),
                ))
            .toList());
  }

  Branch<Game> decisionBranch(Game game) {
    final actions = ruleEngine.playerActions(game);

    if (actions.isEmpty) {
      return DecisionBranch<Action, Game>(game, {}, true);
    }

    return DecisionBranch<Action, Game>(
        game,
        Map<Action, Branch<Game> Function()>.fromEntries(actions.map(
            (a) => MapEntry(a, () => outcomeToBranch(game, a.perform(game))))),
        true);
  }
}
