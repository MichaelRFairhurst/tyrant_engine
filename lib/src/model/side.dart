import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tyrant_engine/src/model/weapon_slot.dart';

part 'side.freezed.dart';
part 'side.g.dart';

@freezed
class Side with _$Side {
  const Side._();

  const factory Side({
    // A double so that we can simulate averaged damage, etc.
    double? armor,
    required List<WeaponSlot> weapons,
  }) = _Side;

  factory Side.fromJson(Map<String, dynamic> json) => _$SideFromJson(json);

  Side onSlot(int idx, WeaponSlot Function(WeaponSlot) update) {
    final newWeapon = update(weapons[idx]);
    return copyWith(
      weapons: weapons.toList()
        ..removeAt(idx)
        ..insert(idx, newWeapon),
    );
  }
}
