import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/model/player.dart';
import 'package:tyrant_engine/src/model/weapon.dart';
import 'package:tyrant_engine/src/model/weapon_slot_descriptor.dart';
import 'package:tyrant_engine/src/rules/outcomes.dart';

abstract class Action {
  Outcome<Game> perform(Game game, Player player);
}

class BurnAction implements Action {
  BurnAction({
    required this.isLateral,
    required this.amount,
  });

  final bool isLateral;
  final int amount;

  @override
  Outcome<Game> perform(Game game, Player player) {
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

    return Outcome.single(game.updatePlayer(player, playerBurned));
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
  Outcome<Game> perform(Game game, Player player) {
    return Outcome.single(game.updatePlayer(
      player,
      player.copyWith(
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
