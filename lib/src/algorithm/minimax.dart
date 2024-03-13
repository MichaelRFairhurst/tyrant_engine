import 'dart:math';

import 'package:tyrant_engine/src/algorithm/scorer.dart';
import 'package:tyrant_engine/src/algorithm/tree.dart';

class Minimax<A, T> {
  final Scorer<T> scorer;
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

  Minimax(this.scorer, [this.watch = true]);

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

      assert(score == minimax(entry.result, maxDepth - 1, untilTurn));

      //print('RANKING ${entry.key}: $score');
      i++;
      if (watch) {
        print('Evaluated move $i / ${root.actions.length}');
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

  double speculativeRootSearch(Branch<T> branch, double alpha, double beta,
      int maxDepth, int untilTurn) {
    var score = scoreOf(branch, alpha, beta, maxDepth, untilTurn);
    final startVisits = steps;

    while (score >= beta) {
      //print('window beta violation $beta vs $score');
      final diff = score - beta;
      beta = score + diff + 1;
      score = scoreOf(branch, alpha, beta, maxDepth, untilTurn);
      speculationFailuresRoot++;
      revisitedRoot += steps - startVisits;
    }

    return branch.score = score;
  }

  double scoreExpectedValue(ExpectedValueBranch<T> branch, double alpha,
      double beta, int maxDepth, int untilTurn) {
    if (branch.score != null) {
      skipScoreCount++;
      return branch.score!;
    }

    if (branch.possibilities.length == 1) {
      return scoreOf(
          branch.possibilities.single.result, alpha, beta, maxDepth, untilTurn);
    }

    final rootScore = scorer.score(branch.value);
    alpha = rootScore - scorer.alphaBetaExpansionChance;
    beta = rootScore + scorer.alphaBetaExpansionChance;

    double sum = 0;
    for (final child in branch.possibilities) {
      var speculate =
          scoreOf(child.result, alpha, beta, maxDepth - 1, untilTurn);
      final preCount = steps;
      while (true) {
        if (speculate <= alpha) {
          //print('chance alpha violation $alpha vs $speculate');
          final diff = speculate - alpha - 1;
          alpha = speculate + diff;
          speculate = scoreOf(child.result, alpha, beta, maxDepth, untilTurn);
          speculationFailuresChance++;
          revisitedChance += steps - preCount;
        } else if (speculate >= beta) {
          //print('chance beta violation $beta vs $speculate');
          final diff = speculate - beta + 1;
          beta = speculate + diff;
          speculate = scoreOf(child.result, alpha, beta, maxDepth, untilTurn);
          speculationFailuresChance++;
          revisitedChance += steps - preCount;
        } else {
          break;
        }
      }

      sum += speculate * child.probability;
    }

    return branch.score = sum;
  }

  double scoreOf(Branch<T> branch, double alpha, double beta, int maxDepth,
      int untilTurn) {
    steps++;
    if (watch && steps % 10000000 == 0) {
      print('STEPS $steps');
    }

    if (branch.score != null) {
      skipScoreCount++;
      return branch.score!;
    }

    if (maxDepth == 0 || branch.turn == untilTurn) {
      scorerCount++;

      return branch.score ??= scorer.score(branch.value);
    }

    final spacer = '  ' * (10 - maxDepth);
    if (branch is DecisionBranch<A, T>) {
      var score = branch.isMaxing ? double.negativeInfinity : double.infinity;

      if (branch.actions.length == 1) {
        return scoreOf(
            branch.actions.single.result, alpha, beta, maxDepth, untilTurn);
      }

      for (final entry in branch.actions) {
        //print('$spacer considering subaction ${entry.move}');
        if (branch.isMaxing) {
          final value =
              scoreOf(entry.result, alpha, beta, maxDepth - 1, untilTurn);
          score = max(score, value);
          if (score >= beta) {
            //print('Beta pruning ${entry.key}');
            betaCutoffsCount++;
            break;
          }
          alpha = max(alpha, value);
        } else {
          final value =
              scoreOf(entry.result, alpha, beta, maxDepth - 1, untilTurn);
          score = min(score, value);
          if (score <= alpha) {
            //print('Alpha pruning ${entry.key}');
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
    if (maxDepth == 0 || branch.turn == untilTurn) {
      return branch.score ??= scorer.score(branch.value);
    }

    final spacer = '  ' * (10 - maxDepth);
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
      if (branch.possibilities.length == 1) {
        return minimax(branch.possibilities.single.result, maxDepth, untilTurn);
      }

      double sum = 0;
      for (final child in branch.possibilities) {
        var score = minimax(child.result, maxDepth - 1, untilTurn);
        sum += score * child.probability;
      }
      return sum;
    }

    throw 'unexpected branch $branch';
  }
}
