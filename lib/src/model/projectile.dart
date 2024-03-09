import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tyrant_engine/src/model/weapon.dart';
import 'package:tyrant_engine/src/rules/geometry.dart';

part 'projectile.freezed.dart';

@freezed
class Projectile with _$Projectile implements Point {
  const factory Projectile({
    required double x,
    required double y,
    required Weapon weapon,
    required bool friendly,
  }) = _Projectile;
}
