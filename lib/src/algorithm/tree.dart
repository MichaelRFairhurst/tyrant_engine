abstract class Branch<T> {
  Branch(this.value);
  final T value;
}

class ExpectedValueBranch<T> extends Branch<T> {
  ExpectedValueBranch(super.value, this.possibilities);

  final List<Possibility<T>> possibilities;
}

class Possibility<T> {
  Possibility(this.probability, this.result);

  final double probability;
  final Branch<T> result;
}

class DecisionBranch<A, T> extends Branch<T> {
  DecisionBranch(super.value, this.actions, this.min);

  final Map<A, Branch<T> Function()> actions;
  final bool min;
}
