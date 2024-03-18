import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/model/player.dart';
import 'package:tyrant_engine/src/model/projectile.dart';
import 'package:tyrant_engine/src/model/weapon.dart';
import 'package:tyrant_engine/src/model/weapon_slot_descriptor.dart';
import 'package:tyrant_engine/src/rules/geometry.dart';
import 'package:tyrant_engine/src/rules/outcomes.dart';
import 'package:tyrant_engine/src/rules/rule_engine.dart';

abstract class Action {
  Outcome<Game> perform(Game game);
}

class EndTurnAction implements Action {
  const EndTurnAction(this.ruleEngine);

  final RuleEngine ruleEngine;

  @override
  Outcome<Game> perform(Game game) {
    return Outcome.single(game.copyWith(
      turn: game.turn == PlayerType.firstPlayer
          ? PlayerType.secondPlayer
          : PlayerType.firstPlayer,
      round: game.turn == PlayerType.secondPlayer ? game.round + 1 : game.round,
      phase: ruleEngine.startingPhase,
    ));
  }

  @override
  int get hashCode => (EndTurnAction).hashCode;

  @override
  bool operator ==(Object? other) => other is EndTurnAction;
}

class EndPhaseAction implements Action {
  const EndPhaseAction(this.nextPhase);

  final Phase nextPhase;

  @override
  Outcome<Game> perform(Game game) {
    return Outcome.single(game.copyWith(
      phase: nextPhase,
    ));
  }

  @override
  int get hashCode => (EndPhaseAction).hashCode;

  @override
  bool operator ==(Object? other) => other is EndPhaseAction;
}

class BurnAction implements Action {
  BurnAction({
    required this.lateral,
    required this.forward,
    required this.rotary,
  });

  final int forward;
  final int lateral;
  final int rotary;

  @override
  int get hashCode => Object.hashAll([forward, lateral, rotary]);

  @override
  bool operator ==(Object? other) =>
      other is BurnAction &&
      forward == other.forward &&
      lateral == other.lateral &&
      rotary == other.rotary;

  @override
  Outcome<Game> perform(Game game) {
    return Outcome.single(game
        .updateCurrentPlayer((player) => player.copyWith(
              ru: player.ru - lateral.abs() - forward.abs() - rotary.abs(),
              heat: player.heat + forward.abs() + lateral.abs(),
              ship: player.ship.copyWith(
                momentumForward: player.ship.momentumForward + forward,
                momentumLateral: player.ship.momentumLateral + lateral,
                momentumRotary: player.ship.momentumRotary + rotary,
              ),
            ))
        .copyWith(
          phase: Phase.activate,
        ));
  }

  @override
  String toString() => 'Burn lateral $lateral, rotary $rotary';
}

class PlayWeaponAction implements Action {
  final Weapon card;
  final WeaponSlotDescriptor slot;

  PlayWeaponAction({
    required this.card,
    required this.slot,
  });

  @override
  int get hashCode => Object.hash(card, slot);

  @override
  bool operator ==(Object? other) =>
      other is PlayWeaponAction && card == other.card && slot == other.slot;

  @override
  Outcome<Game> perform(Game game) {
    assert(game.currentPlayer.ship.build.allSides.fold<int>(
            0,
            (sum, side) =>
                sum +
                side.weapons.fold<int>(0, (sum, w) => sum + w.deployCount)) <=
        game.round + 1);
    return Outcome.single(game
        .updateCurrentPlayer(
          (player) => player.playFromHand(card).copyWith(
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
        )
        .copyWith(
          phase: Phase.shootyShoot,
        ));
  }

  @override
  String toString() => 'Play weapon ${card.name} onto slot $slot';
}

class FireWeaponAction implements Action {
  final String weaponName;
  final WeaponSlotDescriptor slot;
  final RuleEngine ruleEngine;

  FireWeaponAction({
    required this.weaponName,
    required this.slot,
    required this.ruleEngine,
  });

  @override
  int get hashCode => Object.hash(weaponName, slot.quadrant);

  @override
  bool operator ==(Object? other) =>
      other is FireWeaponAction &&
      other.weaponName == weaponName &&
      other.slot.quadrant == slot.quadrant;

  @override
  Outcome<Game> perform(Game game) {
    final player = game.currentPlayer;
    final weapon = player.ship.build.slot(slot).deployed!;
    final weaponTapped = game.updateCurrentPlayer((player) => player.copyWith(
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
      final target = game.turn == PlayerType.firstPlayer
          ? PlayerType.secondPlayer
          : PlayerType.firstPlayer;
      final targetedArc = Geometry().targetedArc(
        target: game.enemyPlayer.ship,
        firing: player.ship,
      );
      return ruleEngine.applyDamage(
          weaponTapped, target, targetedArc, weapon.damage);
    } else {
      return Outcome.single(weaponTapped.copyWith(
        projectiles: game.projectiles.toList()
          ..add(Projectile(
            // TODO: handle half distance on first shooty
            x: player.ship.x.toDouble(),
            y: player.ship.y.toDouble(),
            firedBy: game.turn,
            weapon: weapon,
          )),
      ));
    }
  }

  @override
  String toString() => 'Fire weapon $weaponName (from slot $slot)';
}
