import 'dart:async';
import 'dart:math';

import 'package:tyrant_engine/src/cli/printer.dart';
import 'package:tyrant_engine/src/gameplay/gameplay_visitor.dart';
import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/model/player.dart';
import 'package:tyrant_engine/src/rules/action.dart';
import 'package:tyrant_engine/src/rules/outcomes.dart';
import 'package:tyrant_engine/src/rules/rule_engine.dart';
import 'package:tyrant_engine/src/content/decks.dart' as decks;
import 'package:tyrant_engine/src/content/ships.dart' as ships;
import 'package:tyrant_engine/src/strategy/strategy.dart';

class GameplayEngine extends GameplayVisitor<Future<PlayerType>> {
  final RuleEngine ruleEngine;
  late PlayerStrategies strategies;
  final Printer printer;
  final Random random;

  GameplayEngine(this.printer, this.ruleEngine, this.random);

  Game defaultGame() {
    return ruleEngine.initializeGame(
      playerDeck: decks.defaultDeck,
      playerBuild: ships.defaultBuild,
      enemyDeck: decks.defaultDeck,
      enemyBuild: ships.defaultBuild,
    );
  }

  Future<PlayerType> run(Game game, PlayerStrategies strategies) {
    this.strategies = strategies;
    printer.initGame(game);

    return visitAll(game, ruleEngine);
  }

  @override
  Future<PlayerType> visitRound(
      Game game, Future<PlayerType> Function() keepVisiting) {
    printer.newRound(game);
    return keepVisiting();
  }

  @override
  Future<PlayerType> visitTurn(
      Game game, Future<PlayerType> Function() keepVisiting) {
    printer.newTurn(game);
    return keepVisiting();
  }

  @override
  Future<PlayerType> visitPhase(
      Game game, Future<PlayerType> Function() keepVisiting) {
    printer.startPhase(game);
    return keepVisiting();
  }

  @override
  Future<PlayerType> visitActions(Game game, List<Action> actions,
      Future<PlayerType> Function(Action) visitAction) async {
    final act = await strategies.player(game.turn).pickAction(game, actions);
    printer.chosenAction(act);
    return visitAction(act);
  }

  @override
  Future<PlayerType> visitOutcomes(
          Outcome<Game> outcomes,
          Future<PlayerType> Function(RandomOutcome<Game>)
              visitRandomOutcome) =>
      visitRandomOutcome(pickOutcome(outcomes));

  RandomOutcome<Game> pickOutcome(Outcome<Game> outcomes) {
    var select = random.nextDouble();
    for (final ro in outcomes.randomOutcomes) {
      select -= ro.probability;
      if (select < 0) {
        printer.randomOutcome(ro);
        return ro;
      }
    }
    throw 'unreachable';
  }

  @override
  Future<PlayerType> visitSingularOutcome(
      RandomOutcome<Game> outcome, Future<PlayerType> Function() keepVisiting) {
    printer.randomOutcome(outcome);
    return keepVisiting();
  }

  @override
  Future<PlayerType> visitWinner(Game game, PlayerType winner) async {
    printer.gameOver(game, winner);
    return winner;
  }
}
