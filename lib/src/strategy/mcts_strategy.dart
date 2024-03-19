import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/parallel/mcts_request.dart';
import 'package:tyrant_engine/src/parallel/mcts_service.dart';
import 'package:tyrant_engine/src/rules/action.dart';
import 'package:tyrant_engine/src/strategy/strategy.dart';

class MctsStrategy implements Strategy {
  final MctsService mctsService;

  MctsStrategy(this.mctsService);

  @override
  String get name => 'Monte-Carlo Tree Search Strategy';

  @override
  Future<Action> pickAction(Game game, List<Action> actions) async {
    final requests = Iterable.generate(
        actions.length, (i) => MctsRequest(game: game, actionIdx: i));
    final victoryCounts =
        await Future.wait(requests.map((r) => mctsService.searchGame(r)));

    var max = 0;
    var bestIdx = 0;
    for (int i = 0; i < actions.length; ++i) {
      if (victoryCounts[i].victoryCount > max) {
        bestIdx = i;
        max = victoryCounts[i].victoryCount;
      }
    }

    return actions[bestIdx];
  }
}
