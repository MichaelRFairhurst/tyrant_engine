// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weapon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Weapon _$$_WeaponFromJson(Map<String, dynamic> json) => _$_Weapon(
      name: json['name'] as String,
      type: $enumDecode(_$WeaponSlotTypeEnumMap, json['type']),
      damage: Dice.fromJson(json['damage'] as Map<String, dynamic>),
      ru: json['ru'] as int,
      heat: json['heat'] as int,
      oht: json['oht'] as int,
      shieldBonus: json['shieldBonus'] as int,
      armorBonus: json['armorBonus'] as int,
      hullBonus: json['hullBonus'] as int,
      crewBonus: json['crewBonus'] as int,
      range: json['range'] as int?,
      speed: json['speed'] as int?,
      gyro: json['gyro'] as int? ?? 0,
    );

Map<String, dynamic> _$$_WeaponToJson(_$_Weapon instance) => <String, dynamic>{
      'name': instance.name,
      'type': _$WeaponSlotTypeEnumMap[instance.type]!,
      'damage': instance.damage,
      'ru': instance.ru,
      'heat': instance.heat,
      'oht': instance.oht,
      'shieldBonus': instance.shieldBonus,
      'armorBonus': instance.armorBonus,
      'hullBonus': instance.hullBonus,
      'crewBonus': instance.crewBonus,
      'range': instance.range,
      'speed': instance.speed,
      'gyro': instance.gyro,
    };

const _$WeaponSlotTypeEnumMap = {
  WeaponSlotType.railgun: 'railgun',
  WeaponSlotType.chaingun: 'chaingun',
  WeaponSlotType.autocannon: 'autocannon',
  WeaponSlotType.torpedo: 'torpedo',
  WeaponSlotType.missile: 'missile',
};
