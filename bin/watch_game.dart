import 'package:tyrant_engine/src/algorithm/expected_value_dice_roller.dart';
import 'package:tyrant_engine/src/algorithm/reduced_dice_roller.dart';
import 'package:tyrant_engine/src/parallel/mcts_spec.dart';
import 'package:tyrant_engine/src/strategy/dps_strategy.dart';
import 'package:tyrant_engine/src/strategy/strategy.dart';
import 'package:tyrant_engine/tyrant_engine.dart';

void main(List<String> arguments) async {
  final engine = TyrantEngine();

  engine.printGame(
    PlayerStrategies(
      firstPlayerStrategy: DpsStrategy(),
      secondPlayerStrategy: await engine
          .mctsStrategy(MctsSpec(sampleCount: 500, threads: 16, maxDepth: 30)),
      //secondPlayerStrategy: engine.minimaxStrategy(
      //  print: true,
      //  //diceRoller: ReducedDiceRoller(2),
      //  diceRoller: ExpectedValueDiceRoller(),
      //  maxOnly: false,
      //),
      //firstPlayerStrategy: engine.minimaxStrategy(
      //  print: true,
      //  //diceRoller: ReducedDiceRoller(2),
      //  diceRoller: ExpectedValueDiceRoller(),
      //  maxOnly: true,
      //),
      //secondPlayerStrategy: DpsStrategy(),
    ),
    diceRoller: ExpectedValueDiceRoller(),
  );
}
