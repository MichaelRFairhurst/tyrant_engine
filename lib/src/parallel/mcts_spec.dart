import 'package:freezed_annotation/freezed_annotation.dart';

part 'mcts_spec.freezed.dart';
part 'mcts_spec.g.dart';

@freezed
class MctsSpec with _$MctsSpec {
  const factory MctsSpec({
    required int sampleCount,
    required int threads,
    @Default(10) int maxDepth,
  }) = _MctsSpec;

  factory MctsSpec.fromJson(Map<String, dynamic> json) =>
      _$MctsSpecFromJson(json);
}
