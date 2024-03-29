// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'projectile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Projectile _$ProjectileFromJson(Map<String, dynamic> json) {
  return _Projectile.fromJson(json);
}

/// @nodoc
mixin _$Projectile {
  double get x => throw _privateConstructorUsedError;
  double get y => throw _privateConstructorUsedError;
  Weapon get weapon => throw _privateConstructorUsedError;
  PlayerType get firedBy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectileCopyWith<Projectile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectileCopyWith<$Res> {
  factory $ProjectileCopyWith(
          Projectile value, $Res Function(Projectile) then) =
      _$ProjectileCopyWithImpl<$Res, Projectile>;
  @useResult
  $Res call({double x, double y, Weapon weapon, PlayerType firedBy});

  $WeaponCopyWith<$Res> get weapon;
}

/// @nodoc
class _$ProjectileCopyWithImpl<$Res, $Val extends Projectile>
    implements $ProjectileCopyWith<$Res> {
  _$ProjectileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
    Object? weapon = null,
    Object? firedBy = null,
  }) {
    return _then(_value.copyWith(
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
      weapon: null == weapon
          ? _value.weapon
          : weapon // ignore: cast_nullable_to_non_nullable
              as Weapon,
      firedBy: null == firedBy
          ? _value.firedBy
          : firedBy // ignore: cast_nullable_to_non_nullable
              as PlayerType,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $WeaponCopyWith<$Res> get weapon {
    return $WeaponCopyWith<$Res>(_value.weapon, (value) {
      return _then(_value.copyWith(weapon: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ProjectileCopyWith<$Res>
    implements $ProjectileCopyWith<$Res> {
  factory _$$_ProjectileCopyWith(
          _$_Projectile value, $Res Function(_$_Projectile) then) =
      __$$_ProjectileCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double x, double y, Weapon weapon, PlayerType firedBy});

  @override
  $WeaponCopyWith<$Res> get weapon;
}

/// @nodoc
class __$$_ProjectileCopyWithImpl<$Res>
    extends _$ProjectileCopyWithImpl<$Res, _$_Projectile>
    implements _$$_ProjectileCopyWith<$Res> {
  __$$_ProjectileCopyWithImpl(
      _$_Projectile _value, $Res Function(_$_Projectile) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
    Object? weapon = null,
    Object? firedBy = null,
  }) {
    return _then(_$_Projectile(
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
      weapon: null == weapon
          ? _value.weapon
          : weapon // ignore: cast_nullable_to_non_nullable
              as Weapon,
      firedBy: null == firedBy
          ? _value.firedBy
          : firedBy // ignore: cast_nullable_to_non_nullable
              as PlayerType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Projectile implements _Projectile {
  const _$_Projectile(
      {required this.x,
      required this.y,
      required this.weapon,
      required this.firedBy});

  factory _$_Projectile.fromJson(Map<String, dynamic> json) =>
      _$$_ProjectileFromJson(json);

  @override
  final double x;
  @override
  final double y;
  @override
  final Weapon weapon;
  @override
  final PlayerType firedBy;

  @override
  String toString() {
    return 'Projectile(x: $x, y: $y, weapon: $weapon, firedBy: $firedBy)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Projectile &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.weapon, weapon) || other.weapon == weapon) &&
            (identical(other.firedBy, firedBy) || other.firedBy == firedBy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, x, y, weapon, firedBy);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProjectileCopyWith<_$_Projectile> get copyWith =>
      __$$_ProjectileCopyWithImpl<_$_Projectile>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProjectileToJson(
      this,
    );
  }
}

abstract class _Projectile implements Projectile {
  const factory _Projectile(
      {required final double x,
      required final double y,
      required final Weapon weapon,
      required final PlayerType firedBy}) = _$_Projectile;

  factory _Projectile.fromJson(Map<String, dynamic> json) =
      _$_Projectile.fromJson;

  @override
  double get x;
  @override
  double get y;
  @override
  Weapon get weapon;
  @override
  PlayerType get firedBy;
  @override
  @JsonKey(ignore: true)
  _$$_ProjectileCopyWith<_$_Projectile> get copyWith =>
      throw _privateConstructorUsedError;
}
