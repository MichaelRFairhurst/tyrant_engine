// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ship_build.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ShipBuild _$$_ShipBuildFromJson(Map<String, dynamic> json) => _$_ShipBuild(
      forward: Side.fromJson(json['forward'] as Map<String, dynamic>),
      aft: Side.fromJson(json['aft'] as Map<String, dynamic>),
      port: Side.fromJson(json['port'] as Map<String, dynamic>),
      starboard: Side.fromJson(json['starboard'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ShipBuildToJson(_$_ShipBuild instance) =>
    <String, dynamic>{
      'forward': instance.forward,
      'aft': instance.aft,
      'port': instance.port,
      'starboard': instance.starboard,
    };
