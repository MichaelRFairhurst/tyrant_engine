import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/rules/action.dart';
import 'package:tyrant_engine/src/strategy/strategy.dart';

class DiffStrategy implements Strategy {
  @override
  String get name => 'debug diff';

  final Strategy a;
  final Strategy b;

  DiffStrategy(this.a, this.b);

  @override
  Action pickAction(Game game, List<Action> actions) {
    final actA = a.pickAction(game, actions);
    final actB = b.pickAction(game, actions);

    if (!identical(actA, actB)) {
      throw '$game difference! Pick $actA or $actB?';
    }

    return actA;
  }
}
