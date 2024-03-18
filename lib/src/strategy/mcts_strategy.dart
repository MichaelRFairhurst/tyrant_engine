import 'package:tyrant_engine/src/gameplay/gameplay_engine.dart';
import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/rules/action.dart';
import 'package:tyrant_engine/src/strategy/random_strategy.dart';
import 'package:tyrant_engine/src/strategy/strategy.dart';

class MctsStrategy implements Strategy {
  final GameplayEngine gameplayEngine;

  MctsStrategy(this.gameplayEngine);

  @override
  String get name => 'Monte-Carlo Tree Search Strategy';

  @override
  Action pickAction(Game game, List<Action> actions) {
    final randomStrategies = PlayerStrategies(
      firstPlayerStrategy: RandomStrategy(),
      secondPlayerStrategy: RandomStrategy(),
    );

    Action? bestAction;
    int mostVictories = 0;

    for (final action in actions) {
      //print('evaluating $action');
      final ifPerformed = action.perform(game);
      int victories = 0;
      for (int i = 0; i < 100; ++i) {
        final outcome = gameplayEngine.pickOutcome(ifPerformed);
        final winner = gameplayEngine.run(outcome, randomStrategies);
        if (winner == game.turn) {
          victories++;
        }
      }

      //print('  victory in $victories games');
      if (victories > mostVictories) {
        mostVictories = victories;
        bestAction = action;
      }
    }

    return bestAction!;
  }
}
