import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tyrant_engine/src/model/dice.dart';
import 'package:tyrant_engine/src/model/weapon_slot.dart';

part 'weapon.freezed.dart';
part 'weapon.g.dart';

@freezed
class Weapon with _$Weapon {
  const Weapon._();

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

  factory Weapon.fromJson(Map<String, dynamic> json) => _$WeaponFromJson(json);

  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object? other) => other is Weapon && other.name == this.name;
}
