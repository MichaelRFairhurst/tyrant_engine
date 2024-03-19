import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tyrant_engine/src/model/game.dart';

part 'mcts_request.freezed.dart';
part 'mcts_request.g.dart';

@freezed
class MctsRequest with _$MctsRequest {
  const factory MctsRequest({
    required Game game,
    required int actionIdx,
  }) = _MctsRequest;

  factory MctsRequest.fromJson(Map<String, dynamic> json) =>
      _$MctsRequestFromJson(json);
}
