import 'package:tyrant_engine/src/model/dice.dart';
import 'package:tyrant_engine/src/model/weapon.dart';
import 'package:tyrant_engine/src/model/weapon_slot.dart';

const longstrikeRailgun = Weapon(
  name: 'Longstrike Railgun',
  type: WeaponSlotType.railgun,
  shieldBonus: -1,
  armorBonus: 0,
  hullBonus: 0,
  crewBonus: 0,
  damage: r1d6,
  ru: 2,
  heat: 0,
  oht: 5,
  range: 72,
);
