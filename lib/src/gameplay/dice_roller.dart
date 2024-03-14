import 'package:tyrant_engine/src/model/dice.dart';
import 'package:tyrant_engine/src/rules/outcomes.dart';

abstract class DiceRoller<N extends num> {
  Outcome<N> roll(Dice dice);
}
