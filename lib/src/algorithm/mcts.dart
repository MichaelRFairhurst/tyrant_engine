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
    final tree = treeBuilder.visitOutcomes(
        ifPerformed, (child) => treeBuilder.visitAll(child.result, ruleEngine));
    int victories = 0;
    for (int i = 0; i < spec.sampleCount; ++i) {
      final winner = _simulate(tree, 0);
      if (winner == game.turn) {
        victories++;
      }
    }
    return victories;
  }

  PlayerType _simulate(_MctsNode tree, int depth) {
    if (tree is _MctsLeaf) {
      return tree.winner;
    }
    if (tree is _MctsRandom) {
      final next = tree.outcomes.pick(random.nextDouble()).result;
      return _simulate(next, depth + 1);
    }
    if (tree is _MctsBranch) {
      if (depth >= spec.maxDepth) {
        return scorer.score(tree.game) > 0
            ? PlayerType.firstPlayer
            : PlayerType.secondPlayer;
      } else {
        return _simulate(
            tree.children[random.nextInt(tree.children.length)].result,
            depth + 1);
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
  _MctsNode visitOutcomes(Outcome<Game> outcomes,
      _MctsNode Function(RandomOutcome<Game> p1) visitRandomOutcome) {
    return _MctsRandom(outcomes
        .mapWithProbability((ro) => ro.map((_) => visitRandomOutcome(ro))));
  }

  @override
  _MctsNode visitWinner(Game game, PlayerType winner) {
    return _MctsLeaf(winner);
  }
}

class _MctsNode {}

class _MctsBranch implements _MctsNode {
  final Game game;
  final List<_Lazy<_MctsNode>> children;

  _MctsBranch(this.game, this.children);
}

class _MctsRandom implements _MctsNode {
  final Outcome<_MctsNode> outcomes;

  _MctsRandom(this.outcomes);
}

class _Lazy<T> {
  T? _result;
  final T Function() _compute;

  _Lazy(this._compute);

  T get result => _result ??= _compute();
}

class _MctsLeaf implements _MctsNode {
  final PlayerType winner;
  _MctsLeaf(this.winner);
}
