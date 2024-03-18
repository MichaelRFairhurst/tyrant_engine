import 'dart:math';

import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/model/ship.dart';
import 'package:tyrant_engine/src/model/ship_build.dart';

class Geometry {
  double distance(Point a, Point b) {
    final distX = a.x - b.x;
    final distY = a.y - b.y;
    return sqrt(distX * distX + distY * distY);
  }

  double range(Game game) {
    return distance(game.firstPlayer.ship, game.secondPlayer.ship);
  }

  Set<Quadrant> targetingArcs({required Ship firing, required Point target}) {
    final distX = target.x - firing.x;
    final distY = target.y - firing.y;

    final int heading = firing.orientation;
    //final globalBearing = roughDegrees(distX, distY);
    final globalBearing = (atan2(distX, distY) / 45).round() * 45;

    final bearing = normalizeAngle(globalBearing - heading);

    switch (bearing) {
      case 0:
        return {Quadrant.forward};
      case 45:
        return {Quadrant.forward, Quadrant.starboard};
      case 90:
        return {Quadrant.starboard};
      case 135:
        return {Quadrant.starboard, Quadrant.aft};
      case 180:
        return {Quadrant.aft};
      case 225:
        return {Quadrant.aft, Quadrant.port};
      case 270:
        return {Quadrant.port};
      case 315:
        return {Quadrant.port, Quadrant.forward};
      default:
        throw 'only round degrees are supported; $bearing';
    }
  }

  Quadrant? targetedArc({required Point firing, required Ship target}) {
    // The sides of the target ship exposed to the firing ship are similar to
    // the sides of the target ship aimed at the firing ship.
    final arcsExposed = targetingArcs(firing: target, target: firing);

    // If we aren't head on fore or aft, return the side we're erring to.
    if (arcsExposed.contains(Quadrant.port)) {
      return Quadrant.port;
    } else if (arcsExposed.contains(Quadrant.starboard)) {
      return Quadrant.starboard;
    }

    // This means we're facing head on and get no armor benefit.
    return null;
  }

  int rotateTicks(int degrees, int ticks) =>
      normalizeAngle(degrees + 45 * ticks);

  int normalizeAngle(int degrees) => degrees % 360;

  // Uses a clock based degree system, so zero degrees = 12 o'clock.
  int roughDegrees(num distX, num distY) {
    if (distX == 0) {
      if (distY > 0) {
        return 0;
      } else {
        // distY < 0
        return 180;
      }
    } else if (distX > 0) {
      if (distY == 0) {
        return 90;
      } else if (distY > 0) {
        return 45;
      } else {
        // distY < 0
        return 135;
      }
    } else {
      // distX < 0
      if (distY == 0) {
        return 270;
      } else if (distY > 0) {
        return 315;
      } else {
        // distY < 0
        return 225;
      }
    }
  }
}

abstract class Point {
  num get x;
  num get y;
}
