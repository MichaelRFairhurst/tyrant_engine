import 'package:tyrant_engine/src/strategy/dps_strategy.dart';
import 'package:tyrant_engine/src/strategy/strategy.dart';
import 'package:tyrant_engine/tyrant_engine.dart';

void main(List<String> arguments) {
  final engine = TyrantEngine();

  engine.printGame(
    PlayerStrategies(
      //firstPlayerStrategy: DpsStrategy(),
      //secondPlayerStrategy: MinimaxStrategy(RuleEngine()),
      firstPlayerStrategy: engine.minimaxStrategy(),
      secondPlayerStrategy: DpsStrategy(),
    ),
  );
}
