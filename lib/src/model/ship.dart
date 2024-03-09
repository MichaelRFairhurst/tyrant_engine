import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tyrant_engine/src/model/ship_build.dart';
import 'package:tyrant_engine/src/rules/geometry.dart';

part 'ship.freezed.dart';

@freezed
class Ship with _$Ship implements Point {
  const factory Ship({
    @Default(60) int hp,
    required ShipBuild build,
    required int x,
    required int y,
    @Default(0) int momentumForward,
    @Default(0) int momentumLateral,
    @Default(0) int momentumRotary,
  }) = _Ship;
}
