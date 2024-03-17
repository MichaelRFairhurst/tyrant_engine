class TranspositionTable<G, T> {
  var _oldCache = <G, T>{};
  var _newCache = <G, T>{};

  T putIfAbsent(G g, T Function() ifAbsent) {
    return _newCache.putIfAbsent(g, () {
      final old = _oldCache[g];
      return old ?? ifAbsent();
    });
  }

  void gc() {
    _oldCache = _newCache;
    _newCache = <G, T>{};
  }
}
