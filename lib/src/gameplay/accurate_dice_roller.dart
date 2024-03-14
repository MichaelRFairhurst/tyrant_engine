import 'dart:math';

import 'package:tyrant_engine/src/gameplay/dice_roller.dart';
import 'package:tyrant_engine/src/model/dice.dart';
import 'package:tyrant_engine/src/rules/outcomes.dart';

class AccurateDiceRoller implements DiceRoller<int> {
  final _cache = <Dice, Outcome<int>>{};

  @override
  Outcome<int> roll(Dice dice) {
    return _cache[dice] ??= _computeAndCache(dice);
  }

  Outcome<int> _computeAndCache(Dice dice) {
    final table = <int, int>{};
    _recursiveCompute(dice.sides, dice.rolls, 0, table);
    final comb = pow(dice.sides, dice.rolls);

    return _cache[dice] = Outcome<int>(
        randomOutcomes: table.entries
            .map((entry) => RandomOutcome<int>(
                explanation: () => 'rolled a ${entry.key}',
                probability: entry.value / comb,
                result: entry.key))
            .toList());
  }

  // TODO: use actual statistics to calculate this in fewer steps...
  _recursiveCompute(int sides, int rolls, int baseline, Map<int, int> table) {
    for (int i = 1; i <= sides; ++i) {
      final sum = i + baseline;
      if (rolls == 1) {
        if (table.containsKey(sum)) {
          table[sum] = table[sum]! + 1;
        } else {
          table[sum] = 1;
        }
      } else {
        _recursiveCompute(sides, rolls - 1, sum, table);
      }
    }
  }
}
