import 'package:tyrant_engine/src/gameplay/dice_roller.dart';
import 'package:tyrant_engine/src/model/dice.dart';
import 'package:tyrant_engine/src/rules/outcomes.dart';

class ExpectedValueDiceRoller implements DiceRoller<double> {
  @override
  Outcome<double> roll(Dice dice) => Outcome.single(dice.expectedValue);
}
