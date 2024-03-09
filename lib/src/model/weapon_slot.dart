import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tyrant_engine/src/model/weapon.dart';

part 'weapon_slot.freezed.dart';

enum WeaponSlotType {
  railgun,
  chaingun,
  autocannon,
  torpedo,
  missile,
}

@freezed
class WeaponSlot with _$WeaponSlot {
  const factory WeaponSlot({
    required WeaponSlotType type,
    Weapon? deployed,
    @Default(0) int deployCount,
    @Default(0) int tappedCount,
  }) = _WeaponSlot;
}
