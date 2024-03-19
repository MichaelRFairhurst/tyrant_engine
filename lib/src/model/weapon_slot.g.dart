// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weapon_slot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WeaponSlot _$$_WeaponSlotFromJson(Map<String, dynamic> json) =>
    _$_WeaponSlot(
      type: $enumDecode(_$WeaponSlotTypeEnumMap, json['type']),
      deployed: json['deployed'] == null
          ? null
          : Weapon.fromJson(json['deployed'] as Map<String, dynamic>),
      deployCount: json['deployCount'] as int? ?? 0,
      tappedCount: json['tappedCount'] as int? ?? 0,
    );

Map<String, dynamic> _$$_WeaponSlotToJson(_$_WeaponSlot instance) =>
    <String, dynamic>{
      'type': _$WeaponSlotTypeEnumMap[instance.type]!,
      'deployed': instance.deployed,
      'deployCount': instance.deployCount,
      'tappedCount': instance.tappedCount,
    };

const _$WeaponSlotTypeEnumMap = {
  WeaponSlotType.railgun: 'railgun',
  WeaponSlotType.chaingun: 'chaingun',
  WeaponSlotType.autocannon: 'autocannon',
  WeaponSlotType.torpedo: 'torpedo',
  WeaponSlotType.missile: 'missile',
};
