import 'package:freezed_annotation/freezed_annotation.dart';

part 'outcomes.freezed.dart';

@freezed
class Outcome<T> with _$Outcome<T> {
  const Outcome._();

  const factory Outcome({required List<RandomOutcome<T>> randomOutcomes}) =
      _Outcome;

  factory Outcome.single(T t) => Outcome<T>(randomOutcomes: [
        RandomOutcome<T>(
            explanation: () => 'single outcome', probability: 1, result: t)
      ]);

  bool get isBranching => randomOutcomes.length > 1;
  bool get isSingular => randomOutcomes.length == 1;

  T get single => randomOutcomes.single.result;

  Outcome<G> map<G>(G Function(T) f) => Outcome<G>(
      randomOutcomes: randomOutcomes
          .map((o) => RandomOutcome<G>(
                explanation: o.explanation,
                probability: o.probability,
                result: f(o.result),
              ))
          .toList());

  Outcome<G> mapWithProbability<G>(
          RandomOutcome<G> Function(RandomOutcome<T>) f) =>
      Outcome<G>(randomOutcomes: randomOutcomes.map((o) => f(o)).toList());

  RandomOutcome<T> pick(double select) {
    for (final ro in randomOutcomes) {
      select -= ro.probability;
      if (select < 0) {
        return ro;
      }
    }

    throw 'unreachable';
  }
}

@freezed
class RandomOutcome<T> with _$RandomOutcome<T> {
  const RandomOutcome._();

  const factory RandomOutcome({
    required String Function() explanation,
    required double probability,
    required T result,
  }) = _RandomOutcome;

  RandomOutcome<G> map<G>(G Function(T) f) => RandomOutcome<G>(
        explanation: explanation,
        probability: probability,
        result: f(result),
      );
}

extension ExpectedValue<N extends num> on Outcome<N> {
  double get expectedValue => randomOutcomes.fold<double>(
      0.0, (sum, o) => sum + o.probability * o.result);
}
