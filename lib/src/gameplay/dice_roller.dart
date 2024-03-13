import 'package:tyrant_engine/src/model/dice.dart';

abstract class DiceRoller<N extends num> {
  List<T> roll<T>(Dice dice, T Function(double, N) handler);
}
