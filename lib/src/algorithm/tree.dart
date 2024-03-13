abstract class Branch<T> {
  Branch(this.value, this.turn);

  final T value;
  double? score;
  final int turn;
}

class ExpectedValueBranch<T> extends Branch<T> {
  ExpectedValueBranch(super.value, super.turn, this.possibilities);

  final List<Possibility<T>> possibilities;
}

class Possibility<T> {
  Possibility(this.probability, this.result);

  final double probability;
  final Branch<T> result;
}

class DecisionBranch<A, T> extends Branch<T> {
  DecisionBranch(super.value, super.turn, this.actions, this.isMaxing);

  final List<Move<A, T>> actions;
  final bool isMaxing;
  bool get isMinning => !isMaxing;
}

class Move<A, T> {
  final A move;
  Branch<T>? _result;
  final Branch<T> Function() expand;

  Branch<T> get result => _result ??= expand();

  Move(this.move, this.expand);
}
