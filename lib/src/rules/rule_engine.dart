import 'dart:math';

import 'package:tyrant_engine/src/algorithm/dice_sums.dart';
import 'package:tyrant_engine/src/model/dice.dart';
import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/model/player.dart';
import 'package:tyrant_engine/src/model/projectile.dart';
import 'package:tyrant_engine/src/model/ship.dart';
import 'package:tyrant_engine/src/model/ship_build.dart';
import 'package:tyrant_engine/src/model/weapon.dart';
import 'package:tyrant_engine/src/rules/action.dart';
import 'package:tyrant_engine/src/rules/constants.dart';
import 'package:tyrant_engine/src/rules/outcomes.dart';

enum Phase {
  thaw,
  draw,
  regen,
  drift,
  burn,
  activate,
  shootyShoot,
}

class RuleEngine {
  final random = Random();
  final diceSums = DiceSums();

  Game initializeGame({
    required List<Weapon> playerDeck,
    required ShipBuild playerBuild,
    required List<Weapon> enemyDeck,
    required ShipBuild enemyBuild,
  }) {
    return Game(
      player: Player(
        ship: initShip(playerBuild, 0),
        hand: [],
        deck: playerDeck,
      ),
      enemy: Player(
        ship: initShip(playerBuild, 24),
        hand: [],
        deck: enemyDeck,
      ),
      projectiles: [],
    );
  }

  Ship initShip(ShipBuild build, int x) {
    return Ship(
      build: build,
      x: x,
      y: 0,
      momentumForward: random.nextInt(7) - 3,
      momentumLateral: random.nextInt(7) - 3,
      momentumRotary: random.nextInt(7) - 3,
    );
  }

  Player dealStart(Player player) {
    for (int i = 0; i < 7; ++i) {
      player = deal(player);
    }

    return player;
  }

  Player deal(Player player) {
    final cardIdx = random.nextInt(player.deck.length);
    final card = player.deck[cardIdx];
    return player.copyWith(
      deck: player.deck.toList()..removeAt(cardIdx),
      hand: player.hand.toList()..add(card),
    );
  }

  Outcome<Game> tick({
    required Game game,
    required Player player,
    required Phase phase,
    required int round,
  }) {
    switch (phase) {
      case Phase.thaw:
        return thaw(game, player, round);

      case Phase.regen:
        return regen(game, player);

      case Phase.draw:
        return draw(game, player);

      case Phase.drift:
        return drift(game, player);

      case Phase.burn:
      case Phase.activate:
      case Phase.shootyShoot:
        return Outcome.single(game);
    }
  }

  Outcome<Game> thaw(Game game, Player player, int round) {
    int thawIdx = startingCrewCount + round;
    if (thawIdx >= totalCrew) {
      return Outcome<Game>.single(game);
    }

    if (player.crew[thawIdx] == CrewState.killed) {
      return Outcome<Game>.single(game);
    }

    return Outcome<Game>.single(game.updatePlayer(
        player,
        player.copyWith(
          crew: player.crew.toList()
            ..remove(thawIdx)
            ..insert(thawIdx, CrewState.active),
        )));
  }

  Outcome<Game> regen(Game game, Player player) {
    return Outcome<Game>.single(game.updatePlayer(
      player,
      player.copyWith(
        ru: fullRU,
        heat: max(0, player.heat - heatRegen),
      ),
    ));
  }

  Outcome<Game> draw(Game game, Player player) {
    final uniqueCards = <Weapon, int>{};

    for (final card in player.deck) {
      if (uniqueCards.containsKey(card)) {
        uniqueCards[card] = uniqueCards[card]! + 1;
      } else {
        uniqueCards[card] = 1;
      }
    }

    final deckSize = player.deck.length;
    return Outcome<Game>(
      randomOutcomes: uniqueCards.entries
          .map((entry) => RandomOutcome<Game>(
                probability: entry.value / deckSize,
                result: game.updatePlayer(
                  player,
                  player.copyWith(
                    hand: player.hand.toList()..add(entry.key),
                    deck: player.deck.toList()..remove(entry.key),
                  ),
                ),
              ))
          .toSet(),
    );
  }

  Outcome<Game> drift(Game game, Player player) {
    final driftedProjectiles = <Projectile>[];
    final impacts = <Weapon>[];

    for (final projectile in game.projectiles) {
      final drifted = driftProjectile(game, player, projectile);
      if (drifted != null) {
        driftedProjectiles.add(drifted);
      } else {
        impacts.add(projectile.weapon);
      }
    }

    final driftsOnly = game
        .updatePlayer(
            player,
            player.copyWith(
              ship: player.ship.copyWith(
                x: player.ship.x + player.ship.momentumLateral,
                y: player.ship.y + player.ship.momentumForward,
              ),
            ))
        .copyWith(
          projectiles: driftedProjectiles,
        );

    var outcome = Outcome.single(driftsOnly);

    final target = identical(game.player, player) ? game.enemy : game.player;
    for (final impact in impacts) {
      final newOutcomes = <RandomOutcome<Game>>{};
      for (final state in outcome.randomOutcomes) {
        final dmgStates = applyDamage(state.result, target, impact.damage);

        for (final dmgState in dmgStates.randomOutcomes) {
          newOutcomes.add(RandomOutcome<Game>(
            probability: dmgState.probability * state.probability,
            result: dmgState.result,
          ));
        }
      }

      outcome = Outcome<Game>(randomOutcomes: newOutcomes);
    }

    return outcome;
  }

  Outcome<Game> applyDamage(Game game, Player target, Dice damage) {
    return Outcome<Game>(
        randomOutcomes: diceSums.roll(damage, (p, result) {
      // TODO: Properly damage shields/armor/hp, and the proper quadrant!
      final damaged = target.copyWith(
        ship: target.ship.copyWith(
          hp: target.ship.hp - result,
        ),
      );

      return RandomOutcome<Game>(
        probability: p,
        result: game.updatePlayer(target, damaged),
      );
    }).toSet());
  }

  Projectile? driftProjectile(Game game, Player player, Projectile projectile) {
    final Ship target;
    if (projectile.friendly) {
      target = game.enemy.ship;

      if (identical(player, game.enemy)) {
        // Don't drift player's projectiles on enemy's turn
        return projectile;
      }
    } else {
      target = game.player.ship;

      if (identical(player, game.player)) {
        // Don't drift enemy's projectiles on player's turn
        return projectile;
      }
    }

    final distX = target.x - projectile.x;
    final distY = target.y - projectile.y;
    final dist = sqrt(distX * distX + distY * distY);
    final portion = dist / projectile.weapon.speed!;

    if (portion >= 1) {
      return null;
    }

    final moveX = distX * portion;
    final moveY = distY * portion;

    return projectile.copyWith(
      x: projectile.x + moveX,
      y: projectile.y + moveY,
    );
  }

  List<Action> playerActions(Game game, Player player, Phase phase) {
    switch (phase) {
      case Phase.thaw:
      case Phase.regen:
      case Phase.draw:
      case Phase.drift:
        return [];

      case Phase.activate:
        return activateActions(game, player);

      case Phase.burn:
      case Phase.shootyShoot:
        throw 'unimplemented';
    }
  }

  List<PlayWeaponAction> activateActions(Game game, Player player) {
    final actions = <PlayWeaponAction>[];
    final deployables = player.ship.build.slotTypesMap();
    for (final weapon in player.hand) {
      final descriptors = deployables[weapon.type];
      if (descriptors == null) {
        continue;
      }

      for (final descriptor in descriptors) {
        final slot = player.ship.build.slot(descriptor);

        if (slot.weapon != null && slot.weapon != weapon) {
          continue;
        }

        actions.add(PlayWeaponAction(
          card: weapon,
          slot: descriptor,
        ));
      }
    }

    return actions;
  }
}
