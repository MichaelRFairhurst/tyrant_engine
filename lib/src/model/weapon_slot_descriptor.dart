import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tyrant_engine/src/model/ship_build.dart';

part 'weapon_slot_descriptor.freezed.dart';

@freezed
class WeaponSlotDescriptor with _$WeaponSlotDescriptor {
  const factory WeaponSlotDescriptor({
    required Quadrant quadrant,
    required int slotIdx,
  }) = _WeaponSlotDescriptor;
}
