import 'package:tyrant_engine/src/model/ship_build.dart';
import 'package:tyrant_engine/src/model/side.dart';
import 'package:tyrant_engine/src/model/weapon_slot.dart';
import 'package:tyrant_engine/src/rules/constants.dart';

const defaultBuild = ShipBuild(
  forward: Side(
    weapons: [
      WeaponSlot(
        type: WeaponSlotType.torpedo,
      ),
      WeaponSlot(
        type: WeaponSlotType.torpedo,
      ),
    ],
  ),
  aft: Side(
    weapons: [
      WeaponSlot(
        type: WeaponSlotType.missile,
      ),
      WeaponSlot(
        type: WeaponSlotType.missile,
      ),
    ],
  ),
  port: Side(
    armor: startingArmor,
    weapons: [
      WeaponSlot(
        type: WeaponSlotType.railgun,
      ),
      WeaponSlot(
        type: WeaponSlotType.railgun,
      ),
      WeaponSlot(
        type: WeaponSlotType.railgun,
      ),
      WeaponSlot(
        type: WeaponSlotType.chaingun,
      ),
    ],
  ),
  starboard: Side(
    armor: startingArmor,
    weapons: [
      WeaponSlot(
        type: WeaponSlotType.autocannon,
      ),
      WeaponSlot(
        type: WeaponSlotType.autocannon,
      ),
      WeaponSlot(
        type: WeaponSlotType.autocannon,
      ),
      WeaponSlot(
        type: WeaponSlotType.chaingun,
      ),
    ],
  ),
);
