import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/model/player.dart';
import 'package:tyrant_engine/src/model/projectile.dart';
import 'package:tyrant_engine/src/model/weapon.dart';
import 'package:tyrant_engine/src/model/weapon_slot_descriptor.dart';
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
}

class BurnAction implements Action {
  BurnAction({
    required this.isLateral,
    required this.amount,
  });

  final bool isLateral;
  final int amount;

  @override
  Outcome<Game> perform(Game game) {
    return Outcome.single(game.updateCurrentPlayer((player) => player.copyWith(
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
        )));
  }

  @override
  String toString() => 'Burn ${isLateral ? "laterally" : "forward"} by $amount';
}

class PlayWeaponAction implements Action {
  final Weapon card;
  final WeaponSlotDescriptor slot;

  PlayWeaponAction({
    required this.card,
    required this.slot,
  });

  @override
  Outcome<Game> perform(Game game) {
    return Outcome.single(game
        .updateCurrentPlayer(
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
      return ruleEngine.applyDamage(weaponTapped, target, weapon.damage);
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
