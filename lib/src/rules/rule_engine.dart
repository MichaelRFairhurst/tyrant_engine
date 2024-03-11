import 'dart:math';

import 'package:tyrant_engine/src/algorithm/dice_sums.dart';
import 'package:tyrant_engine/src/model/dice.dart';
import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/model/player.dart';
import 'package:tyrant_engine/src/model/projectile.dart';
import 'package:tyrant_engine/src/model/ship.dart';
import 'package:tyrant_engine/src/model/ship_build.dart';
import 'package:tyrant_engine/src/model/side.dart';
import 'package:tyrant_engine/src/model/weapon.dart';
import 'package:tyrant_engine/src/model/weapon_slot_descriptor.dart';
import 'package:tyrant_engine/src/rules/action.dart';
import 'package:tyrant_engine/src/rules/constants.dart';
import 'package:tyrant_engine/src/rules/geometry.dart';
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
  final geometry = Geometry();
  final diceSums = DiceSums();

  Phase get startingPhase => Phase.thaw;

  Game initializeGame({
    required List<Weapon> playerDeck,
    required ShipBuild playerBuild,
    required List<Weapon> enemyDeck,
    required ShipBuild enemyBuild,
  }) {
    return Game(
      firstPlayer: Player(
        ship: initShip(playerBuild, 0),
        hand: [],
        deck: playerDeck,
      ),
      secondPlayer: Player(
        ship: initShip(playerBuild, 24),
        hand: [],
        deck: enemyDeck,
      ),
      turn: PlayerType.firstPlayer,
      phase: startingPhase,
      round: 0,
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
  }) {
    switch (game.phase) {
      case Phase.thaw:
        return thaw(game);

      case Phase.regen:
        return regen(game);

      case Phase.draw:
        return draw(game);

      case Phase.drift:
        return drift(game);

      case Phase.burn:
      case Phase.activate:
      case Phase.shootyShoot:
        return Outcome.single(game);
    }
  }

  Outcome<Game> thaw(Game game) {
    int thawIdx = startingCrewCount + game.round;
    if (thawIdx >= totalCrew) {
      return Outcome<Game>.single(game);
    }

    final crew = game.currentPlayer.crew;
    if (crew[thawIdx] == CrewState.killed) {
      return Outcome<Game>.single(game);
    }

    return Outcome<Game>.single(game
        .updateCurrentPlayer((player) => player.copyWith(
              crew: player.crew.toList()
                ..remove(thawIdx)
                ..insert(thawIdx, CrewState.active),
            ))
        .copyWith(
          phase: Phase.regen,
        ));
  }

  Outcome<Game> regen(Game game) {
    Side untapAll(Side side) => side.copyWith(
          weapons: side.weapons
              .map((slot) => slot.copyWith(
                    tappedCount: 0,
                  ))
              .toList(),
        );

    return Outcome<Game>.single(game
        .updateCurrentPlayer(
          (player) => player.copyWith(
            ru: fullRU,
            heat: max<int>(0, player.heat - heatRegen),
            ship: player.ship.copyWith(
              build: player.ship.build.on(
                forward: untapAll,
                aft: untapAll,
                port: untapAll,
                starboard: untapAll,
              ),
            ),
          ),
        )
        .copyWith(
          phase: Phase.draw,
        ));
  }

  Outcome<Game> draw(Game game) {
    final player = game.currentPlayer;
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
                result: game
                    .updateCurrentPlayer(
                      (player) => player.copyWith(
                        hand: player.hand.toList()..add(entry.key),
                        deck: player.deck.toList()..remove(entry.key),
                      ),
                    )
                    .copyWith(
                      phase: Phase.drift,
                    ),
              ))
          .toSet(),
    );
  }

  Outcome<Game> drift(Game game) {
    final driftedProjectiles = <Projectile>[];
    final impacts = <Weapon>[];

    for (final projectile in game.projectiles) {
      final drifted = driftProjectile(game, projectile);
      if (drifted != null) {
        driftedProjectiles.add(drifted);
      } else {
        impacts.add(projectile.weapon);
      }
    }

    final driftsOnly = game
        .updateCurrentPlayer((player) => player.copyWith(
              ship: player.ship.copyWith(
                x: player.ship.x + player.ship.momentumLateral,
                y: player.ship.y + player.ship.momentumForward,
              ),
            ))
        .copyWith(
          projectiles: driftedProjectiles,
          phase: Phase.activate,
        );

    var outcome = Outcome.single(driftsOnly);

    final target = game.turn == PlayerType.firstPlayer
        ? PlayerType.secondPlayer
        : PlayerType.firstPlayer;
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

  Outcome<Game> applyDamage(Game game, PlayerType target, Dice damage) {
    final targetPlayer = game.playerType(target);
    return Outcome<Game>(
        randomOutcomes: diceSums.roll(damage, (p, result) {
      // TODO: Properly damage shields/armor/hp, and the proper quadrant!
      final damaged = targetPlayer.copyWith(
        ship: targetPlayer.ship.copyWith(
          hp: targetPlayer.ship.hp - result,
        ),
      );

      return RandomOutcome<Game>(
        probability: p,
        result: game.updatePlayer(target, (player) => damaged),
      );
    }).toSet());
  }

  Projectile? driftProjectile(Game game, Projectile projectile) {
    final Ship target;
    if (projectile.firedBy != game.turn) {
      // Don't drift enemy's projectiles on player's turn
      return projectile;
    }

    if (projectile.firedBy == PlayerType.firstPlayer) {
      target = game.secondPlayer.ship;
    } else {
      target = game.firstPlayer.ship;
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

  List<Action> playerActions(Game game) {
    switch (game.phase) {
      case Phase.thaw:
      case Phase.regen:
      case Phase.draw:
      case Phase.drift:
        return [];

      case Phase.activate:
        return activateActions(game);

      case Phase.burn:
        // TODO: implement burn
        return [];

      case Phase.shootyShoot:
        return fireWeaponActions(game);
    }
  }

  List<Action> activateActions(Game game) {
    final actions = <Action>[const EndPhaseAction(Phase.shootyShoot)];
    final player = game.currentPlayer;
    final deployables = player.ship.build.slotTypesMap();
    for (final weapon in player.hand) {
      final descriptors = deployables[weapon.type];
      if (descriptors == null) {
        continue;
      }

      for (final descriptor in descriptors) {
        final slot = player.ship.build.slot(descriptor);

        if (slot.deployed != null && slot.deployed != weapon) {
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

  List<Action> fireWeaponActions(Game game) {
    final actions = <Action>[EndTurnAction(this)];
    final player = game.currentPlayer;

    final target = game.turn == PlayerType.firstPlayer
        ? game.secondPlayer
        : game.firstPlayer;
    final distance = geometry.distance(player.ship, target.ship);

    for (final quadrant in Quadrant.values) {
      final side = player.ship.build.quadrant(quadrant);
      for (int i = 0; i < side.weapons.length; ++i) {
        final slot = side.weapons[i];
        if (slot.tappedCount >= slot.deployCount) {
          continue;
        }

        final desc = WeaponSlotDescriptor(quadrant: quadrant, slotIdx: i);
        final weapon = slot.deployed!;

        final range = weapon.range;
        if (range != null && distance > range) {
          continue;
        }

        // TODO: check orientation of ship
        if (player.ru < weapon.ru || player.heat > weapon.oht) {
          continue;
        }

        actions.add(FireWeaponAction(
          slot: desc,
          ruleEngine: this,
        ));
      }
    }

    return actions;
  }
}
