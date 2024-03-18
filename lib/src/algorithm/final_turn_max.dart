import 'package:collection/collection.dart' show IterableEquality, SetEquality;
import 'package:tyrant_engine/src/algorithm/scorer.dart';
import 'package:tyrant_engine/src/algorithm/transposition_table.dart';
import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/model/player.dart';
import 'package:tyrant_engine/src/rules/action.dart';
import 'package:tyrant_engine/src/rules/geometry.dart';
import 'package:tyrant_engine/src/rules/outcomes.dart';
import 'package:tyrant_engine/src/rules/rule_engine.dart';

class FinalTurnMax {
  final _table = TranspositionTable<Game, double>(FinalTurnEquality());
  final _transitions =
      TranspositionTable<Game, TranspositionTable<Action, double>>(
          FinalTurnEquality());
  final RuleEngine ruleEngine;
  final HpDifferentialScorer scorer;

  FinalTurnMax(this.ruleEngine, this.scorer);

  double opposingPlayersMax(Game game) {
    final baseScore = scorer.score(game);
    final firstTurnDiff = currentPlayerMaxDiff(game);
    final nextPlayer =
        ruleEngine.drift(game).randomOutcomes.single.result.copyWith(
              phase: Phase.regen,
              turn: game.turn == PlayerType.firstPlayer
                  ? PlayerType.secondPlayer
                  : PlayerType.firstPlayer,
              round: game.turn == PlayerType.firstPlayer
                  ? game.round
                  : game.round + 1,
            );
    final nextPlayerDraw = ruleEngine
        .regen(ruleEngine.thaw(nextPlayer).randomOutcomes.single.result)
        .randomOutcomes
        .single
        .result;
    final secondTurnDiff = currentPlayerMaxDiff(nextPlayerDraw);
    if (game.turn == scorer.maxingPlayerType) {
      //print(
      //    'base score $baseScore first turn diff: $firstTurnDiff second turn diff: -$secondTurnDiff');
      return baseScore + firstTurnDiff - secondTurnDiff;
    } else {
      //print(
      //    'base score $baseScore first turn diff: -$firstTurnDiff second turn diff: $secondTurnDiff');
      return baseScore - firstTurnDiff + secondTurnDiff;
    }
  }

  double currentPlayerMaxDiff(Game game) {
    final preMoveScore = scorer.totalScoreCurrentPlayer(game);

    //print(FinalTurnEquality().hash(game));
    return _table.putIfAbsent(game, () {
      assert(game.phase == Phase.draw);

      // The value of using a current card is constant
      final uchMax = usingCurrentHandMax(game, game.turn);

      // But for any card we can draw, we may beat the uch max.
      final principalVariation = drawNewCardMax(game, uchMax, game.turn);

      //print(game.turn);
      //principalVariation.trace(20);

      //print(FinalTurnEquality().hash(game));
      //print('finalScore $finalScore - premove $preMoveScore');
      return principalVariation.score - preMoveScore;
    });
  }

  PrincipalVariation cacheScoreDiff(
      Game game, PlayerType turn, PrincipalVariation Function() score) {
    final preMoveScore = scorer.totalScoreCurrentPlayer(game);

    final diff = _table.putIfAbsent(game, () {
      return score().score - preMoveScore;
    });

    return PrincipalVariationCached(preMoveScore + diff, score);
  }

  PrincipalVariationAction usingCurrentHandMax(Game game, PlayerType turn) {
    final actions = ruleEngine.activateActions(game);
    return actionsMax(game, actions, turn);
  }

  PrincipalVariation drawNewCardMax(
      Game game, PrincipalVariationAction uchMax, PlayerType turn) {
    final deck = game.currentPlayer.deck;
    final ship = game.currentPlayer.ship.build;
    final deckSize = deck.size;
    final slotTypesMap = ship.slotTypesMap();

    final outcomes = <RandomOutcome<PrincipalVariation>>[];
    for (final entry in deck.countMap.entries) {
      final weapon = entry.key;
      final playToSlotActions = ruleEngine
          .playableSlots(game.currentPlayer.ship.build, slotTypesMap, weapon)
          .map((slot) => PlayWeaponAction(card: weapon, slot: slot));
      final dealtCard =
          game.updateCurrentPlayer((player) => player.dealCard(weapon));
      final principalVariation = playToSlotActions.isEmpty
          ? uchMax
          : uchMax.max(actionsMax(dealtCard, playToSlotActions, turn));
      final probability = entry.value / deckSize;
      outcomes.add(RandomOutcome<PrincipalVariation>(
        explanation: () => 'draw ${weapon.name}',
        probability: probability,
        result: principalVariation,
      ));
    }

    final outcome = Outcome<PrincipalVariation>(randomOutcomes: outcomes);
    return PrincipalVariationRandom(
      outcome.map((v) => v.score).expectedValue,
      outcome,
    );
  }

  PrincipalVariation midTurnMax(Game game, PlayerType turn) {
    if (game.turn != turn) {
      return PrincipalVariationLeaf(
          -scorer.totalScoreCurrentPlayer(game), game);
    }
    return cacheScoreDiff(game, turn, () {
      final outcomes = ruleEngine.tick(game: game);
      if (outcomes.randomOutcomes.length > 1) {
        return outcomesMax(outcomes, turn);
      }

      game = outcomes.randomOutcomes.single.result;

      // There is no value to burns if you aren't examining future moves.
      if (game.turn == Phase.burn) {
        return outcomesMax(
            BurnAction(lateral: 0, forward: 0, rotary: 0).perform(game), turn);
      }

      final actions = ruleEngine.playerActions(game);
      if (actions.isEmpty) {
        return midTurnMax(game, turn);
      } else {
        return actionsMax(game, ruleEngine.playerActions(game), turn);
      }
    });
  }

  PrincipalVariationAction actionsMax(
      Game game, Iterable<Action> actions, PlayerType turn) {
    PrincipalVariationAction? principalVariation;
    for (final action in actions) {
      final outcome = outcomesMax(action.perform(game), turn);
      final variation =
          PrincipalVariationAction(outcome.score, action, outcome);
      if (principalVariation == null) {
        principalVariation = variation;
      } else {
        principalVariation = principalVariation.max(variation);
      }
    }

    return principalVariation!;
  }

  PrincipalVariationRandom outcomesMax(Outcome<Game> outcome, PlayerType turn) {
    final outcomes = outcome.map((o) => midTurnMax(o, turn));
    return PrincipalVariationRandom(
        outcomes.map((v) => v.score).expectedValue, outcomes);
  }
}

abstract class PrincipalVariation {
  double get score;

  void trace(int depth);
}

class PrincipalVariationAction implements PrincipalVariation {
  @override
  final double score;
  final Action action;
  final PrincipalVariation next;

  PrincipalVariationAction(this.score, this.action, this.next);

  PrincipalVariationAction max(PrincipalVariationAction other) {
    if (other.score > score) {
      return other;
    }
    return this;
  }

  @override
  void trace(int depth) {
    print('${" " * depth}then perform $action');
    next.trace(depth);
  }
}

class PrincipalVariationLeaf implements PrincipalVariation {
  @override
  final double score;
  final Game game;
  PrincipalVariationLeaf(this.score, this.game);

  @override
  void trace(int depth) {
    print(
        '${" " * depth}$score hp ${game.currentPlayer.ship.hp}hp to ${game.enemyPlayer.ship.hp}');
    print(
        '${" " * depth}armor ${game.currentPlayer.ship.build.starboard.armor} ${game.currentPlayer.ship.build.port.armor}');
    print(
        '${" " * depth}armor ${game.enemyPlayer.ship.build.starboard.armor} ${game.enemyPlayer.ship.build.port.armor}');
  }
}

class PrincipalVariationCached implements PrincipalVariation {
  @override
  final double score;
  final PrincipalVariation Function() compute;
  PrincipalVariationCached(this.score, this.compute);

  @override
  void trace(int depth) {
    print('${" " * depth}cached $score');
    final computed = compute();
    print('${" " * depth}computed: ${computed.score}');
    computed.trace(depth);
  }
}

class PrincipalVariationRandom implements PrincipalVariation {
  @override
  final double score;
  final Outcome<PrincipalVariation> outcomes;

  PrincipalVariationRandom(this.score, this.outcomes);

  @override
  void trace(int depth) {
    for (int i = 0; i < outcomes.randomOutcomes.length; ++i) {
      final ro = outcomes.randomOutcomes[i];
      final explanation = ro.explanation();
      final prob = ro.probability;
      final result = ro.result;
      print('${" " * depth}Probability $prob $explanation:');
      result.trace(depth + 1);
    }
  }
}

class FinalTurnEquality implements Equality<Game> {
  @override
  int hash(Game game) {
    game = driftGame(game);

    return Object.hashAll([
      game.phase,
      game.turnCount,
      game.distanceX,
      game.distanceY,
      game.enemyPlayer.ship.build.port.armor,
      game.enemyPlayer.ship.build.starboard.armor,
      ...Geometry().targetingArcs(
          firing: game.currentPlayer.ship, target: game.enemyPlayer.ship),
      Geometry().targetedArc(
          firing: game.currentPlayer.ship, target: game.enemyPlayer.ship),
      game.currentPlayer.ru,
      game.currentPlayer.heat,
      game.currentPlayer.activeCrew,
      game.currentPlayer.ship.build,
      game.currentPlayer.ship.orientation,
      game.currentPlayer.ship.momentumRotary,
      ...game.projectiles.where((p) => p.firedBy == game.turn)
    ]);
  }

  Game driftGame(Game game) {
    if (game.phase == Phase.regen ||
        game.phase == Phase.thaw ||
        game.phase == Phase.draw) {
      return game.updateCurrentPlayer(
        (player) => player.copyWith(
          ship: player.ship.copyWith(
            orientation: Geometry().rotateTicks(
                player.ship.orientation, player.ship.momentumRotary),
          ),
        ),
      );
    }
    return game;
  }

  @override
  bool equals(Game a, Game b) {
    a = driftGame(a);
    b = driftGame(b);
    return a.phase == b.phase &&
        a.turnCount == b.turnCount &&
        a.distanceX == b.distanceX &&
        a.distanceY == b.distanceY &&
        a.enemyPlayer.ship.build.port.armor ==
            b.enemyPlayer.ship.build.port.armor &&
        a.enemyPlayer.ship.build.starboard.armor ==
            b.enemyPlayer.ship.build.starboard.armor &&
        const SetEquality().equals(
            Geometry().targetingArcs(
                firing: a.currentPlayer.ship, target: a.enemyPlayer.ship),
            Geometry().targetingArcs(
                firing: b.currentPlayer.ship, target: b.enemyPlayer.ship)) &&
        Geometry().targetedArc(
                firing: a.currentPlayer.ship, target: a.enemyPlayer.ship) ==
            Geometry().targetedArc(
                firing: b.currentPlayer.ship, target: b.enemyPlayer.ship) &&
        a.currentPlayer.ru == b.currentPlayer.ru &&
        a.currentPlayer.heat == b.currentPlayer.heat &&
        a.currentPlayer.activeCrew == b.currentPlayer.activeCrew &&
        a.currentPlayer.ship.build == b.currentPlayer.ship.build &&
        a.currentPlayer.ship.orientation == b.currentPlayer.ship.orientation &&
        a.currentPlayer.ship.momentumRotary ==
            b.currentPlayer.ship.momentumRotary &&
        const IterableEquality().equals(
            a.projectiles.where((p) => p.firedBy == a.turn),
            b.projectiles.where((p) => p.firedBy == b.turn));
  }
}
