import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tyrant_engine/src/model/side.dart';
import 'package:tyrant_engine/src/model/weapon_slot.dart';
import 'package:tyrant_engine/src/model/weapon_slot_descriptor.dart';

part 'ship_build.freezed.dart';
part 'ship_build.g.dart';

enum Quadrant {
  forward,
  aft,
  port,
  starboard,
}

@freezed
class ShipBuild with _$ShipBuild {
  const ShipBuild._();

  const factory ShipBuild({
    required Side forward,
    required Side aft,
    required Side port,
    required Side starboard,
  }) = _ShipBuild;

  factory ShipBuild.fromJson(Map<String, dynamic> json) =>
      _$ShipBuildFromJson(json);

  List<Side> get allSides => [forward, aft, port, starboard];

  ShipBuild on({
    Side Function(Side)? forward,
    Side Function(Side)? aft,
    Side Function(Side)? port,
    Side Function(Side)? starboard,
  }) =>
      copyWith(
        forward: forward == null ? this.forward : forward(this.forward),
        aft: aft == null ? this.aft : aft(this.aft),
        port: port == null ? this.port : port(this.port),
        starboard:
            starboard == null ? this.starboard : starboard(this.starboard),
      );

  Side quadrant(Quadrant quadrant) {
    switch (quadrant) {
      case Quadrant.forward:
        return forward;
      case Quadrant.aft:
        return aft;
      case Quadrant.port:
        return port;
      case Quadrant.starboard:
        return starboard;
    }
  }

  WeaponSlot slot(WeaponSlotDescriptor descriptor) =>
      quadrant(descriptor.quadrant).weapons[descriptor.slotIdx];

  ShipBuild onQuadrant(Quadrant quadrant, Side Function(Side) update) {
    switch (quadrant) {
      case Quadrant.forward:
        return copyWith(forward: update(forward));
      case Quadrant.aft:
        return copyWith(aft: update(aft));
      case Quadrant.port:
        return copyWith(port: update(port));
      case Quadrant.starboard:
        return copyWith(starboard: update(starboard));
    }
  }

  ShipBuild onSlot(WeaponSlotDescriptor descriptor,
          WeaponSlot Function(WeaponSlot) update) =>
      onQuadrant(
        descriptor.quadrant,
        (side) => side.onSlot(descriptor.slotIdx, (slot) => update(slot)),
      );

  Map<WeaponSlotType, List<WeaponSlotDescriptor>> slotTypesMap() {
    final result = <WeaponSlotType, List<WeaponSlotDescriptor>>{};

    for (final quadrant in Quadrant.values) {
      final side = this.quadrant(quadrant);

      for (int i = 0; i < side.weapons.length; ++i) {
        final type = side.weapons[i].type;
        if (!result.containsKey(type)) {
          result[type] = <WeaponSlotDescriptor>[];
        }
        result[type]!.add(WeaponSlotDescriptor(quadrant: quadrant, slotIdx: i));
      }
    }

    return result;
  }
}
