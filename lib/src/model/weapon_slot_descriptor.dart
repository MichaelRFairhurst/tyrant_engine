import 'package:freezed_annotation/freezed_annotation.dart';

part 'weapon_slot_descriptor.freezed.dart';

@freezed
class WeaponSlotDescriptor with _$WeaponSlotDescriptor {
  const factory WeaponSlotDescripton({
    required Quadrant quadrant,
    required int slotIdx,
  }) = _WeaponSlotDescriptor;
}
