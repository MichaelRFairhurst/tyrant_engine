import 'package:freezed_annotation/freezed_annotation.dart';

part 'mcts_result.freezed.dart';
part 'mcts_result.g.dart';

@freezed
class MctsResult with _$MctsResult {
  const factory MctsResult({
    required int victoryCount,
  }) = _MctsResult;

  factory MctsResult.fromJson(Map<String, dynamic> json) =>
      _$MctsResultFromJson(json);
}
