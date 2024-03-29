import 'dart:collection';
import 'dart:math';

import 'package:tyrant_engine/src/algorithm/deck_cache.dart';
import 'package:tyrant_engine/src/gameplay/dice_roller.dart';
import 'package:tyrant_engine/src/model/dice.dart';
import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/model/player.dart';
import 'package:tyrant_engine/src/model/projectile.dart';
import 'package:tyrant_engine/src/model/ship.dart';
import 'package:tyrant_engine/src/model/ship_build.dart';
import 'package:tyrant_engine/src/model/side.dart';
import 'package:tyrant_engine/src/model/weapon.dart';
import 'package:tyrant_engine/src/model/weapon_slot.dart';
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
  final Random random;
  final geometry = Geometry();
  final DiceRoller<num> diceSums;

  RuleEngine(this.random, this.diceSums);

  Phase get startingPhase => Phase.thaw;

  Game initializeGame({
    required List<Weapon> playerDeck,
    required ShipBuild playerBuild,
    required List<Weapon> enemyDeck,
    required ShipBuild enemyBuild,
  }) {
    return Game(
      firstPlayer: dealStart(
          Player(
            ship: initShip(playerBuild, 0),
            hand: emptyHand(),
            deck: deckFromList(playerDeck),
          ),
          playerDeck),
      secondPlayer: dealStart(
          Player(
            ship: initShip(playerBuild, 24),
            hand: emptyHand(),
            deck: deckFromList(enemyDeck),
          ),
          enemyDeck),
      turn: PlayerType.firstPlayer,
      phase: startingPhase,
      round: 0,
      projectiles: [],
    );
  }

  Deck emptyHand() {
    final idSystem = DeckIdSystem();
    return idSystem.zero({});
  }

  Deck deckFromList(List<Weapon> list) {
    final countMap = <Weapon, int>{};
    for (final card in list) {
      if (countMap.containsKey(card)) {
        countMap[card] = countMap[card]! + 1;
      } else {
        countMap[card] = 1;
      }
    }

    final idSystem = DeckIdSystem();
    return idSystem.zero(countMap);
  }

  Ship initShip(ShipBuild build, int x) {
    return Ship(
      build: build,
      x: x,
      y: 0,
      orientation: random.nextInt(8) * 45,
      momentumForward: random.nextInt(7) - 3,
      momentumLateral: random.nextInt(7) - 3,
      momentumRotary: random.nextInt(7) - 3,
    );
  }

  Player dealStart(Player player, List<Weapon> deck) {
    deck = deck.toList();
    for (int i = 0; i < 7; ++i) {
      final cardIdx = random.nextInt(deck.length);
      final card = deck[cardIdx];
      player = player.dealCard(card);
      deck.removeAt(cardIdx);
    }

    return player;
  }

  PlayerType? winner(Game game) {
    if (hasLost(game.firstPlayer)) {
      return PlayerType.secondPlayer;
    } else if (hasLost(game.secondPlayer)) {
      return PlayerType.firstPlayer;
    }

    return null;
  }

  bool hasLost(Player player) {
    if (player.ship.hp <= 0) {
      return true;
    } else if (player.crew.every((c) => c == CrewState.killed)) {
      return true;
    }
    return false;
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
    game = game.copyWith(phase: Phase.regen);
    if (thawIdx >= totalCrew) {
      return Outcome<Game>.single(game);
    }

    final crew = game.currentPlayer.crew;
    if (crew[thawIdx] == CrewState.killed) {
      return Outcome<Game>.single(game);
    }

    return Outcome<Game>.single(
        game.updateCurrentPlayer((player) => player.copyWith(
              crew: player.crew.toList()
                ..remove(thawIdx)
                ..insert(thawIdx, CrewState.active),
            )));
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

    final deckSize = player.deck.size;
    return Outcome<Game>(
        randomOutcomes: player.deck
            .map((card, count) => RandomOutcome<Game>(
                  explanation: () => '${game.turn} draws ${card.name}',
                  probability: count / deckSize,
                  result: game
                      .updateCurrentPlayer(
                        (player) => player.dealCard(card),
                      )
                      .copyWith(
                        phase: Phase.drift,
                      ),
                ))
            .toList());
  }

  Outcome<Game> drift(Game game) {
    final driftedProjectiles = <Projectile>[];
    final impacts = <Projectile>[];

    for (final projectile in game.projectiles) {
      final drifted = driftProjectile(game, projectile);
      if (drifted != null) {
        driftedProjectiles.add(drifted);
      } else {
        impacts.add(projectile);
      }
    }

    final driftsOnly = game
        .updateCurrentPlayer((player) => player.copyWith(
              ship: player.ship.copyWith(
                x: player.ship.x + player.ship.momentumLateral,
                y: player.ship.y + player.ship.momentumForward,
                orientation: geometry.rotateTicks(
                    player.ship.orientation, player.ship.momentumRotary),
              ),
            ))
        .copyWith(
          projectiles: driftedProjectiles,
          phase: Phase.burn,
        );

    var outcome = Outcome.single(driftsOnly);

    final target = game.turn == PlayerType.firstPlayer
        ? PlayerType.secondPlayer
        : PlayerType.firstPlayer;
    int gameHash(Game game) => Object.hashAll([
          game.enemyPlayer.ship.hp,
          game.enemyPlayer.ship.build.port.armor,
          game.enemyPlayer.ship.build.starboard.armor,
        ]);

    var outcomeMap = HashMap<Game, RandomOutcome<Game>>(hashCode: gameHash);
    outcomeMap[driftsOnly] = outcome.randomOutcomes.single;

    for (final impact in impacts) {
      final targetedArc = geometry.targetedArc(
          firing: impact, target: game.playerType(target).ship);
      //final newOutcomes = <RandomOutcome<Game>>[];
      //for (final state in outcome.randomOutcomes) {
      final newMap = HashMap<Game, RandomOutcome<Game>>(hashCode: gameHash);
      for (final state in outcomeMap.values) {
        final dmgStates = applyDamage(
            state.result, target, targetedArc, impact.weapon.damage);

        for (final dmgState in dmgStates.randomOutcomes) {
          final overlapping = newMap[dmgState.result];
          if (overlapping != null) {
            newMap[dmgState.result] = RandomOutcome<Game>(
              explanation: () => '(${overlapping.explanation()}) or'
                  ' (${dmgState.explanation()}, ${state.explanation()})',
              probability: dmgState.probability * state.probability +
                  overlapping.probability,
              result: dmgState.result,
            );
          } else {
            newMap[dmgState.result] = RandomOutcome<Game>(
              explanation: () =>
                  dmgState.explanation() + ', ' + state.explanation(),
              probability: dmgState.probability * state.probability,
              result: dmgState.result,
            );
          }
          //newOutcomes.add(RandomOutcome<Game>(
          //  explanation: () =>
          //      dmgState.explanation() + ', ' + state.explanation(),
          //  probability: dmgState.probability * state.probability,
          //  result: dmgState.result,
          //));
        }
      }

      //outcome = Outcome<Game>(randomOutcomes: newOutcomes);
      outcomeMap = newMap;
    }

    return Outcome(randomOutcomes: outcomeMap.values.toList());
  }

  Outcome<Game> applyDamage(
      Game game, PlayerType target, Quadrant? targetedArc, Dice damage) {
    final targetPlayer = game.playerType(target);
    return diceSums.roll(damage).map((roll) {
      if (targetedArc != null) {
        final side = targetPlayer.ship.build.quadrant(targetedArc);
        if (side.armor! > roll) {
          // TODO: armor bonus effects
          return game.updatePlayer(
            target,
            (enemy) => enemy.copyWith(
              ship: enemy.ship.copyWith(
                build: enemy.ship.build.onQuadrant(targetedArc,
                    (side) => side.copyWith(armor: side.armor! - roll)),
              ),
            ),
          );
        } else {
          // TODO: penetrative effects
          final hpDamage = roll - side.armor!;
          return game.updatePlayer(
            target,
            (enemy) => enemy.copyWith(
              ship: enemy.ship.copyWith(
                hp: enemy.ship.hp - hpDamage,
                build: enemy.ship.build
                    .onQuadrant(targetedArc, (side) => side.copyWith(armor: 0)),
              ),
            ),
          );
        }
      }

      // TODO: hull bonus effects
      final damaged = targetPlayer.copyWith(
        ship: targetPlayer.ship.copyWith(
          hp: targetPlayer.ship.hp - roll,
        ),
      );

      return game.updatePlayer(target, (player) => damaged);
    });
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

    final portion = projectile.weapon.speed! / dist;

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
        return burnActions(game);

      case Phase.shootyShoot:
        return fireWeaponActions(game);
    }
  }

  List<Action> burnActions(Game game) {
    final results = <Action>[];
    // TODO: forward/lateral burns
    final momentumRotary = game.currentPlayer.ship.momentumRotary;
    for (int i = -3; i < 4; ++i) {
      results.add(BurnAction(
        forward: 0,
        lateral: 0,
        rotary: i - momentumRotary,
      ));
    }

    return results;
  }

  List<Action> activateActions(Game game) {
    final actions = <Action>[const EndPhaseAction(Phase.shootyShoot)];
    final player = game.currentPlayer;
    final slotTypesMap = player.ship.build.slotTypesMap();
    for (final weapon in player.hand.uniqueCards) {
      actions.addAll(playableSlots(player.ship.build, slotTypesMap, weapon)
          .map((descriptor) => PlayWeaponAction(
                card: weapon,
                slot: descriptor,
              )));
    }

    return actions;
  }

  List<WeaponSlotDescriptor> playableSlots(
      ShipBuild shipBuild,
      Map<WeaponSlotType, List<WeaponSlotDescriptor>> slotTypesMap,
      Weapon weapon) {
    // PRUNE excessive options of deploying the weapon to different equivalent
    // slots on a quadrant. Doesn't seem to affect gameplay, and increases
    // complexity of minimax.
    final pruneQuadrant = <Quadrant>{};
    final result = <WeaponSlotDescriptor>[];

    final descriptors = slotTypesMap[weapon.type];
    if (descriptors == null) {
      return [];
    }

    for (final descriptor in descriptors) {
      final slot = shipBuild.slot(descriptor);

      if (slot.deployed != null && slot.deployed != weapon ||
          pruneQuadrant.contains(descriptor.quadrant)) {
        continue;
      }

      result.add(descriptor);
      pruneQuadrant.add(descriptor.quadrant);
    }
    return result;
  }

  List<Action> fireWeaponActions(Game game) {
    final actions = <Action>[EndTurnAction(this)];
    final player = game.currentPlayer;

    final target = game.turn == PlayerType.firstPlayer
        ? game.secondPlayer
        : game.firstPlayer;
    final distance = geometry.distance(player.ship, target.ship);
    final arcs = geometry.targetingArcs(
      firing: player.ship,
      target: target.ship,
    );

    for (final quadrant in Quadrant.values) {
      final side = player.ship.build.quadrant(quadrant);
      for (int i = 0; i < side.weapons.length; ++i) {
        final slot = side.weapons[i];
        if (slot.tappedCount >= slot.deployCount) {
          continue;
        }

        final weapon = slot.deployed!;

        final range = weapon.range;
        if (range != null && (distance > range || !arcs.contains(quadrant))) {
          continue;
        }

        if (weapon.ru > player.activeCrew) {
          continue;
        }

        if (player.ru < weapon.ru || player.heat > weapon.oht) {
          continue;
        }

        final desc = WeaponSlotDescriptor(quadrant: quadrant, slotIdx: i);
        actions.add(FireWeaponAction(
          weaponName: weapon.name,
          slot: desc,
          ruleEngine: this,
        ));
      }
    }

    return actions;
  }
}
