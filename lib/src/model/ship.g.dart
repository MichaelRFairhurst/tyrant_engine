// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ship.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Ship _$$_ShipFromJson(Map<String, dynamic> json) => _$_Ship(
      hp: (json['hp'] as num?)?.toDouble() ?? 60.0,
      build: ShipBuild.fromJson(json['build'] as Map<String, dynamic>),
      x: json['x'] as int,
      y: json['y'] as int,
      orientation: json['orientation'] as int,
      momentumForward: json['momentumForward'] as int? ?? 0,
      momentumLateral: json['momentumLateral'] as int? ?? 0,
      momentumRotary: json['momentumRotary'] as int? ?? 0,
    );

Map<String, dynamic> _$$_ShipToJson(_$_Ship instance) => <String, dynamic>{
      'hp': instance.hp,
      'build': instance.build,
      'x': instance.x,
      'y': instance.y,
      'orientation': instance.orientation,
      'momentumForward': instance.momentumForward,
      'momentumLateral': instance.momentumLateral,
      'momentumRotary': instance.momentumRotary,
    };
