import 'package:tyrant_engine/src/algorithm/action_orderer.dart';
import 'package:tyrant_engine/src/algorithm/minimax.dart';
import 'package:tyrant_engine/src/algorithm/scorer.dart';
import 'package:tyrant_engine/src/algorithm/final_action_table.dart';
import 'package:tyrant_engine/src/algorithm/transposition_table.dart';
import 'package:tyrant_engine/src/algorithm/tree.dart';
import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/model/player.dart';
import 'package:tyrant_engine/src/model/weapon.dart';
import 'package:tyrant_engine/src/model/weapon_slot_descriptor.dart';
import 'package:tyrant_engine/src/rules/action.dart';
import 'package:tyrant_engine/src/rules/outcomes.dart';
import 'package:tyrant_engine/src/rules/rule_engine.dart';
import 'package:tyrant_engine/src/strategy/strategy.dart';

class MinimaxStrategy implements Strategy {
  MinimaxStrategy({
    required this.ruleEngine,
    this.printStats = true,
    this.maxOnly = false,
    this.maxDepth = 20,
    this.turnsAhead = 5,
  });

  final int turnsAhead;
  final int maxDepth;
  final RuleEngine ruleEngine;
  final bool printStats;
  final bool maxOnly;
  final orderer = ActionOrderer();
  GameFinalActionTable? finalActionTable;
  final transpositionTable = TranspositionTable<Game, Branch<Game>>();

  @override
  String get name => 'Minimax strategy';

  @override
  Action pickAction(Game game, List<Action> actions) {
    final maxingPlayer = game.turn;
    final untilTurn = game.turnCount + turnsAhead;

    final scorer = HpDifferentialScorer(maxingPlayer);
    finalActionTable ??= GameFinalActionTable(scorer);

    final branch = decisionBranch(game, actions, maxingPlayer, untilTurn);
    final minimax =
        Minimax<Action, Game>(scorer, finalActionTable!, printStats);
    final result = minimax.run(branch, maxDepth, untilTurn);

    transpositionTable.gc();
    finalActionTable!.gc();

    if (printStats) {
      minimax.printStats();
    }
    return result;
  }

  // For the final turn, rather than considering n card draws times m ways of
  // playing each hand, we reuse nodes to keep the combinations down.
  //
  // We create a branch for playing any card in their current hand (before
  // drawing), and create one node that chooses the best play of those options.
  // This node gets reused for the best score caching.
  //
  // We then also create a node for playing each newly drawn card.
  //
  // Each possible card draw is paired in a decision branch to choose the best
  // option between playing the new card or playing out of the hand, and then
  // each of these decision pairs are put into one expected value branch.
  Branch<Game> finalTurnToBranch(
      Game game, PlayerType maxingPlayer, int untilTurn) {
    final deck = game.currentPlayer.deck;

    final skipDraw = game.copyWith(phase: Phase.drift);
    // lazily build
    Branch<Game>? playFromHandNode;
    //final playFromHandNode = gameToBranch(skipDraw, maxingPlayer, untilTurn)
    //    as DecisionBranch<Action, Game>;
    final slotTypesMap = game.currentPlayer.ship.build.slotTypesMap();

    Move<Action, Game> playNewCardMove(
        Weapon weapon, WeaponSlotDescriptor slot) {
      final drawCard = skipDraw.updateCurrentPlayer((p) => p.dealCard(weapon));
      final action = PlayWeaponAction(
        card: weapon,
        slot: slot,
      );
      return Move(
          action,
          () => outcomeToBranch(
              drawCard, action.perform(drawCard), maxingPlayer, untilTurn));
    }

    DecisionBranch<Action, Game> useDrawnCardDecision(Weapon weapon) {
      final playToSlotMoves = ruleEngine
          .playableSlots(game.currentPlayer.ship.build, slotTypesMap, weapon)
          .map((slot) => playNewCardMove(weapon, slot));
      return DecisionBranch<Action, Game>(
        skipDraw,
        skipDraw.turnCount,
        [
          Move(
              _PlayFromHandDontDrawAction(),
              () => playFromHandNode ??= playFromHandNode =
                  gameToBranch(skipDraw, maxingPlayer, untilTurn)),
          ...playToSlotMoves,
        ],
        game.turn == maxingPlayer,
      );
    }

    final deckSize = deck.size;
    return ExpectedValueBranch(
        game,
        game.turnCount,
        Outcome<Branch<Game>>(
            randomOutcomes: deck
                .map((weapon, count) => RandomOutcome<Branch<Game>>(
                    probability: count / deckSize,
                    explanation: () => 'draw ${weapon.name}',
                    result: useDrawnCardDecision(weapon)))
                .toList()));
  }

  Branch<Game> gameToBranch(
          Game game, PlayerType maxingPlayer, int untilTurn) =>
      transpositionTable.putIfAbsent(game, () {
        if (game.phase == Phase.draw && game.turnCount == untilTurn - 2) {
          return finalTurnToBranch(game, maxingPlayer, untilTurn);
        }

        var outcomes = ruleEngine.tick(
          game: game,
        );

        if (outcomes.randomOutcomes.length > 1) {
          return outcomeToBranch(game, outcomes, maxingPlayer, untilTurn);
        } else if (outcomes.randomOutcomes.length == 1) {
          game = outcomes.randomOutcomes.single.result;
        }

        final actions = ruleEngine.playerActions(game);

        if (actions.isEmpty) {
          return gameToBranch(game, maxingPlayer, untilTurn);
        }

        if (actions.length == 1) {
          return outcomeToBranch(
              game, actions.single.perform(game), maxingPlayer, untilTurn);
        }

        if (game.turn != maxingPlayer && maxOnly) {
          return gameToBranch(
              actions.first.perform(game).randomOutcomes.first.result,
              maxingPlayer,
              untilTurn);
        }
        return decisionBranch(game, actions, maxingPlayer, untilTurn);
      });

  Branch<Game> outcomeToBranch(Game game, Outcome<Game> outcome,
      PlayerType maxingPlayer, int untilTurn) {
    if (outcome.randomOutcomes.length == 1) {
      return gameToBranch(
          outcome.randomOutcomes.single.result, maxingPlayer, untilTurn);
    }
    if (game.turn != maxingPlayer) {
      return gameToBranch(
          outcome.randomOutcomes.first.result, maxingPlayer, untilTurn);
    }
    return ExpectedValueBranch<Game>(
      game,
      game.turnCount,
      outcome.map((o) => gameToBranch(o, maxingPlayer, untilTurn)),
    );
  }

  DecisionBranch<Action, Game> decisionBranch(
      Game game, List<Action> actions, PlayerType maxingPlayer, int untilTurn) {
    return DecisionBranch<Action, Game>(
      game,
      game.turnCount,
      orderer
          .order(game, actions)
          .map((a) => Move(
              a,
              () => outcomeToBranch(
                  game, a.perform(game), maxingPlayer, untilTurn)))
          .toList(),
      game.turn == maxingPlayer,
    );
  }
}

class _PlayFromHandDontDrawAction implements Action {
  @override
  Outcome<Game> perform(Game game) => throw 'should not be called';
}
