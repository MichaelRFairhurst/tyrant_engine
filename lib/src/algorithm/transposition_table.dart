import 'dart:collection';

class TranspositionTable<G, T> {
  late HashMap<G, T> _oldCache;
  late HashMap<G, T> _newCache;
  final Equality<G>? equality;

  TranspositionTable([this.equality]) {
    _oldCache = HashMap<G, T>(
      hashCode: equality?.hash,
      equals: equality?.equals,
    );
    _newCache = HashMap<G, T>(
      hashCode: equality?.hash,
      equals: equality?.equals,
    );
  }

  T putIfAbsent(G g, T Function() ifAbsent) {
    return _newCache.putIfAbsent(g, () {
      final old = _oldCache[g];
      return old ?? ifAbsent();
    });
  }

  void gc() {
    _oldCache = _newCache;
    _newCache = HashMap<G, T>(
      hashCode: equality?.hash,
      equals: equality?.equals,
    );
  }
}

abstract class Equality<T> {
  int hash(T t);
  bool equals(T a, T b);
}
