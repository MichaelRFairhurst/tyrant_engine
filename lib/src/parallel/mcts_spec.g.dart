// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mcts_spec.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MctsSpec _$$_MctsSpecFromJson(Map<String, dynamic> json) => _$_MctsSpec(
      sampleCount: json['sampleCount'] as int,
      threads: json['threads'] as int,
      maxDepth: json['maxDepth'] as int? ?? 15,
    );

Map<String, dynamic> _$$_MctsSpecToJson(_$_MctsSpec instance) =>
    <String, dynamic>{
      'sampleCount': instance.sampleCount,
      'threads': instance.threads,
      'maxDepth': instance.maxDepth,
    };
