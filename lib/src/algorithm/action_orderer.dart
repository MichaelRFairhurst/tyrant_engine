import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/rules/action.dart';
import 'package:tyrant_engine/src/rules/constants.dart';
import 'package:tyrant_engine/src/rules/geometry.dart';

class ActionOrderer {
  final _sorted = <List<Action>>[[]];
  final _transitions = <Map<_GameAction, int>>[{}];
  final geometry = Geometry();

  List<Action> order(Game game, List<Action> actions) {
    var pointer = 0;
    for (final action in actions) {
      final gAct = _GameAction(game, action);
      pointer = _transitions[pointer].putIfAbsent(gAct, () {
        final list = _sorted[pointer];
        final score = scoreAction(game, action);
        final resultList = <Action>[];
        bool added = false;
        // TODO: sorted insert for O(log n)
        for (int i = 0; i < list.length; ++i) {
          if (!added && scoreAction(game, list[i]) < score) {
            resultList.add(action);
            added = true;
          }
          resultList.add(list[i]);
        }
        if (!added) {
          resultList.add(action);
        }

        final newId = _sorted.length;
        _sorted.add(resultList);
        _transitions.add({});

        return newId;
      });
    }

    assert(_sorted[pointer].length == actions.length);

    assert(() {
      final result = _sorted[pointer];
      final resorted = actions.toList()
        ..sort((a, b) => -scoreAction(game, a).compareTo(scoreAction(game, b)));

      for (int i = 0; i < result.length; ++i) {
        if (_GameAction(game, result[i]) != _GameAction(game, resorted[i])) {
          print(result);
          print(resorted);
          return false;
        }
      }

      return true;
    }());
    return _sorted[pointer];
  }

  int scoreAction(Game game, Action action) {
    if (action is EndPhaseAction || action is EndTurnAction) {
      return -1;
    }

    if (action is FireWeaponAction) {
      final weapon = game.currentPlayer.ship.build.slot(action.slot);
      return 15 - weapon.deployed!.oht;
    }

    if (action is PlayWeaponAction) {
      final currentPlayer = game.currentPlayer;
      if (currentPlayer.activeCrew >= action.card.ru &&
          currentPlayer.heat <= action.card.oht) {
        if (action.card.range == null) {
          return (1 + fullRU * action.card.damage.expectedValue / 2).round();
        } else if (geometry.range(game) <= action.card.range!) {
          return (1 + fullRU * action.card.damage.expectedValue).round();
        }
      }
      return fullRU - action.card.ru;
    }

    if (action is BurnAction) {
      final ship = game.currentPlayer.ship;
      // Prefer getting stationary
      if (ship.momentumRotary + action.rotary == 0) {
        return 10;
      }
      // Prefer bold turns
      return (ship.momentumRotary + action.rotary).abs();
    }

    throw 'unimplemented';
  }
}

class _GameAction {
  _GameAction(this.game, this.action);
  final Game game;
  final Action action;

  @override
  int get hashCode {
    final myAction = action;

    if (myAction is PlayWeaponAction) {
      return Object.hashAll([
        PlayWeaponAction,
        game.currentPlayer.activeCrew,
        game.currentPlayer.heat,
        game.distanceX,
        game.distanceY,
        myAction.card,
        myAction.slot,
      ]);
    }

    if (myAction is FireWeaponAction) {
      final myWeapon = game.currentPlayer.ship.build.slot(myAction.slot);

      return Object.hash(FireWeaponAction, myWeapon.hashCode);
    }

    if (myAction is BurnAction) {
      return Object.hashAll([
        BurnAction,
        game.currentPlayer.ship.momentumRotary,
        myAction.lateral,
      ]);
    }

    if (myAction is EndPhaseAction) {
      return (EndPhaseAction).hashCode;
    }

    if (myAction is EndTurnAction) {
      return (EndTurnAction).hashCode;
    }

    throw 'unimplemented';
  }

  @override
  bool operator ==(Object other) {
    if (other is! _GameAction) {
      return false;
    }

    final myAction = action;
    final otherAction = other.action;

    if (myAction is PlayWeaponAction) {
      if (otherAction is! PlayWeaponAction) {
        return false;
      }

      return game.currentPlayer.activeCrew ==
              other.game.currentPlayer.activeCrew &&
          game.currentPlayer.heat == other.game.currentPlayer.heat &&
          myAction.card.ru == otherAction.card.ru &&
          game.distanceX == other.game.distanceX &&
          game.distanceY == other.game.distanceY;
    }

    if (myAction is FireWeaponAction) {
      if (otherAction is! FireWeaponAction) {
        return false;
      }

      final myWeapon = game.currentPlayer.ship.build.slot(myAction.slot);
      final otherWeapon =
          other.game.currentPlayer.ship.build.slot(myAction.slot);

      return myWeapon == otherWeapon;
    }

    if (myAction is BurnAction) {
      if (otherAction is! BurnAction) {
        return false;
      }

      return myAction.rotary == otherAction.rotary &&
          game.currentPlayer.ship.momentumRotary ==
              other.game.currentPlayer.ship.momentumRotary;
    }

    if (myAction is EndPhaseAction) {
      return otherAction is EndPhaseAction;
    }

    if (myAction is EndTurnAction) {
      return otherAction is EndTurnAction;
    }

    throw 'unimplemented';
  }
}
