import 'dart:math';

import 'package:tyrant_engine/src/algorithm/final_turn_max.dart';
import 'package:tyrant_engine/src/algorithm/scorer.dart';
import 'package:tyrant_engine/src/algorithm/final_action_table.dart';
import 'package:tyrant_engine/src/algorithm/tree.dart';
import 'package:tyrant_engine/src/rules/outcomes.dart';

class Minimax<A, T> {
  final Scorer<T> scorer;
  final FinalActionTable<T, A> finalActionTable;
  final FinalTurnMax finalTurnMax;
  bool watch;
  Duration? time;
  int steps = 0;
  int scorerCount = 0;
  int skipScoreCount = 0;
  int alphaCutoffsCount = 0;
  int betaCutoffsCount = 0;
  int speculationFailuresRoot = 0;
  int revisitedRoot = 0;
  int speculationFailuresChance = 0;
  int revisitedChance = 0;

  Minimax(this.scorer, this.finalActionTable, this.finalTurnMax,
      [this.watch = true]);

  A run(DecisionBranch<A, T> root, int maxDepth, int untilTurn) {
    final startTime = DateTime.now();
    A? bestAction;
    double bestScore = double.negativeInfinity;

    final rootScore = scorer.score(root.value);
    var alpha = rootScore - scorer.alphaBetaExpansionRoot;
    var beta = rootScore + scorer.alphaBetaExpansionRoot;
    //var alpha = double.negativeInfinity;
    //final beta = double.infinity;

    int i = 0;
    for (final entry in root.actions) {
      var localBeta = beta;
      var score = scoreOf(entry.result, alpha, beta, maxDepth - 1, untilTurn);

      while (true) {
        if (score <= alpha) {
          final diff = score - alpha;
          alpha = score + diff - 1;
          score =
              scoreOf(entry.result, alpha, localBeta, maxDepth - 1, untilTurn);
        } else if (score >= localBeta) {
          final diff = score - localBeta;
          localBeta = score + diff + 1;
          score =
              scoreOf(entry.result, alpha, localBeta, maxDepth - 1, untilTurn);
        } else {
          break;
        }
      }

      if (score > beta) {
        beta = localBeta + 1;
      }

      assert(() {
        final rescore = minimax(entry.result, maxDepth - 1, untilTurn);
        if (score > rescore + 0.001 || score < rescore - 0.001) {
          throw 'Invalid score! $score vs $rescore';
        }

        return true;
      }());

      i++;
      if (watch) {
        print('Evaluated move $i / ${root.actions.length}');
        print('  ${entry.move} @ $score');
      }
      if (score > bestScore) {
        bestAction = entry.move;
        bestScore = score;
      }
      alpha = max(alpha, score);
    }

    time = DateTime.now().difference(startTime);
    return bestAction!;
  }

  void printStats() {
    print('Decision in ${time!.inSeconds}s');
    print('Steps: $steps');
    print('${time!.inMicroseconds / steps} micros per step');
    print('Scorer executed: $scorerCount');
    print('Nodes skipped by score: $skipScoreCount');
    print('Alpha cutoffs: $alphaCutoffsCount');
    print('Beta cutoffs: $betaCutoffsCount');
    print('Root speculation failures: $speculationFailuresRoot');
    print('Root speculation revisits: $revisitedRoot');
    print('Chance speculation failures: $speculationFailuresChance');
    print('Chance speculation revisits: $revisitedChance');
  }

  void trace(int maxDepth, String Function() f) {
    return;
    final spacer = '  ' * (20 - maxDepth);
    print('$spacer${f()}');
  }

  double speculativeRootSearch(Branch<T> branch, double alpha, double beta,
      int maxDepth, int untilTurn) {
    var score = scoreOf(branch, alpha, beta, maxDepth, untilTurn);
    final startVisits = steps;

    while (score >= beta) {
      trace(maxDepth, () => 'window beta violation $beta vs $score');
      final diff = score - beta;
      beta = score + diff + 1;
      score = scoreOf(branch, alpha, beta, maxDepth, untilTurn);
      speculationFailuresRoot++;
      revisitedRoot += steps - startVisits;
    }

    return branch.score = score;
  }

  double scoreExpectedValue(ExpectedValueBranch<T> branch, double rootAlpha,
      double rootBeta, int maxDepth, int untilTurn) {
    if (branch.score != null) {
      skipScoreCount++;
      return branch.score!;
    }

    if (branch.outcome.randomOutcomes.length == 1) {
      return scoreOf(branch.outcome.randomOutcomes.single.result, rootAlpha,
          rootBeta, maxDepth, untilTurn);
    }

    final rootScore = scorer.score(branch.value);
    //alpha = rootScore - scorer.alphaBetaExpansionChance;
    //beta = rootScore + scorer.alphaBetaExpansionChance;

    var maxErrorAlpha = 0.0;
    var maxErrorBeta = 0.0;
    final spacer = '  ' * (20 - maxDepth);

    double sum = 0;
    for (final child in branch.outcome.randomOutcomes) {
      if (child.result.score != null) {
        sum += child.result.score! * child.probability;
        continue;
      }

      final childScore = scorer.score(child.result.value);
      final scoreDiff = childScore - rootScore;
      var alpha = rootAlpha +
          scoreDiff -
          scorer.alphaBetaExpansionChance +
          maxErrorAlpha;
      var beta =
          rootBeta + scoreDiff + scorer.alphaBetaExpansionChance + maxErrorBeta;

      var speculate =
          scoreOf(child.result, alpha, beta, maxDepth - 1, untilTurn);
      final preCount = steps;
      while (true) {
        if (speculate <= alpha) {
          trace(
              maxDepth,
              () =>
                  '$spacer chance alpha violation $alpha vs $speculate $scoreDiff $rootScore ${child.explanation()}');
          final diff = speculate - alpha - 1;
          alpha = speculate + diff;
          maxErrorAlpha = min(maxErrorAlpha, diff);
          speculate =
              scoreOf(child.result, alpha, beta, maxDepth - 1, untilTurn);
          speculationFailuresChance++;
          revisitedChance += steps - preCount;
        } else if (speculate >= beta) {
          trace(
              maxDepth,
              () =>
                  '$spacer chance beta violation $beta vs $speculate $scoreDiff $rootScore ${child.explanation()}');
          final diff = speculate - beta + 1;
          beta = speculate + diff;
          maxErrorBeta = max(maxErrorBeta, diff);
          speculate =
              scoreOf(child.result, alpha, beta, maxDepth - 1, untilTurn);
          speculationFailuresChance++;
          revisitedChance += steps - preCount;
        } else {
          break;
        }
      }

      sum += speculate * child.probability;
    }

    trace(maxDepth, () => '$spacer $branch sums to $sum');
    return branch.score = sum;
  }

  double scoreOf(Branch<T> branch, double alpha, double beta, int maxDepth,
      int untilTurn) {
    trace(maxDepth, () => 'step $branch $alpha $beta $maxDepth');
    steps++;
    if (watch && steps % 1000000 == 0) {
      print('STEPS $steps');
    }

    if (branch.score != null) {
      skipScoreCount++;
      trace(maxDepth, () => 'already scored: ${branch.score!}');
      return branch.score!;
    }

    if (maxDepth == 0 || branch.turn >= untilTurn - 2) {
      if (branch.score == null) {
        scorerCount++;
        branch.score = finalTurnMax.opposingPlayersMax(branch.value as dynamic);
        trace(maxDepth, () => 'Scoring: ${branch.score}');
      } else {
        skipScoreCount++;
        trace(maxDepth, () => 'Already scored: ${branch.score}');
      }

      return branch.score!;
    }

    if (branch is DecisionBranch<A, T>) {
      var score = branch.isMaxing ? double.negativeInfinity : double.infinity;

      if (branch.actions.length == 1) {
        return scoreOf(
            branch.actions.single.result, alpha, beta, maxDepth, untilTurn);
      }

      for (final entry in branch.actions) {
        trace(maxDepth, () => 'considering subaction ${entry.move}');
        if (branch.isMaxing) {
          /*final value = finalActionTable.shortcutActionScore(
              branch.value,
              entry.move,
              untilTurn,
              () =>
                  scoreOf(entry.result, alpha, beta, maxDepth - 1, untilTurn));*/
          final value =
              scoreOf(entry.result, alpha, beta, maxDepth - 1, untilTurn);
          score = max(score, value);
          if (score >= beta) {
            trace(maxDepth, () => 'Beta pruning ${entry.move}');
            betaCutoffsCount++;
            break;
          }
          alpha = max(alpha, value);
        } else {
          /*final value = finalActionTable.shortcutActionScore(
              branch.value,
              entry.move,
              untilTurn,
              () =>
                  scoreOf(entry.result, alpha, beta, maxDepth - 1, untilTurn));*/
          final value =
              scoreOf(entry.result, alpha, beta, maxDepth - 1, untilTurn);
          score = min(score, value);
          if (score <= alpha) {
            trace(maxDepth, () => 'Alpha pruning ${entry.move}');
            alphaCutoffsCount++;
            break;
          }
          beta = min(beta, value);
        }
      }

      if (score > alpha && score < beta) {
        branch.score = score;
      }

      return score;
    }

    if (branch is ExpectedValueBranch<T>) {
      return scoreExpectedValue(branch, alpha, beta, maxDepth, untilTurn);
    }

    throw 'unexpected branch $branch';
  }

  double minimax(Branch<T> branch, int maxDepth, int untilTurn) {
    final spacer = '  ' * (10 - maxDepth);
    if (maxDepth == 0 || branch.turn >= untilTurn) {
      return branch.score ??= scorer.score(branch.value);
    }

    if (branch is DecisionBranch<A, T>) {
      var score = branch.isMaxing ? double.negativeInfinity : double.infinity;

      if (branch.actions.length == 1) {
        return minimax(branch.actions.single.result, maxDepth, untilTurn);
      }

      for (final entry in branch.actions) {
        //print('$spacer considering subaction ${entry.move}');
        if (branch.isMaxing) {
          final value = minimax(entry.result, maxDepth - 1, untilTurn);
          score = max(score, value);
        } else {
          final value = minimax(entry.result, maxDepth - 1, untilTurn);
          score = min(score, value);
        }
      }

      return score;
    }

    if (branch is ExpectedValueBranch<T>) {
      if (branch.outcome.randomOutcomes.length == 1) {
        return minimax(
            branch.outcome.randomOutcomes.single.result, maxDepth, untilTurn);
      }

      return branch.outcome
          .map<double>((child) => minimax(child, maxDepth - 1, untilTurn))
          .expectedValue;
    }

    throw 'unexpected branch $branch';
  }
}
