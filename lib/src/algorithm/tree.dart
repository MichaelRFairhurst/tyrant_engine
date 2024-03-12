abstract class Branch<T> {
  Branch(this.value, this.turn);

  final T value;
  final int turn;
}

class ExpectedValueBranch<T> extends Branch<T> {
  ExpectedValueBranch(super.value, super.turn, this.possibilities);

  final Iterable<Possibility<T>> possibilities;
}

class Possibility<T> {
  Possibility(this.probability, this.result);

  final double probability;
  final Branch<T> result;
}

class DecisionBranch<A, T> extends Branch<T> {
  DecisionBranch(super.value, super.turn, this.actions, this.isMaxing);

  final Map<A, Branch<T> Function()> actions;
  final bool isMaxing;
  bool get isMinning => !isMaxing;
}
