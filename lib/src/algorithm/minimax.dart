import 'dart:math';

import 'package:tyrant_engine/src/algorithm/scorer.dart';
import 'package:tyrant_engine/src/algorithm/tree.dart';
import 'package:tyrant_engine/src/cli/printer.dart';

class Minimax<A, T> {
  final Scorer scorer;
  int count = 0;

  Minimax(this.scorer);

  A run(DecisionBranch<A, T> root, int maxDepth, int untilTurn) {
    A? bestAction;
    double bestScore = double.negativeInfinity;
    count = 0;

    for (final entry in root.actions.entries) {
      final score = scoreOf(entry.value(), maxDepth - 1, untilTurn);
      print('RANKING ${entry.key}: $score');
      if (score > bestScore) {
        bestAction = entry.key;
        bestScore = score;
      }
    }

    print('$count COMBINATIONS');
    if (count > 1000) {
      print('PATHOLOGICAL');
      print('${(root.value as dynamic).phase}');
      Printer().printGame(root.value as dynamic);
    }
    return bestAction!;
  }

  double scoreOf(Branch<T> branch, int maxDepth, int untilTurn) {
    if (maxDepth == 0 || branch.turn == untilTurn) {
      count++;

      if (count % 1000 == 0) {
        print('COUNT $count');
      }
      return scorer.score(branch.value);
    }

    final spacer = '  ' * (10 - maxDepth);
    if (branch is DecisionBranch<A, T>) {
      var score = branch.isMaxing ? double.negativeInfinity : double.infinity;

      if (branch.actions.length == 1) {
        return scoreOf(
            branch.actions.entries.single.value(), maxDepth, untilTurn);
      }

      for (final entry in branch.actions.entries) {
        print('$spacer considering subaction ${entry.key}');
        if (branch.isMaxing) {
          score = max(score, scoreOf(entry.value(), maxDepth - 1, untilTurn));
        } else {
          score = min(score, scoreOf(entry.value(), maxDepth - 1, untilTurn));
        }
      }

      return score;
    }

    if (branch is ExpectedValueBranch<T>) {
      if (branch.possibilities.length == 1) {
        return scoreOf(branch.possibilities.single.result, maxDepth, untilTurn);
      }

      print('$spacer avging expected value ${branch.possibilities.length}');
      return branch.possibilities.fold<double>(
          0.0,
          (sum, p) =>
              sum + p.probability * scoreOf(p.result, maxDepth - 1, untilTurn));
    }

    throw 'unexpected branch $branch';
  }
}
