import 'package:tyrant_engine/src/algorithm/minimax.dart';
import 'package:tyrant_engine/src/algorithm/scorer.dart';
import 'package:tyrant_engine/src/algorithm/tree.dart';
import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/model/player.dart';
import 'package:tyrant_engine/src/rules/action.dart';
import 'package:tyrant_engine/src/rules/outcomes.dart';
import 'package:tyrant_engine/src/rules/rule_engine.dart';
import 'package:tyrant_engine/src/strategy/strategy.dart';

class MinimaxStrategy implements Strategy {
  MinimaxStrategy(this.ruleEngine);

  final RuleEngine ruleEngine;

  @override
  Action pickAction(Game game, List<Action> actions) {
    final maxingPlayer = game.turn;
    final scorer = HpDifferentialScorer(maxingPlayer);
    final branch = decisionBranch(game, actions, maxingPlayer);
    return Minimax<Action, Game>(scorer).run(branch, 10, game.round + 2);
  }

  Branch<Game> gameToBranch(Game game, PlayerType maxingPlayer) {
    var outcomes = ruleEngine.tick(
      game: game,
    );

    if (outcomes.randomOutcomes.length > 1) {
      return outcomeToBranch(game, outcomes, maxingPlayer);
    } else if (outcomes.randomOutcomes.length == 1) {
      game = outcomes.randomOutcomes.single.result;
    }

    final actions = ruleEngine.playerActions(game);

    if (actions.isEmpty) {
      return gameToBranch(game, maxingPlayer);
    }

    return decisionBranch(game, actions, maxingPlayer);
  }

  Branch<Game> outcomeToBranch(
      Game game, Outcome<Game> outcome, PlayerType maxingPlayer) {
    final Iterable<RandomOutcome<Game>> outcomes;
    if (outcome.randomOutcomes.length > 10) {
      final newOutcomes = <RandomOutcome<Game>>[];
      outcomes = newOutcomes;

      final chunkSize = outcome.randomOutcomes.length ~/ 10;
      final iterator = outcome.randomOutcomes.iterator;
      double runningProbTotal = 0.0;

      iterator.moveNext();
      for (int i = 0;
          i < outcome.randomOutcomes.length;
          ++i, iterator.moveNext()) {
        final rOutcome = iterator.current;
        runningProbTotal += rOutcome.probability;
        if (i % chunkSize == 0 || i == outcome.randomOutcomes.length - 1) {
          final _i = i;
          newOutcomes.add(RandomOutcome<Game>(
            explanation: () => 'merge $_i: ${rOutcome.explanation}',
            probability: runningProbTotal,
            result: rOutcome.result,
          ));
        }
      }
    } else {
      outcomes = outcome.randomOutcomes;
    }

    return ExpectedValueBranch<Game>(
        game,
        game.round,
        outcomes.map((o) => Possibility<Game>(
              o.probability,
              gameToBranch(o.result, maxingPlayer),
            )));
  }

  DecisionBranch<Action, Game> decisionBranch(
      Game game, List<Action> actions, PlayerType maxingPlayer) {
    return DecisionBranch<Action, Game>(
      game,
      game.round,
      Map<Action, Branch<Game> Function()>.fromEntries(actions.map((a) =>
          MapEntry(
              a, () => outcomeToBranch(game, a.perform(game), maxingPlayer)))),
      game.turn == maxingPlayer,
    );
  }
}
