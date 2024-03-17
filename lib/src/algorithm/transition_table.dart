import 'dart:collection';

class TransitionTable<G, T, R> {
  late final Map<G, Map<T, R>> _cache;

  TransitionTable() {
    _cache = HashMap<G, Map<T, R>>(hashCode: hashG, equals: equalsG);
  }

  R putIfAbsent(G game, T transition, R Function() computeResult) =>
      _getGTable(game).putIfAbsent(transition, computeResult);

  R? lookup(G game, T transition) => _getGTable(game)[transition];

  Map<T, R> _getGTable(G g) => _cache.putIfAbsent(
      g, () => HashMap<T, R>(hashCode: hashT, equals: equalsT));

  int hashG(G g) => g.hashCode;
  bool equalsG(G a, G b) => a == b;
  int hashT(T t) => t.hashCode;
  bool equalsT(T a, T b) => a == b;
}
