import 'dart:math';

import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/rules/action.dart';
import 'package:tyrant_engine/src/strategy/strategy.dart';

class RandomStrategy implements Strategy {
  RandomStrategy({Random? random}) : random = random ?? Random();
  final Random random;

  @override
  Action pickAction(Game game, List<Action> actions) =>
      actions[random.nextInt(actions.length)];

  @override
  String get name => 'random strategy';
}
