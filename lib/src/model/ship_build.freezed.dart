// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ship_build.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ShipBuild _$ShipBuildFromJson(Map<String, dynamic> json) {
  return _ShipBuild.fromJson(json);
}

/// @nodoc
mixin _$ShipBuild {
  Side get forward => throw _privateConstructorUsedError;
  Side get aft => throw _privateConstructorUsedError;
  Side get port => throw _privateConstructorUsedError;
  Side get starboard => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShipBuildCopyWith<ShipBuild> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShipBuildCopyWith<$Res> {
  factory $ShipBuildCopyWith(ShipBuild value, $Res Function(ShipBuild) then) =
      _$ShipBuildCopyWithImpl<$Res, ShipBuild>;
  @useResult
  $Res call({Side forward, Side aft, Side port, Side starboard});

  $SideCopyWith<$Res> get forward;
  $SideCopyWith<$Res> get aft;
  $SideCopyWith<$Res> get port;
  $SideCopyWith<$Res> get starboard;
}

/// @nodoc
class _$ShipBuildCopyWithImpl<$Res, $Val extends ShipBuild>
    implements $ShipBuildCopyWith<$Res> {
  _$ShipBuildCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? forward = null,
    Object? aft = null,
    Object? port = null,
    Object? starboard = null,
  }) {
    return _then(_value.copyWith(
      forward: null == forward
          ? _value.forward
          : forward // ignore: cast_nullable_to_non_nullable
              as Side,
      aft: null == aft
          ? _value.aft
          : aft // ignore: cast_nullable_to_non_nullable
              as Side,
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as Side,
      starboard: null == starboard
          ? _value.starboard
          : starboard // ignore: cast_nullable_to_non_nullable
              as Side,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SideCopyWith<$Res> get forward {
    return $SideCopyWith<$Res>(_value.forward, (value) {
      return _then(_value.copyWith(forward: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SideCopyWith<$Res> get aft {
    return $SideCopyWith<$Res>(_value.aft, (value) {
      return _then(_value.copyWith(aft: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SideCopyWith<$Res> get port {
    return $SideCopyWith<$Res>(_value.port, (value) {
      return _then(_value.copyWith(port: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SideCopyWith<$Res> get starboard {
    return $SideCopyWith<$Res>(_value.starboard, (value) {
      return _then(_value.copyWith(starboard: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ShipBuildCopyWith<$Res> implements $ShipBuildCopyWith<$Res> {
  factory _$$_ShipBuildCopyWith(
          _$_ShipBuild value, $Res Function(_$_ShipBuild) then) =
      __$$_ShipBuildCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Side forward, Side aft, Side port, Side starboard});

  @override
  $SideCopyWith<$Res> get forward;
  @override
  $SideCopyWith<$Res> get aft;
  @override
  $SideCopyWith<$Res> get port;
  @override
  $SideCopyWith<$Res> get starboard;
}

/// @nodoc
class __$$_ShipBuildCopyWithImpl<$Res>
    extends _$ShipBuildCopyWithImpl<$Res, _$_ShipBuild>
    implements _$$_ShipBuildCopyWith<$Res> {
  __$$_ShipBuildCopyWithImpl(
      _$_ShipBuild _value, $Res Function(_$_ShipBuild) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? forward = null,
    Object? aft = null,
    Object? port = null,
    Object? starboard = null,
  }) {
    return _then(_$_ShipBuild(
      forward: null == forward
          ? _value.forward
          : forward // ignore: cast_nullable_to_non_nullable
              as Side,
      aft: null == aft
          ? _value.aft
          : aft // ignore: cast_nullable_to_non_nullable
              as Side,
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as Side,
      starboard: null == starboard
          ? _value.starboard
          : starboard // ignore: cast_nullable_to_non_nullable
              as Side,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ShipBuild extends _ShipBuild {
  const _$_ShipBuild(
      {required this.forward,
      required this.aft,
      required this.port,
      required this.starboard})
      : super._();

  factory _$_ShipBuild.fromJson(Map<String, dynamic> json) =>
      _$$_ShipBuildFromJson(json);

  @override
  final Side forward;
  @override
  final Side aft;
  @override
  final Side port;
  @override
  final Side starboard;

  @override
  String toString() {
    return 'ShipBuild(forward: $forward, aft: $aft, port: $port, starboard: $starboard)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ShipBuild &&
            (identical(other.forward, forward) || other.forward == forward) &&
            (identical(other.aft, aft) || other.aft == aft) &&
            (identical(other.port, port) || other.port == port) &&
            (identical(other.starboard, starboard) ||
                other.starboard == starboard));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, forward, aft, port, starboard);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ShipBuildCopyWith<_$_ShipBuild> get copyWith =>
      __$$_ShipBuildCopyWithImpl<_$_ShipBuild>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ShipBuildToJson(
      this,
    );
  }
}

abstract class _ShipBuild extends ShipBuild {
  const factory _ShipBuild(
      {required final Side forward,
      required final Side aft,
      required final Side port,
      required final Side starboard}) = _$_ShipBuild;
  const _ShipBuild._() : super._();

  factory _ShipBuild.fromJson(Map<String, dynamic> json) =
      _$_ShipBuild.fromJson;

  @override
  Side get forward;
  @override
  Side get aft;
  @override
  Side get port;
  @override
  Side get starboard;
  @override
  @JsonKey(ignore: true)
  _$$_ShipBuildCopyWith<_$_ShipBuild> get copyWith =>
      throw _privateConstructorUsedError;
}
