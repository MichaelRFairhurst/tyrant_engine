// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'projectile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Projectile _$$_ProjectileFromJson(Map<String, dynamic> json) =>
    _$_Projectile(
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      weapon: Weapon.fromJson(json['weapon'] as Map<String, dynamic>),
      firedBy: $enumDecode(_$PlayerTypeEnumMap, json['firedBy']),
    );

Map<String, dynamic> _$$_ProjectileToJson(_$_Projectile instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'weapon': instance.weapon,
      'firedBy': _$PlayerTypeEnumMap[instance.firedBy]!,
    };

const _$PlayerTypeEnumMap = {
  PlayerType.firstPlayer: 'firstPlayer',
  PlayerType.secondPlayer: 'secondPlayer',
};
