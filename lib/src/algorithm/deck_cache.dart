import 'package:tyrant_engine/src/model/weapon.dart';

class Deck {
  final int id;
  final DeckIdSystem idSystem;
  final Map<Weapon, int> countMap;
  final removalMap = <Weapon, Deck>{};
  final additionMap = <Weapon, Deck>{};

  Deck({
    required this.id,
    required this.countMap,
    required this.idSystem,
  });

  List<Map<String, dynamic>> toJson() => countMap.entries
      .map((e) => {'card': e.key.toJson(), 'count': e.value})
      .toList();

  factory Deck.fromJson(List<Map<String, dynamic>> json) {
    final map = Map<Weapon, int>.fromEntries(json.map((item) => MapEntry(
        Weapon.fromJson(item['card'] as Map<String, dynamic>),
        item['count'] as int)));
    return DeckIdSystem().zero(map);
  }

  Deck remove(Weapon weapon) {
    return removalMap.putIfAbsent(weapon, () {
      final count = countMap[weapon];
      if (count == 1) {
        return Deck(
          id: idSystem.takeId(),
          idSystem: idSystem,
          countMap: {...countMap}..remove(weapon),
        );
      } else {
        return Deck(
          id: id,
          idSystem: idSystem,
          countMap: {...countMap}..update(weapon, (c) => c - 1),
        );
      }
    });
  }

  Deck add(Weapon weapon) {
    return additionMap.putIfAbsent(
        weapon,
        () => Deck(
              id: idSystem.takeId(),
              idSystem: idSystem,
              countMap: {...countMap}
                ..update(weapon, (c) => c + 1, ifAbsent: () => 1),
            ));
  }

  Iterable<Weapon> get uniqueCards => countMap.keys;
  int get size => countMap.values.fold<int>(0, (s, c) => s + c);
  Iterable<T> map<T>(T Function(Weapon, int) f) =>
      countMap.entries.map((e) => f(e.key, e.value));

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object? other) {
    return other is Deck && other.id == id && other.idSystem == idSystem;
  }

  @override
  String toString() =>
      map((card, count) => '${card.name} (x{$count})').join(', ');
}

class DeckIdSystem {
  int id = 0;

  Deck zero(Map<Weapon, int> map) {
    final deck = Deck(id: id++, countMap: map, idSystem: this);
    return deck;
  }

  int takeId() {
    return id++;
  }
}
