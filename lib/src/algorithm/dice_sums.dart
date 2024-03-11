import 'package:tyrant_engine/src/model/dice.dart';

class DiceSums {
  final _cache = <Dice, List<_DiceSumCacheEntry>>{};

  List<T> roll<T>(Dice dice, T Function(double, int) handler) {
    final cached = _cache[dice] ?? _computeAndCache(dice);

    return cached
        .map((entry) => handler(entry.probability, entry.value))
        .toList();
  }

  List<_DiceSumCacheEntry> _computeAndCache(Dice dice) {
    final table = <int, int>{};
    _recursiveCompute(dice.sides, dice.rolls, 0, table);
    final comb = dice.sides * dice.rolls;

    return _cache[dice] = table.entries
        .map((entry) => _DiceSumCacheEntry(entry.value / comb, entry.key))
        .toList();
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

class _DiceSumCacheEntry {
  final double probability;
  final int value;

  _DiceSumCacheEntry(this.probability, this.value);
}
