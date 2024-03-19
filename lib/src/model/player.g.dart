// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Player _$$_PlayerFromJson(Map<String, dynamic> json) => _$_Player(
      ru: json['ru'] as int? ?? 10,
      heat: json['heat'] as int? ?? 0,
      crew: (json['crew'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$CrewStateEnumMap, e))
              .toList() ??
          startingCrew,
      ship: Ship.fromJson(json['ship'] as Map<String, dynamic>),
      hand: Deck.fromJson((json['hand'] as List<dynamic>)
          .map((e) => (e as Map<String, dynamic>).map(
                (k, e) => MapEntry(k, e as Object),
              ))
          .toList()),
      deck: Deck.fromJson((json['deck'] as List<dynamic>)
          .map((e) => (e as Map<String, dynamic>).map(
                (k, e) => MapEntry(k, e as Object),
              ))
          .toList()),
    );

Map<String, dynamic> _$$_PlayerToJson(_$_Player instance) => <String, dynamic>{
      'ru': instance.ru,
      'heat': instance.heat,
      'crew': instance.crew.map((e) => _$CrewStateEnumMap[e]!).toList(),
      'ship': instance.ship,
      'hand': instance.hand,
      'deck': instance.deck,
    };

const _$CrewStateEnumMap = {
  CrewState.cryo: 'cryo',
  CrewState.active: 'active',
  CrewState.killed: 'killed',
};
