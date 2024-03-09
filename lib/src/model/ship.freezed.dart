// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ship.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Ship {
  int get hp => throw _privateConstructorUsedError;
  ShipBuild get build => throw _privateConstructorUsedError;
  int get x => throw _privateConstructorUsedError;
  int get y => throw _privateConstructorUsedError;
  int get momentumForward => throw _privateConstructorUsedError;
  int get momentumLateral => throw _privateConstructorUsedError;
  int get momentumRotary => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ShipCopyWith<Ship> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShipCopyWith<$Res> {
  factory $ShipCopyWith(Ship value, $Res Function(Ship) then) =
      _$ShipCopyWithImpl<$Res, Ship>;
  @useResult
  $Res call(
      {int hp,
      ShipBuild build,
      int x,
      int y,
      int momentumForward,
      int momentumLateral,
      int momentumRotary});

  $ShipBuildCopyWith<$Res> get build;
}

/// @nodoc
class _$ShipCopyWithImpl<$Res, $Val extends Ship>
    implements $ShipCopyWith<$Res> {
  _$ShipCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hp = null,
    Object? build = null,
    Object? x = null,
    Object? y = null,
    Object? momentumForward = null,
    Object? momentumLateral = null,
    Object? momentumRotary = null,
  }) {
    return _then(_value.copyWith(
      hp: null == hp
          ? _value.hp
          : hp // ignore: cast_nullable_to_non_nullable
              as int,
      build: null == build
          ? _value.build
          : build // ignore: cast_nullable_to_non_nullable
              as ShipBuild,
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as int,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as int,
      momentumForward: null == momentumForward
          ? _value.momentumForward
          : momentumForward // ignore: cast_nullable_to_non_nullable
              as int,
      momentumLateral: null == momentumLateral
          ? _value.momentumLateral
          : momentumLateral // ignore: cast_nullable_to_non_nullable
              as int,
      momentumRotary: null == momentumRotary
          ? _value.momentumRotary
          : momentumRotary // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ShipBuildCopyWith<$Res> get build {
    return $ShipBuildCopyWith<$Res>(_value.build, (value) {
      return _then(_value.copyWith(build: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ShipCopyWith<$Res> implements $ShipCopyWith<$Res> {
  factory _$$_ShipCopyWith(_$_Ship value, $Res Function(_$_Ship) then) =
      __$$_ShipCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int hp,
      ShipBuild build,
      int x,
      int y,
      int momentumForward,
      int momentumLateral,
      int momentumRotary});

  @override
  $ShipBuildCopyWith<$Res> get build;
}

/// @nodoc
class __$$_ShipCopyWithImpl<$Res> extends _$ShipCopyWithImpl<$Res, _$_Ship>
    implements _$$_ShipCopyWith<$Res> {
  __$$_ShipCopyWithImpl(_$_Ship _value, $Res Function(_$_Ship) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hp = null,
    Object? build = null,
    Object? x = null,
    Object? y = null,
    Object? momentumForward = null,
    Object? momentumLateral = null,
    Object? momentumRotary = null,
  }) {
    return _then(_$_Ship(
      hp: null == hp
          ? _value.hp
          : hp // ignore: cast_nullable_to_non_nullable
              as int,
      build: null == build
          ? _value.build
          : build // ignore: cast_nullable_to_non_nullable
              as ShipBuild,
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as int,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as int,
      momentumForward: null == momentumForward
          ? _value.momentumForward
          : momentumForward // ignore: cast_nullable_to_non_nullable
              as int,
      momentumLateral: null == momentumLateral
          ? _value.momentumLateral
          : momentumLateral // ignore: cast_nullable_to_non_nullable
              as int,
      momentumRotary: null == momentumRotary
          ? _value.momentumRotary
          : momentumRotary // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_Ship implements _Ship {
  const _$_Ship(
      {this.hp = 60,
      required this.build,
      required this.x,
      required this.y,
      this.momentumForward = 0,
      this.momentumLateral = 0,
      this.momentumRotary = 0});

  @override
  @JsonKey()
  final int hp;
  @override
  final ShipBuild build;
  @override
  final int x;
  @override
  final int y;
  @override
  @JsonKey()
  final int momentumForward;
  @override
  @JsonKey()
  final int momentumLateral;
  @override
  @JsonKey()
  final int momentumRotary;

  @override
  String toString() {
    return 'Ship(hp: $hp, build: $build, x: $x, y: $y, momentumForward: $momentumForward, momentumLateral: $momentumLateral, momentumRotary: $momentumRotary)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Ship &&
            (identical(other.hp, hp) || other.hp == hp) &&
            (identical(other.build, build) || other.build == build) &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.momentumForward, momentumForward) ||
                other.momentumForward == momentumForward) &&
            (identical(other.momentumLateral, momentumLateral) ||
                other.momentumLateral == momentumLateral) &&
            (identical(other.momentumRotary, momentumRotary) ||
                other.momentumRotary == momentumRotary));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hp, build, x, y, momentumForward,
      momentumLateral, momentumRotary);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ShipCopyWith<_$_Ship> get copyWith =>
      __$$_ShipCopyWithImpl<_$_Ship>(this, _$identity);
}

abstract class _Ship implements Ship {
  const factory _Ship(
      {final int hp,
      required final ShipBuild build,
      required final int x,
      required final int y,
      final int momentumForward,
      final int momentumLateral,
      final int momentumRotary}) = _$_Ship;

  @override
  int get hp;
  @override
  ShipBuild get build;
  @override
  int get x;
  @override
  int get y;
  @override
  int get momentumForward;
  @override
  int get momentumLateral;
  @override
  int get momentumRotary;
  @override
  @JsonKey(ignore: true)
  _$$_ShipCopyWith<_$_Ship> get copyWith => throw _privateConstructorUsedError;
}