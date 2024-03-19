// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mcts_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MctsRequest _$$_MctsRequestFromJson(Map<String, dynamic> json) =>
    _$_MctsRequest(
      game: Game.fromJson(json['game'] as Map<String, dynamic>),
      actionIdx: json['actionIdx'] as int,
    );

Map<String, dynamic> _$$_MctsRequestToJson(_$_MctsRequest instance) =>
    <String, dynamic>{
      'game': instance.game,
      'actionIdx': instance.actionIdx,
    };
