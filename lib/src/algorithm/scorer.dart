import 'dart:math';

import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/model/player.dart';
import 'package:tyrant_engine/src/rules/constants.dart';
import 'package:tyrant_engine/src/rules/geometry.dart';

abstract class Scorer<T> {
  double score(T t);
  double get alphaBetaExpansionRoot;
  double get alphaBetaExpansionChance;
}

class HpDifferentialScorer implements Scorer<Game> {
  HpDifferentialScorer(this.maxingPlayerType);

  final geometry = Geometry();
  final PlayerType maxingPlayerType;

  @override
  double get alphaBetaExpansionRoot => 3 * 1000;

  @override
  double get alphaBetaExpansionChance => 7000;

  @override
  double score(Game game) {
    final minningPlayerType = maxingPlayerType == PlayerType.firstPlayer
        ? PlayerType.secondPlayer
        : PlayerType.firstPlayer;

    return scoreSinglePlayer(maxingPlayerType, game) -
        scoreSinglePlayer(minningPlayerType, game);
  }

  double totalScoreCurrentPlayer(Game game) {
    final negativePlayerType = game.turn == PlayerType.firstPlayer
        ? PlayerType.secondPlayer
        : PlayerType.firstPlayer;

    return scoreSinglePlayer(game.turn, game) -
        scoreSinglePlayer(negativePlayerType, game);
  }

  double scoreSinglePlayer(PlayerType pType, Game game) {
    final player = game.playerType(pType);
    final hpScore = player.ship.hp * 1000.0;

    final armorScore = player.ship.build.port.armor! +
        player.ship.build.starboard.armor! * 800;

    // We will have to discard something (even though....that's not coded...)
    final discardScore = max(0, (player.hand.size - 7)) * -4000.0;

    // heat also affects the deployments score; really just a tie-breaker.
    final heatScore = max(
        0,
        game.turn == maxingPlayerType && game.isAfterRegen
            ? -player.heat + heatRegen
            : -player.heat);

    final rotationScore = -player.ship.momentumRotary.abs() * 10;

    return hpScore +
        armorScore +
        discardScore +
        dmgEnRouteScore(pType, game) +
        deploymentsScore(pType, game) +
        heatScore +
        rotationScore;
  }

  double dmgEnRouteScore(PlayerType player, Game game) => game.projectiles
          .where((p) => p.firedBy == player)
          .fold<double>(0.0, (sum, p) {
        final dmg = p.weapon.damage.expectedValue;
        return sum + dmg * 850;
      });

  double deploymentsScore(PlayerType pType, Game game) {
    final player = game.playerType(pType);
    final enemy = pType == PlayerType.firstPlayer
        ? PlayerType.secondPlayer
        : PlayerType.firstPlayer;
    final enemyShip = game.playerType(enemy).ship;

    final cool =
        game.turn == maxingPlayerType && game.isAfterRegen ? 0 : heatRegen;
    final crewBoost = game.turn == maxingPlayerType && game.isAfterThaw ? 0 : 1;

    double deploymentsScore = 0;
    for (final side in player.ship.build.allSides) {
      for (final slot in side.weapons) {
        final weapon = slot.deployed;
        if (weapon == null) {
          continue;
        }

        double factor = 1.0;
        factor /= 5 * max(0, weapon.ru - (player.activeCrew + crewBoost)) + 1;
        factor /= 2 * max(0, player.heat - cool - weapon.oht) + 1;
        if (weapon.range != null &&
            geometry.distance(player.ship, enemyShip) > weapon.range!) {
          factor /= 2;
        }

        deploymentsScore += weapon.damage.expectedValue * factor;
      }
    }

    return deploymentsScore;
  }
}
