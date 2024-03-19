import 'package:tyrant_engine/src/gameplay/gameplay_engine.dart';
import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/rules/action.dart';
import 'package:tyrant_engine/src/strategy/random_strategy.dart';
import 'package:tyrant_engine/src/strategy/strategy.dart';

class Mcts {
  final int sampleCount;
  final GameplayEngine gameplayEngine;
  final randomStrategies = PlayerStrategies(
    firstPlayerStrategy: RandomStrategy(),
    secondPlayerStrategy: RandomStrategy(),
  );

  Mcts(this.gameplayEngine, this.sampleCount);

  Future<Action> pickAction(Game game, List<Action> actions) async {
    Action? bestAction;
    int mostVictories = 0;

    for (var i = 0; i < actions.length; ++i) {
      //print('evaluating $action');
      final victories = await countVictoriesForActionIdx(game, actions, i);

      //print('  victory in $victories games');
      if (victories > mostVictories) {
        mostVictories = victories;
        bestAction = actions[i];
      }
    }

    return bestAction!;
  }

  Future<int> countVictoriesForActionIdx(
      Game game, List<Action> actions, int idx) async {
    final ifPerformed = actions[idx].perform(game);
    int victories = 0;
    for (int i = 0; i < sampleCount; ++i) {
      final outcome = gameplayEngine.pickOutcome(ifPerformed);
      final winner = await gameplayEngine.run(outcome, randomStrategies);
      if (winner == game.turn) {
        victories++;
      }
    }
    return victories;
  }
}
