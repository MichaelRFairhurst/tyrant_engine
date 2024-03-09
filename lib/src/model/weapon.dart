import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tyrant_engine/src/model/dice.dart';
import 'package:tyrant_engine/src/model/weapon_slot.dart';

part 'weapon.freezed.dart';

@freezed
class Weapon with _$Weapon {
  const factory Weapon({
    required String name,
    required WeaponSlotType type,
    required Dice damage,
    required int ru,
    required int heat,
    required int oht,
    required int shieldBonus,
    required int armorBonus,
    required int hullBonus,
    required int crewBonus,
    int? range,
    int? speed,
    @Default(0) int gyro,
  }) = _Weapon;
}
