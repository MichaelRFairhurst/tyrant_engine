import 'dart:math';

import 'package:tyrant_engine/src/model/game.dart';

class Geometry {
  double distance(Point a, Point b) {
    final distX = a.x - b.x;
    final distY = a.y - b.y;
    return sqrt(distX * distX + distY * distY);
  }

  double range(Game game) {
    return distance(game.firstPlayer.ship, game.secondPlayer.ship);
  }
}

abstract class Point {
  num get x;
  num get y;
}
