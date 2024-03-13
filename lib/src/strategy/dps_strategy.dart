import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/model/weapon.dart';
import 'package:tyrant_engine/src/rules/action.dart';
import 'package:tyrant_engine/src/rules/constants.dart';
import 'package:tyrant_engine/src/rules/geometry.dart';
import 'package:tyrant_engine/src/strategy/strategy.dart';

class DpsStrategy extends Strategy {
  final geometry = Geometry();

  @override
  String get name => 'Simple DPS strategy';

  @override
  Action pickAction(Game game, List<Action> actions) {
    return actions.reduce((a, b) => higherDps(game, a, b));
  }

  Action higherDps(Game game, Action a, Action b) {
    if (actionDps(game, a) > actionDps(game, b)) {
      return a;
    } else {
      return b;
    }
  }

  double actionDps(Game game, Action action) {
    if (action is PlayWeaponAction) {
      if (game.currentPlayer.activeCrew < action.card.ru) {
        return 0;
      }

      if (action.card.range != null &&
          geometry.distance(game.currentPlayer.ship, game.enemyPlayer.ship) >
              action.card.range!) {
        return 0;
      }

      return dps(action.card);
    }

    if (action is FireWeaponAction) {
      final weapon = game.currentPlayer.ship.build.slot(action.slot);
      return dps(weapon.deployed!);
    }

    return -1.0;
  }

  double dps(Weapon weapon) {
    final ruLimitedRate = weapon.ru == 0 ? 0 : fullRU / weapon.ru;
    final heatLimitedRate = weapon.heat == 0 ? 0 : heatRegen / weapon.heat;
    final hypotheticalFireRate = ruLimitedRate + heatLimitedRate;
    return weapon.damage.expectedValue * hypotheticalFireRate;
  }
}
