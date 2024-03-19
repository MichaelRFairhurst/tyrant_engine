import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tyrant_engine/src/model/ship_build.dart';
import 'package:tyrant_engine/src/rules/geometry.dart';

part 'ship.freezed.dart';
part 'ship.g.dart';

@freezed
class Ship with _$Ship implements Point {
  const factory Ship({
    // use a doube for ship HP so we can simulate non integer values.
    @Default(60.0) double hp,
    required ShipBuild build,
    required int x,
    required int y,
    // Degrees, 0 = 12 oclock
    required int orientation,
    @Default(0) int momentumForward,
    @Default(0) int momentumLateral,
    @Default(0) int momentumRotary,
  }) = _Ship;

  factory Ship.fromJson(Map<String, dynamic> json) => _$ShipFromJson(json);
}
