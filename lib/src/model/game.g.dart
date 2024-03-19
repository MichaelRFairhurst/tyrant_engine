// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Game _$$_GameFromJson(Map<String, dynamic> json) => _$_Game(
      round: json['round'] as int,
      phase: $enumDecode(_$PhaseEnumMap, json['phase']),
      turn: $enumDecode(_$PlayerTypeEnumMap, json['turn']),
      firstPlayer: Player.fromJson(json['firstPlayer'] as Map<String, dynamic>),
      secondPlayer:
          Player.fromJson(json['secondPlayer'] as Map<String, dynamic>),
      projectiles: (json['projectiles'] as List<dynamic>)
          .map((e) => Projectile.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_GameToJson(_$_Game instance) => <String, dynamic>{
      'round': instance.round,
      'phase': _$PhaseEnumMap[instance.phase]!,
      'turn': _$PlayerTypeEnumMap[instance.turn]!,
      'firstPlayer': instance.firstPlayer,
      'secondPlayer': instance.secondPlayer,
      'projectiles': instance.projectiles,
    };

const _$PhaseEnumMap = {
  Phase.thaw: 'thaw',
  Phase.draw: 'draw',
  Phase.regen: 'regen',
  Phase.drift: 'drift',
  Phase.burn: 'burn',
  Phase.activate: 'activate',
  Phase.shootyShoot: 'shootyShoot',
};

const _$PlayerTypeEnumMap = {
  PlayerType.firstPlayer: 'firstPlayer',
  PlayerType.secondPlayer: 'secondPlayer',
};
