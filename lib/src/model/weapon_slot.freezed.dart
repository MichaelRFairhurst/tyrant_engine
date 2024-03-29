// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'weapon_slot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WeaponSlot _$WeaponSlotFromJson(Map<String, dynamic> json) {
  return _WeaponSlot.fromJson(json);
}

/// @nodoc
mixin _$WeaponSlot {
  WeaponSlotType get type => throw _privateConstructorUsedError;
  Weapon? get deployed => throw _privateConstructorUsedError;
  int get deployCount => throw _privateConstructorUsedError;
  int get tappedCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeaponSlotCopyWith<WeaponSlot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeaponSlotCopyWith<$Res> {
  factory $WeaponSlotCopyWith(
          WeaponSlot value, $Res Function(WeaponSlot) then) =
      _$WeaponSlotCopyWithImpl<$Res, WeaponSlot>;
  @useResult
  $Res call(
      {WeaponSlotType type,
      Weapon? deployed,
      int deployCount,
      int tappedCount});

  $WeaponCopyWith<$Res>? get deployed;
}

/// @nodoc
class _$WeaponSlotCopyWithImpl<$Res, $Val extends WeaponSlot>
    implements $WeaponSlotCopyWith<$Res> {
  _$WeaponSlotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? deployed = freezed,
    Object? deployCount = null,
    Object? tappedCount = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as WeaponSlotType,
      deployed: freezed == deployed
          ? _value.deployed
          : deployed // ignore: cast_nullable_to_non_nullable
              as Weapon?,
      deployCount: null == deployCount
          ? _value.deployCount
          : deployCount // ignore: cast_nullable_to_non_nullable
              as int,
      tappedCount: null == tappedCount
          ? _value.tappedCount
          : tappedCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $WeaponCopyWith<$Res>? get deployed {
    if (_value.deployed == null) {
      return null;
    }

    return $WeaponCopyWith<$Res>(_value.deployed!, (value) {
      return _then(_value.copyWith(deployed: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_WeaponSlotCopyWith<$Res>
    implements $WeaponSlotCopyWith<$Res> {
  factory _$$_WeaponSlotCopyWith(
          _$_WeaponSlot value, $Res Function(_$_WeaponSlot) then) =
      __$$_WeaponSlotCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {WeaponSlotType type,
      Weapon? deployed,
      int deployCount,
      int tappedCount});

  @override
  $WeaponCopyWith<$Res>? get deployed;
}

/// @nodoc
class __$$_WeaponSlotCopyWithImpl<$Res>
    extends _$WeaponSlotCopyWithImpl<$Res, _$_WeaponSlot>
    implements _$$_WeaponSlotCopyWith<$Res> {
  __$$_WeaponSlotCopyWithImpl(
      _$_WeaponSlot _value, $Res Function(_$_WeaponSlot) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? deployed = freezed,
    Object? deployCount = null,
    Object? tappedCount = null,
  }) {
    return _then(_$_WeaponSlot(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as WeaponSlotType,
      deployed: freezed == deployed
          ? _value.deployed
          : deployed // ignore: cast_nullable_to_non_nullable
              as Weapon?,
      deployCount: null == deployCount
          ? _value.deployCount
          : deployCount // ignore: cast_nullable_to_non_nullable
              as int,
      tappedCount: null == tappedCount
          ? _value.tappedCount
          : tappedCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WeaponSlot implements _WeaponSlot {
  const _$_WeaponSlot(
      {required this.type,
      this.deployed,
      this.deployCount = 0,
      this.tappedCount = 0});

  factory _$_WeaponSlot.fromJson(Map<String, dynamic> json) =>
      _$$_WeaponSlotFromJson(json);

  @override
  final WeaponSlotType type;
  @override
  final Weapon? deployed;
  @override
  @JsonKey()
  final int deployCount;
  @override
  @JsonKey()
  final int tappedCount;

  @override
  String toString() {
    return 'WeaponSlot(type: $type, deployed: $deployed, deployCount: $deployCount, tappedCount: $tappedCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WeaponSlot &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.deployed, deployed) ||
                other.deployed == deployed) &&
            (identical(other.deployCount, deployCount) ||
                other.deployCount == deployCount) &&
            (identical(other.tappedCount, tappedCount) ||
                other.tappedCount == tappedCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, deployed, deployCount, tappedCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WeaponSlotCopyWith<_$_WeaponSlot> get copyWith =>
      __$$_WeaponSlotCopyWithImpl<_$_WeaponSlot>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WeaponSlotToJson(
      this,
    );
  }
}

abstract class _WeaponSlot implements WeaponSlot {
  const factory _WeaponSlot(
      {required final WeaponSlotType type,
      final Weapon? deployed,
      final int deployCount,
      final int tappedCount}) = _$_WeaponSlot;

  factory _WeaponSlot.fromJson(Map<String, dynamic> json) =
      _$_WeaponSlot.fromJson;

  @override
  WeaponSlotType get type;
  @override
  Weapon? get deployed;
  @override
  int get deployCount;
  @override
  int get tappedCount;
  @override
  @JsonKey(ignore: true)
  _$$_WeaponSlotCopyWith<_$_WeaponSlot> get copyWith =>
      throw _privateConstructorUsedError;
}
