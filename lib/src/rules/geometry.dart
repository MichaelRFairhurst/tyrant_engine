import 'dart:math';

class Geometry {
  double distance(Point a, Point b) {
    final distX = a.x - b.x;
    final distY = a.y - b.y;
    return sqrt(distX * distX + distY * distY);
  }
}

abstract class Point {
  num get x;
  num get y;
}
