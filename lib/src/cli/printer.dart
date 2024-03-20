import 'dart:math';

import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/model/player.dart';
import 'package:tyrant_engine/src/model/projectile.dart';
import 'package:tyrant_engine/src/model/ship.dart';
import 'package:tyrant_engine/src/model/ship_build.dart';
import 'package:tyrant_engine/src/model/weapon_slot.dart';
import 'package:tyrant_engine/src/rules/action.dart';
import 'package:tyrant_engine/src/rules/outcomes.dart';

abstract class Printer {
  void initGame(Game game);

  void gameOver(Game game, PlayerType winner);

  void newRound(Game game);

  void newTurn(Game game);

  void startPhase(Game game);

  void chosenAction(Action action);

  void randomOutcome(RandomOutcome outcome);

  void printGame(Game game);
}

class NoopPrinter implements Printer {
  @override
  void initGame(Game game) {}

  @override
  void gameOver(Game game, PlayerType winner) {}

  @override
  void newRound(Game game) {}

  @override
  void newTurn(Game game) {}

  @override
  void startPhase(Game game) {}

  @override
  void chosenAction(Action action) {}

  @override
  void randomOutcome(RandomOutcome outcome) {}

  @override
  void printGame(Game game) {}
}

class CliPrinter implements Printer {
  Game? lastGame;

  @override
  void initGame(Game game) {
    print('----- NEW GAME! ----');
    printGame(game);
    print('');
    print('');
  }

  @override
  void gameOver(Game game, PlayerType winner) {
    print('');
    print('');
    printGame(game);
    print('----GAME OVER!-----');
    print('----$winner Wins!-----');
  }

  @override
  void newRound(Game game) {
    print('');
    print('!!!!!!!--------- NEW ROUND: ${game.round} ---------!!!!!!!');
    print('');
  }

  @override
  void newTurn(Game game) {
    print('--- NEW TURN: ${game.turn} ----');
    print('');
  }

  @override
  void startPhase(Game game) {
    print('-[${game.phase}]');
  }

  @override
  void chosenAction(Action action) {
    print('-[ACTION: $action]');
  }

  @override
  void randomOutcome(RandomOutcome outcome) {
    print('-[Random outcome: ${outcome.explanation()}]');
    printGame(outcome.result);
    print('');
  }

  @override
  void printGame(Game game) {
    if (lastGame == game) {
      return;
    }

    if (lastGame?.firstPlayer != game.firstPlayer) {
      if (lastGame?.firstPlayer.copyWith(ship: game.firstPlayer.ship) !=
          game.firstPlayer) {
        printPlayerInfo(game.firstPlayer, PlayerType.firstPlayer);
      }
    }
    if (lastGame?.secondPlayer != game.secondPlayer) {
      if (lastGame?.secondPlayer.copyWith(ship: game.secondPlayer.ship) !=
          game.secondPlayer) {
        printPlayerInfo(game.secondPlayer, PlayerType.secondPlayer);
      }
    }

    if (lastGame?.firstPlayer.ship != game.firstPlayer.ship ||
        lastGame?.secondPlayer.ship != game.secondPlayer.ship) {
      printBoard(game);
      printShipsInfo(game);
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
    print('|| hand: ${player.hand}');
    print('|| crew: $crewStr');
    print('');
  }

  void printShipsInfo(Game game) {
    final firstPlayerStr =
        shipInfoStr(game.firstPlayer.ship, PlayerType.firstPlayer);
    final secondPlayerStr =
        shipInfoStr(game.secondPlayer.ship, PlayerType.secondPlayer);
    final firstPlayerLines = firstPlayerStr.split('\n');
    final secondPlayerLines = secondPlayerStr.split('\n');

    print('');
    for (int i = 0; i < firstPlayerLines.length; ++i) {
      final left = firstPlayerLines[i].padRight(75);
      final right = secondPlayerLines[i].padRight(75);
      print('||||| $left || $right |||||');
    }
    print('');
  }

  String shipInfoStr(Ship ship, PlayerType player) {
    final str = r'''
PLAYER {PLAYER_TYPE_STR} SHIP:
  hp: {HP_STR}

  FORWARD: {WEAPON_NAME_F0} [{F0TAPPED}], {WEAPON_NAME_F1} [{F1TAPPED}]

                              || ||
 {WEAPON_NAME_P0}[{P0TAPPED}] | U | {WEAPON_NAME_S0}[{S0TAPPED}]
 {WEAPON_NAME_P1}[{P1TAPPED}] | - | {WEAPON_NAME_S1}[{S1TAPPED}]
 {WEAPON_NAME_P2}[{P2TAPPED}] | - | {WEAPON_NAME_S2}[{S2TAPPED}]
 {WEAPON_NAME_P3}[{P3TAPPED}] | _ | {WEAPON_NAME_S3}[{S3TAPPED}]
      AP: {AP_PORT}   [     ] [/ \]       AP: {AP_STARBOARD}

  AFT: {WEAPON_NAME_A0} [{A0TAPPED}], {WEAPON_NAME_A1} [{A1TAPPED}]

                                {MOF}
                                ^
                                |
                            ({x}, {y}) --> {MOL}
                            Orientation: {ORIENT}
                            Spinning: {SPIN}
''';

    return fixedLengthReplace(str, {
      'PLAYER_TYPE_STR': player.toString().replaceAll('PlayerType.', ''),
      'HP_STR': ship.hp.toString(),
      'x': ship.x.toString(),
      'y': ship.y.toString(),
      'ORIENT': ship.orientation.toString(),
      'MOF': ship.momentumForward.toString(),
      'MOL': ship.momentumLateral.toString(),
      'SPIN': ship.momentumRotary.toString(),
      ...weaponSlotReplacementMap(ship.build),
    });
  }

  void printBoard(Game game) {
    final sizeX = game.distanceX + 12;
    final ship1 = game.firstPlayer.ship;
    final ship2 = game.secondPlayer.ship;
    final relativeX = min(ship1.x, ship2.x);
    final minY = min(ship1.y, ship2.y) - 3;
    final maxY = max(ship1.y, ship2.y) + 3;

    final topBottomLine = '+' * (sizeX + 2);
    var output = topBottomLine;
    for (var y = maxY; y >= minY; --y) {
      var line = ' ' * sizeX;
      line = putShip(line, y, ship1, relativeX - 6);
      line = putShip(line, y, ship2, relativeX - 6);
      for (final projectile in game.projectiles) {
        if (projectile.y.round() == y) {
          line = putProjectile(line, projectile, relativeX - 6);
        }
      }
      output = '$output\n+$line+';
    }
    output = '$output\n$topBottomLine';

    print('BOARD:');
    print(output);
  }

  String putProjectile(String str, Projectile projectile, int relativeX) {
    final dotType = projectile.firedBy == PlayerType.firstPlayer ? '1' : '2';
    return str.replaceRange(projectile.x.round() - relativeX,
        projectile.x.round() + 1 - relativeX, dotType);
  }

  String putShip(String str, int y, Ship ship, int relativeX) {
    String charAt(int offset, String char) {
      return str.replaceRange(
          ship.x + offset - relativeX, ship.x + offset + 1 - relativeX, char);
    }

    if (y == ship.y + 1) {
      switch (ship.orientation) {
        case 90:
        case 270:
          break;
        case 0:
          return charAt(0, '^');
        case 45:
          return charAt(1, '*');
        case 135:
          return charAt(-1, r'\');
        case 180:
          return charAt(0, '|');
        case 225:
          return charAt(1, '/');
        case 315:
          return charAt(-1, '*');
      }
    } else if (y == ship.y) {
      switch (ship.orientation) {
        case 90:
          return str.replaceRange(
              ship.x - 1 - relativeX, ship.x + 2 - relativeX, '-->');
        case 270:
          return str.replaceRange(
              ship.x - 1 - relativeX, ship.x + 2 - relativeX, '<--');
        case 0:
        case 180:
          return charAt(0, '|');
        case 45:
        case 225:
          return charAt(0, '/');
        case 135:
        case 315:
          return charAt(0, r'\');
      }
    } else if (y == ship.y - 1) {
      switch (ship.orientation) {
        case 90:
        case 270:
          break;
        case 0:
          return charAt(0, '|');
        case 45:
          return charAt(-1, '/');
        case 135:
          return charAt(1, '*');
        case 180:
          return charAt(0, 'V');
        case 225:
          return charAt(-1, '*');
        case 315:
          return charAt(1, r'\');
      }
    }
    return str;
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
