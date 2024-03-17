import 'package:tyrant_engine/src/algorithm/scorer.dart';
import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/rules/action.dart';
import 'package:tyrant_engine/src/algorithm/transition_table.dart';

abstract class FinalActionTable<G, A> {
  double shortcutActionScore(
      G game, A action, int untilTurn, double Function() compute);
}

class GameFinalActionTable implements FinalActionTable<Game, Action> {
  final Scorer<Game> scorer;

  var _newTable = _FinalActionTransitionTable();
  var _oldTable = _FinalActionTransitionTable();

  GameFinalActionTable(this.scorer);

  void gc() {
    _oldTable = _newTable;
    _newTable = _FinalActionTransitionTable();
  }

  @override
  double shortcutActionScore(
      Game game, Action action, int untilTurn, double Function() compute) {
    //if (action is! FireWeaponAction && action is! PlayWeaponAction) {
    //  return compute();
    //}

    if (game.turnCount != untilTurn - 2) {
      return compute();
    }

    final prevScore = scorer.score(game);
    final diff = _newTable.putIfAbsent(game, action, () {
      final oldResult = _oldTable.lookup(game, action);
      return oldResult ?? (compute() - prevScore);
    });

    //print('diff for $action, ${hashG(game)} is $diff, returning ${prevScore + diff}');
    assert(() {
      final realScore = compute();
      final ourScore = prevScore + diff;

      if (realScore + 0.01 < ourScore || realScore - 0.01 > ourScore) {
        print(game);
        throw 'Unequal, for $action, ${_newTable.hashG(game)}: $realScore and $ourScore';
      }
      return true;
    }());
    return prevScore + diff;
  }
}

class _FinalActionTransitionTable
    extends TransitionTable<Game, Action, double> {
  @override
  int hashG(Game g) {
    return Object.hashAll([
      g.distanceX,
      g.distanceY,
      g.enemyPlayer.ship.build.port.armor,
      g.enemyPlayer.ship.build.starboard.armor,
      g.currentPlayer.ru,
      g.currentPlayer.heat,
      g.currentPlayer.activeCrew,
      g.currentPlayer.ship.build,
    ]);
  }

  @override
  bool equalsG(Game a, Game b) {
    return a.distanceX == b.distanceX &&
        a.distanceY == b.distanceY &&
        a.enemyPlayer.ship.build.port.armor ==
            b.enemyPlayer.ship.build.port.armor &&
        a.enemyPlayer.ship.build.starboard.armor ==
            b.enemyPlayer.ship.build.starboard.armor &&
        a.currentPlayer.ru == b.currentPlayer.ru &&
        a.currentPlayer.heat == b.currentPlayer.heat &&
        a.currentPlayer.activeCrew == b.currentPlayer.activeCrew &&
        a.currentPlayer.ship.build == b.currentPlayer.ship.build;
  }
}
