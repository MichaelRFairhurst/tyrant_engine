import 'package:tyrant_engine/src/gameplay/dice_roller.dart';
import 'package:tyrant_engine/src/model/dice.dart';

class ExpectedValueDiceRoller implements DiceRoller<double> {
  @override
  List<T> roll<T>(Dice dice, T Function(double, double) handler) {
    return [handler(1, dice.expectedValue)];
  }
}
