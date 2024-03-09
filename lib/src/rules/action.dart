import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/model/player.dart';
import 'package:tyrant_engine/src/model/projectile.dart';
import 'package:tyrant_engine/src/model/weapon.dart';
import 'package:tyrant_engine/src/model/weapon_slot_descriptor.dart';
import 'package:tyrant_engine/src/rules/outcomes.dart';
import 'package:tyrant_engine/src/rules/rule_engine.dart';

abstract class Action {
  Outcome<Game> perform(Game game, PlayerType player);
}

class EndPhaseAction implements Action {
  const EndPhaseAction();

  @override
  Outcome<Game> perform(Game game, PlayerType player) {
    return Outcome.single(game);
  }
}

class BurnAction implements Action {
  BurnAction({
    required this.isLateral,
    required this.amount,
  });

  final bool isLateral;
  final int amount;

  @override
  Outcome<Game> perform(Game game, PlayerType pType) {
    final player = game.playerType(pType);
    final playerBurned = player.copyWith(
      ru: player.ru + amount,
      heat: player.heat + amount,
      ship: player.ship.copyWith(
        momentumForward: isLateral
            ? player.ship.momentumForward
            : player.ship.momentumForward + amount,
        momentumLateral: isLateral
            ? player.ship.momentumLateral + amount
            : player.ship.momentumLateral,
      ),
    );

    return Outcome.single(game.updatePlayer(pType, (_) => playerBurned));
  }
}

class PlayWeaponAction implements Action {
  final Weapon card;
  final WeaponSlotDescriptor slot;

  PlayWeaponAction({
    required this.card,
    required this.slot,
  });

  @override
  Outcome<Game> perform(Game game, PlayerType player) {
    return Outcome.single(game.updatePlayer(
      player,
      (player) => player.copyWith(
        hand: player.hand.toList()..remove(card),
        ship: player.ship.copyWith(
          build: player.ship.build.onSlot(
            slot,
            (slot) => slot.copyWith(
              deployCount: slot.deployCount + 1,
              deployed: card,
            ),
          ),
        ),
      ),
    ));
  }
}

class FireWeaponAction implements Action {
  final WeaponSlotDescriptor slot;
  final RuleEngine ruleEngine;

  FireWeaponAction({
    required this.slot,
    required this.ruleEngine,
  });

  @override
  Outcome<Game> perform(Game game, PlayerType pType) {
    final player = game.playerType(pType);
    final weapon = player.ship.build.slot(slot).deployed!;
    final weaponTapped = game.updatePlayer(
        pType,
        (player) => player.copyWith(
              ru: player.ru - weapon.ru,
              heat: player.heat + weapon.heat,
              ship: player.ship.copyWith(
                build: player.ship.build.onSlot(
                  slot,
                  (slot) => slot.copyWith(
                    tappedCount: slot.tappedCount + 1,
                  ),
                ),
              ),
            ));

    if (weapon.speed == null) {
      final target =
          pType == PlayerType.player ? PlayerType.enemy : PlayerType.player;
      return ruleEngine.applyDamage(weaponTapped, target, weapon.damage);
    } else {
      return Outcome.single(weaponTapped.copyWith(
        projectiles: game.projectiles.toList()
          ..add(Projectile(
            // TODO: handle half distance on first shooty
            x: player.ship.x.toDouble(),
            y: player.ship.y.toDouble(),
            friendly: pType == PlayerType.player,
            weapon: weapon,
          )),
      ));
    }
  }
}
