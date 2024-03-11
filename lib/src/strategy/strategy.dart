import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/model/player.dart';
import 'package:tyrant_engine/src/rules/action.dart';

abstract class Strategy {
  Action pickAction(Game game, List<Action> actions);
}

class PlayerStrategies {
  PlayerStrategies({
    required this.firstPlayerStrategy,
    required this.secondPlayerStrategy,
  });

  final Strategy firstPlayerStrategy;
  final Strategy secondPlayerStrategy;

  Strategy player(PlayerType player) => player == PlayerType.firstPlayer
      ? firstPlayerStrategy
      : secondPlayerStrategy;
}
