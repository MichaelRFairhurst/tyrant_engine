import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/model/player.dart';
import 'package:tyrant_engine/src/model/ship.dart';
import 'package:tyrant_engine/src/model/ship_build.dart';
import 'package:tyrant_engine/src/model/weapon_slot.dart';

class Printer {
  Game? lastGame;

  void setGame(Game game) {
    lastGame = game;
  }

  void printGame(Game game) {
    if (lastGame == game) {
      return;
    }

    if (lastGame?.firstPlayer != game.firstPlayer) {
      if (lastGame?.firstPlayer.copyWith(ship: game.firstPlayer.ship) !=
          game.firstPlayer) {
        printPlayerInfo(game.firstPlayer, PlayerType.firstPlayer);
      }
      if (lastGame?.firstPlayer.ship != game.firstPlayer.ship) {
        printShipInfo(game.firstPlayer.ship, PlayerType.firstPlayer);
      }
    }
    if (lastGame?.secondPlayer != game.secondPlayer) {
      if (lastGame?.secondPlayer.copyWith(ship: game.secondPlayer.ship) !=
          game.secondPlayer) {
        printPlayerInfo(game.secondPlayer, PlayerType.secondPlayer);
      }
      if (lastGame?.secondPlayer.ship != game.secondPlayer.ship) {
        printShipInfo(game.secondPlayer.ship, PlayerType.secondPlayer);
      }
    }

    if ((lastGame?.projectiles.length ?? 0) == 0) {
      if (game.projectiles.isNotEmpty) {
        printProjectiles(game);
      }
    } else if (lastGame?.projectiles != game.projectiles) {
      printProjectiles(game);
    }

    lastGame = game;
  }

  void printProjectiles(Game game) {
    print('');
    print('====> PROJECTILES');
    for (var projectile in game.projectiles) {
      print(
          '==> (${projectile.x}, ${projectile.y}) ${projectile.firedBy} ${projectile.weapon.name}');
    }
    print('');
  }

  void printPlayerInfo(Player player, PlayerType type) {
    final crewStr = player.crew
        .map((c) => c.toString().replaceAll("CrewState.", ''))
        .toList();
    print('|| PLAYER: $type');
    print('|| ru: ${player.ru}');
    print('|| heat: ${player.heat}');
    print('|| hand: ${player.hand.map((weapon) => weapon.name).toList()}');
    print('|| crew: $crewStr');
    print('');
  }

  void printShipInfo(Ship ship, PlayerType player) {
    final str = r'''
|||||     FORWARD: {WEAPON_NAME_F0} [{F0TAPPED}], {WEAPON_NAME_F1} [{F1TAPPED}]
|||||
|||||                               || ||
|||||  {WEAPON_NAME_P0}[{P0TAPPED}] | U | {WEAPON_NAME_S0}[{S0TAPPED}]
|||||  {WEAPON_NAME_P1}[{P1TAPPED}] | - | {WEAPON_NAME_S1}[{S1TAPPED}]
|||||  {WEAPON_NAME_P2}[{P2TAPPED}] | - | {WEAPON_NAME_S2}[{S2TAPPED}]
|||||  {WEAPON_NAME_P3}[{P3TAPPED}] | _ | {WEAPON_NAME_S3}[{S3TAPPED}]
|||||       AP: {AP_PORT}   [     ] [/ \]       AP: {AP_STARBOARD}
|||||
||||| 	AFT: {WEAPON_NAME_A0} [{A0TAPPED}], {WEAPON_NAME_A1} [{A1TAPPED}]
|||||
|||||                                 {MOF}
|||||                                 ^
|||||                                 |
|||||                             ({x}, {y}) --> {MOL}
|||||
''';

    print('||||| PLAYER $player SHIP:');
    print('||||| hp: ${ship.hp}');
    print('|||||');
    print(fixedLengthReplace(str, {
      'x': ship.x.toString(),
      'y': ship.y.toString(),
      'MOF': ship.momentumForward.toString(),
      'MOL': ship.momentumLateral.toString(),
      ...weaponSlotReplacementMap(ship.build),
    }));
    print('');
  }

  Map<String, String> weaponSlotReplacementMap(ShipBuild ship) {
    return {
      'AP_PORT': ship.port.armor.toString(),
      'AP_STARBOARD': ship.starboard.armor.toString(),
      for (int i = 0; i < ship.forward.weapons.length; ++i) ...{
        'WEAPON_NAME_F$i': ship.forward.weapons[i].deployed?.name ??
            'inactive ${wtype(ship.forward.weapons[i].type)}',
        'F${i}TAPPED': '${ship.forward.weapons[i].tappedCount}'
            '/${ship.forward.weapons[i].deployCount}',
      },
      for (int i = 0; i < ship.aft.weapons.length; ++i) ...{
        'WEAPON_NAME_A$i': ship.aft.weapons[i].deployed?.name ??
            'inactive ${wtype(ship.aft.weapons[i].type)}',
        'A${i}TAPPED': '${ship.aft.weapons[i].tappedCount}'
            '/${ship.aft.weapons[i].deployCount}',
      },
      for (int i = 0; i < ship.port.weapons.length; ++i) ...{
        'WEAPON_NAME_P$i': ship.port.weapons[i].deployed?.name ??
            'inactive ${wtype(ship.port.weapons[i].type)}',
        'P${i}TAPPED': '${ship.port.weapons[i].tappedCount}'
            '/${ship.port.weapons[i].deployCount}',
      },
      for (int i = 0; i < ship.starboard.weapons.length; ++i) ...{
        'WEAPON_NAME_S$i': ship.starboard.weapons[i].deployed?.name ??
            'inactive ${wtype(ship.starboard.weapons[i].type)}',
        'S${i}TAPPED': '${ship.starboard.weapons[i].tappedCount}'
            '/${ship.starboard.weapons[i].deployCount}',
      },
    };
  }

  String wtype(WeaponSlotType type) =>
      type.toString().replaceAll('WeaponSlotType.', '');

  String fixedLengthReplace(String val, Map<String, String> parts) {
    for (final entry in parts.entries) {
      final find = '{${entry.key}}';
      final replace = entry.value.padRight(find.length);
      val = val.replaceAll(find, replace.substring(0, find.length));
    }

    return val;
  }
}
