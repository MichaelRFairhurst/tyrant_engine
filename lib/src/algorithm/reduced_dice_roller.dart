import 'package:tyrant_engine/src/gameplay/accurate_dice_roller.dart';
import 'package:tyrant_engine/src/gameplay/dice_roller.dart';
import 'package:tyrant_engine/src/model/dice.dart';
import 'package:tyrant_engine/src/rules/outcomes.dart';

class ReducedDiceRoller implements DiceRoller<double> {
  final accurateDiceRoller = AccurateDiceRoller();
  final _cache = <Dice, Outcome<double>>{};
  final int chunks;

  ReducedDiceRoller(this.chunks);

  @override
  Outcome<double> roll(Dice dice) {
    return _cache.putIfAbsent(dice, () {
      final possibilities = accurateDiceRoller.roll(dice).randomOutcomes;

      final chunkProbability = 1.0 / chunks;
      final result = <RandomOutcome<double>>[];

      var runningProbability = 0.0;
      var runningSum = 0.0;

      for (int i = 0; i < possibilities.length; ++i) {
        final p = possibilities[i];
        runningProbability += p.probability;
        runningSum += p.probability * p.result;

        if (runningProbability >= chunkProbability ||
            i == possibilities.length - 1) {
          final avg = runningSum / runningProbability;
          result.add(RandomOutcome<double>(
              explanation: () => 'reduced probability dice roll.',
              probability: runningProbability,
              result: avg));

          runningProbability = 0.0;
          runningSum = 0.0;
        }
      }

      return Outcome<double>(randomOutcomes: result);
    });
  }
}
