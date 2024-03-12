// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'weapon.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Weapon {
  String get name => throw _privateConstructorUsedError;
  WeaponSlotType get type => throw _privateConstructorUsedError;
  Dice get damage => throw _privateConstructorUsedError;
  int get ru => throw _privateConstructorUsedError;
  int get heat => throw _privateConstructorUsedError;
  int get oht => throw _privateConstructorUsedError;
  int get shieldBonus => throw _privateConstructorUsedError;
  int get armorBonus => throw _privateConstructorUsedError;
  int get hullBonus => throw _privateConstructorUsedError;
  int get crewBonus => throw _privateConstructorUsedError;
  int? get range => throw _privateConstructorUsedError;
  int? get speed => throw _privateConstructorUsedError;
  int get gyro => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WeaponCopyWith<Weapon> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeaponCopyWith<$Res> {
  factory $WeaponCopyWith(Weapon value, $Res Function(Weapon) then) =
      _$WeaponCopyWithImpl<$Res, Weapon>;
  @useResult
  $Res call(
      {String name,
      WeaponSlotType type,
      Dice damage,
      int ru,
      int heat,
      int oht,
      int shieldBonus,
      int armorBonus,
      int hullBonus,
      int crewBonus,
      int? range,
      int? speed,
      int gyro});

  $DiceCopyWith<$Res> get damage;
}

/// @nodoc
class _$WeaponCopyWithImpl<$Res, $Val extends Weapon>
    implements $WeaponCopyWith<$Res> {
  _$WeaponCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? damage = null,
    Object? ru = null,
    Object? heat = null,
    Object? oht = null,
    Object? shieldBonus = null,
    Object? armorBonus = null,
    Object? hullBonus = null,
    Object? crewBonus = null,
    Object? range = freezed,
    Object? speed = freezed,
    Object? gyro = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as WeaponSlotType,
      damage: null == damage
          ? _value.damage
          : damage // ignore: cast_nullable_to_non_nullable
              as Dice,
      ru: null == ru
          ? _value.ru
          : ru // ignore: cast_nullable_to_non_nullable
              as int,
      heat: null == heat
          ? _value.heat
          : heat // ignore: cast_nullable_to_non_nullable
              as int,
      oht: null == oht
          ? _value.oht
          : oht // ignore: cast_nullable_to_non_nullable
              as int,
      shieldBonus: null == shieldBonus
          ? _value.shieldBonus
          : shieldBonus // ignore: cast_nullable_to_non_nullable
              as int,
      armorBonus: null == armorBonus
          ? _value.armorBonus
          : armorBonus // ignore: cast_nullable_to_non_nullable
              as int,
      hullBonus: null == hullBonus
          ? _value.hullBonus
          : hullBonus // ignore: cast_nullable_to_non_nullable
              as int,
      crewBonus: null == crewBonus
          ? _value.crewBonus
          : crewBonus // ignore: cast_nullable_to_non_nullable
              as int,
      range: freezed == range
          ? _value.range
          : range // ignore: cast_nullable_to_non_nullable
              as int?,
      speed: freezed == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as int?,
      gyro: null == gyro
          ? _value.gyro
          : gyro // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DiceCopyWith<$Res> get damage {
    return $DiceCopyWith<$Res>(_value.damage, (value) {
      return _then(_value.copyWith(damage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_WeaponCopyWith<$Res> implements $WeaponCopyWith<$Res> {
  factory _$$_WeaponCopyWith(_$_Weapon value, $Res Function(_$_Weapon) then) =
      __$$_WeaponCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      WeaponSlotType type,
      Dice damage,
      int ru,
      int heat,
      int oht,
      int shieldBonus,
      int armorBonus,
      int hullBonus,
      int crewBonus,
      int? range,
      int? speed,
      int gyro});

  @override
  $DiceCopyWith<$Res> get damage;
}

/// @nodoc
class __$$_WeaponCopyWithImpl<$Res>
    extends _$WeaponCopyWithImpl<$Res, _$_Weapon>
    implements _$$_WeaponCopyWith<$Res> {
  __$$_WeaponCopyWithImpl(_$_Weapon _value, $Res Function(_$_Weapon) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? damage = null,
    Object? ru = null,
    Object? heat = null,
    Object? oht = null,
    Object? shieldBonus = null,
    Object? armorBonus = null,
    Object? hullBonus = null,
    Object? crewBonus = null,
    Object? range = freezed,
    Object? speed = freezed,
    Object? gyro = null,
  }) {
    return _then(_$_Weapon(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as WeaponSlotType,
      damage: null == damage
          ? _value.damage
          : damage // ignore: cast_nullable_to_non_nullable
              as Dice,
      ru: null == ru
          ? _value.ru
          : ru // ignore: cast_nullable_to_non_nullable
              as int,
      heat: null == heat
          ? _value.heat
          : heat // ignore: cast_nullable_to_non_nullable
              as int,
      oht: null == oht
          ? _value.oht
          : oht // ignore: cast_nullable_to_non_nullable
              as int,
      shieldBonus: null == shieldBonus
          ? _value.shieldBonus
          : shieldBonus // ignore: cast_nullable_to_non_nullable
              as int,
      armorBonus: null == armorBonus
          ? _value.armorBonus
          : armorBonus // ignore: cast_nullable_to_non_nullable
              as int,
      hullBonus: null == hullBonus
          ? _value.hullBonus
          : hullBonus // ignore: cast_nullable_to_non_nullable
              as int,
      crewBonus: null == crewBonus
          ? _value.crewBonus
          : crewBonus // ignore: cast_nullable_to_non_nullable
              as int,
      range: freezed == range
          ? _value.range
          : range // ignore: cast_nullable_to_non_nullable
              as int?,
      speed: freezed == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as int?,
      gyro: null == gyro
          ? _value.gyro
          : gyro // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_Weapon extends _Weapon {
  const _$_Weapon(
      {required this.name,
      required this.type,
      required this.damage,
      required this.ru,
      required this.heat,
      required this.oht,
      required this.shieldBonus,
      required this.armorBonus,
      required this.hullBonus,
      required this.crewBonus,
      this.range,
      this.speed,
      this.gyro = 0})
      : super._();

  @override
  final String name;
  @override
  final WeaponSlotType type;
  @override
  final Dice damage;
  @override
  final int ru;
  @override
  final int heat;
  @override
  final int oht;
  @override
  final int shieldBonus;
  @override
  final int armorBonus;
  @override
  final int hullBonus;
  @override
  final int crewBonus;
  @override
  final int? range;
  @override
  final int? speed;
  @override
  @JsonKey()
  final int gyro;

  @override
  String toString() {
    return 'Weapon(name: $name, type: $type, damage: $damage, ru: $ru, heat: $heat, oht: $oht, shieldBonus: $shieldBonus, armorBonus: $armorBonus, hullBonus: $hullBonus, crewBonus: $crewBonus, range: $range, speed: $speed, gyro: $gyro)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WeaponCopyWith<_$_Weapon> get copyWith =>
      __$$_WeaponCopyWithImpl<_$_Weapon>(this, _$identity);
}

abstract class _Weapon extends Weapon {
  const factory _Weapon(
      {required final String name,
      required final WeaponSlotType type,
      required final Dice damage,
      required final int ru,
      required final int heat,
      required final int oht,
      required final int shieldBonus,
      required final int armorBonus,
      required final int hullBonus,
      required final int crewBonus,
      final int? range,
      final int? speed,
      final int gyro}) = _$_Weapon;
  const _Weapon._() : super._();

  @override
  String get name;
  @override
  WeaponSlotType get type;
  @override
  Dice get damage;
  @override
  int get ru;
  @override
  int get heat;
  @override
  int get oht;
  @override
  int get shieldBonus;
  @override
  int get armorBonus;
  @override
  int get hullBonus;
  @override
  int get crewBonus;
  @override
  int? get range;
  @override
  int? get speed;
  @override
  int get gyro;
  @override
  @JsonKey(ignore: true)
  _$$_WeaponCopyWith<_$_Weapon> get copyWith =>
      throw _privateConstructorUsedError;
}
