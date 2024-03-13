import 'package:tyrant_engine/src/algorithm/expected_value_dice_roller.dart';
import 'package:tyrant_engine/src/strategy/dps_strategy.dart';
import 'package:tyrant_engine/src/strategy/strategy.dart';
import 'package:tyrant_engine/tyrant_engine.dart';

void main(List<String> arguments) {
  final engine = TyrantEngine();

  engine.compareStrategies(
    PlayerStrategies(
      firstPlayerStrategy: DpsStrategy(),
      secondPlayerStrategy: engine.minimaxStrategy(false),
      //firstPlayerStrategy: engine.minimaxStrategy(false),
      //secondPlayerStrategy: DpsStrategy(),
    ),
    1000,
    diceRoller: ExpectedValueDiceRoller(),
  );
}
