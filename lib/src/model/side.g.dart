// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'side.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Side _$$_SideFromJson(Map<String, dynamic> json) => _$_Side(
      armor: (json['armor'] as num?)?.toDouble(),
      weapons: (json['weapons'] as List<dynamic>)
          .map((e) => WeaponSlot.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_SideToJson(_$_Side instance) => <String, dynamic>{
      'armor': instance.armor,
      'weapons': instance.weapons,
    };
