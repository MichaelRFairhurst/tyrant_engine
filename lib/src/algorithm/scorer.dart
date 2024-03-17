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

    final minningPlayer = game.playerType(minningPlayerType);
    final maxingPlayer = game.playerType(maxingPlayerType);

    final hpScore = (maxingPlayer.ship.hp - minningPlayer.ship.hp) * 1000.0;

    // We will have to discard something (even though....that's not coded...)
    final discardScore = max(0, (maxingPlayer.hand.size - 7)) * -4000.0;

    final dmgEnRouteScore = game.projectiles.fold<double>(0.0, (sum, p) {
      final dmg = p.weapon.damage.expectedValue;
      final factor = p.firedBy == maxingPlayerType ? 1 : -1;
      return sum + factor * dmg * 850;
    });

    final cool =
        game.turn == maxingPlayerType && game.isAfterRegen ? 0 : heatRegen;
    final crewBoost = game.turn == maxingPlayerType && game.isAfterThaw ? 0 : 1;
    double deploymentsScore = 0;
    for (final side in maxingPlayer.ship.build.allSides) {
      for (final slot in side.weapons) {
        final weapon = slot.deployed;
        if (weapon == null) {
          continue;
        }

        double factor = 1.0;
        factor /=
            5 * max(0, weapon.ru - (maxingPlayer.activeCrew + crewBoost)) + 1;
        factor /= 2 * max(0, maxingPlayer.heat - cool - weapon.oht) + 1;
        if (weapon.range != null &&
            geometry.distance(maxingPlayer.ship, minningPlayer.ship) >
                weapon.range!) {
          factor /= 2;
        }

        deploymentsScore += weapon.damage.expectedValue * factor;
      }
    }

    // heat also affects the deployments score; really just a tie-breaker.
    final heatScore = max(
        0,
        game.turn == maxingPlayerType && game.isAfterRegen
            ? 0
            : -maxingPlayer.heat);

    return hpScore +
        discardScore +
        dmgEnRouteScore +
        deploymentsScore +
        heatScore;
  }
}
