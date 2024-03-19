import 'package:tyrant_engine/src/algorithm/expected_value_dice_roller.dart';
import 'package:tyrant_engine/src/parallel/mcts_spec.dart';
import 'package:tyrant_engine/src/strategy/dps_strategy.dart';
import 'package:tyrant_engine/src/strategy/strategy.dart';
import 'package:tyrant_engine/tyrant_engine.dart';

void main(List<String> arguments) async {
  final engine = TyrantEngine();

  engine.compareStrategies(
    PlayerStrategies(
      firstPlayerStrategy: DpsStrategy(),
      secondPlayerStrategy:
          await engine.mctsStrategy(MctsSpec(sampleCount: 200, threads: 16)),
      //secondPlayerStrategy: engine.minimaxStrategy(
      //  diceRoller: ExpectedValueDiceRoller(),
      //  print: false,
      //  maxOnly: true,
      //),
      //firstPlayerStrategy: engine.minimaxStrategy(
      //  diceRoller: ExpectedValueDiceRoller(),
      //  print: false,
      //  maxOnly: true,
      //),
      //secondPlayerStrategy: DpsStrategy(),
    ),
    200,
    diceRoller: ExpectedValueDiceRoller(),
  );
}
