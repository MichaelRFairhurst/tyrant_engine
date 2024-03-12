import 'package:freezed_annotation/freezed_annotation.dart';

part 'outcomes.freezed.dart';

@freezed
class Outcome<T> with _$Outcome<T> {
  const factory Outcome({required Iterable<RandomOutcome<T>> randomOutcomes}) =
      _Outcome;

  factory Outcome.single(T t) => Outcome<T>(randomOutcomes: [
        RandomOutcome<T>(explanation: () => '', probability: 1, result: t)
      ]);
}

@freezed
class RandomOutcome<T> with _$RandomOutcome<T> {
  const factory RandomOutcome({
    required String Function() explanation,
    required double probability,
    required T result,
  }) = _RandomOutcome;
}
