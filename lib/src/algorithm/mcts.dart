import 'dart:math';
import 'package:tyrant_engine/src/algorithm/scorer.dart';
import 'package:tyrant_engine/src/gameplay/gameplay_visitor.dart';
import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/model/player.dart';
import 'package:tyrant_engine/src/parallel/mcts_spec.dart';
import 'package:tyrant_engine/src/rules/action.dart';
import 'package:tyrant_engine/src/rules/outcomes.dart';
import 'package:tyrant_engine/src/rules/rule_engine.dart';

class Mcts {
  final MctsSpec spec;
  final Random random;
  final RuleEngine ruleEngine;
  final scorer = HpDifferentialScorer(PlayerType.firstPlayer);

  Mcts(this.ruleEngine, this.random, this.spec);

  Future<Action> pickAction(Game game, List<Action> actions) async {
    Action? bestAction;
    int mostVictories = 0;

    for (var i = 0; i < actions.length; ++i) {
      //print('evaluating $action');
      final victories = await countVictoriesForActionIdx(game, actions, i);

      //print('  victory in $victories games');
      if (victories > mostVictories) {
        mostVictories = victories;
        bestAction = actions[i];
      }
    }

    return bestAction!;
  }

  Future<int> countVictoriesForActionIdx(
      Game game, List<Action> actions, int idx) async {
    final ifPerformed = actions[idx].perform(game);
    final treeBuilder = _MctsTreeBuilder();
    final tree = treeBuilder.visitOutcomes(game, ifPerformed,
        (child) => treeBuilder.visitAll(child.result, ruleEngine));
    int victories = 0;
    for (int i = 0; i < spec.sampleCount; ++i) {
      final winner = _simulate(tree, 0);
      if (winner == game.turn) {
        victories++;
      }
    }
    print('${actions[idx]} victories: $victories');
    return victories;
  }

  PlayerType _simulate(_MctsNode tree, int depth) {
    if (tree is _MctsLeaf) {
      return tree.handleWinner(tree.winner);
    }
    if (tree is _MctsRandom) {
      final next = tree.outcomes.pick(random.nextDouble()).result;
      return tree.handleWinner(_simulate(next, depth + 1));
    }
    if (tree is _MctsBranch) {
      if (depth >= spec.maxDepth) {
        return tree.handleWinner(scorer.score(tree.game) > 0
            ? PlayerType.firstPlayer
            : PlayerType.secondPlayer);
      } else {
        final child = tree.children
            .reduce((c, next) => c.result.uct(tree.simulations) >
                    next.result.uct(tree.simulations)
                ? c
                : next)
            .result;
        return tree.handleWinner(_simulate(child, depth + 1));
      }
    }
    throw 'unreachable';
  }
}

class _MctsTreeBuilder extends GameplayVisitor<_MctsNode> {
  @override
  _MctsNode visitActions(Game game, List<Action> actions,
      _MctsNode Function(Action p1) visitAction) {
    return _MctsBranch(
        game, actions.map((a) => _Lazy(() => visitAction(a))).toList());
  }

  @override
  _MctsNode visitOutcomes(Game game, Outcome<Game> outcomes,
      _MctsNode Function(RandomOutcome<Game> p1) visitRandomOutcome) {
    return _MctsRandom(
        game,
        outcomes
            .mapWithProbability((ro) => ro.map((_) => visitRandomOutcome(ro))));
  }

  @override
  _MctsNode visitWinner(Game game, PlayerType winner) {
    return _MctsLeaf(winner);
  }
}

abstract class _MctsNode {
  int wins = 0;
  int simulations = 0;
  static const c = 1.41;

  PlayerType handleWinner(PlayerType winner);

  double uct(int parentSimulations) {
    return wins / simulations + c * sqrt(log(parentSimulations) / simulations);
  }
}

class _MctsBranch extends _MctsNode {
  final Game game;
  final List<_Lazy<_MctsNode>> children;

  @override
  PlayerType handleWinner(PlayerType winner) {
    simulations++;
    if (game.turn == winner) {
      wins++;
    }
    return winner;
  }

  _MctsBranch(this.game, this.children);
}

class _MctsRandom extends _MctsNode {
  final Outcome<_MctsNode> outcomes;
  final Game game;

  _MctsRandom(this.game, this.outcomes);

  @override
  PlayerType handleWinner(PlayerType winner) {
    simulations++;
    if (game.turn == winner) {
      wins++;
    }
    return winner;
  }
}

class _Lazy<T> {
  T? _result;
  final T Function() _compute;

  _Lazy(this._compute);

  T get result => _result ??= _compute();
}

class _MctsLeaf extends _MctsNode {
  final PlayerType winner;
  _MctsLeaf(this.winner);

  @override
  PlayerType handleWinner(PlayerType winner) {
    assert(winner == this.winner);
    simulations++;
    wins++;
    return winner;
  }
}
