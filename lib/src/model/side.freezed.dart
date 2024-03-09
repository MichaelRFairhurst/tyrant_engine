// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'side.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Side {
  int? get armor => throw _privateConstructorUsedError;
  List<WeaponSlot> get weapons => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SideCopyWith<Side> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SideCopyWith<$Res> {
  factory $SideCopyWith(Side value, $Res Function(Side) then) =
      _$SideCopyWithImpl<$Res, Side>;
  @useResult
  $Res call({int? armor, List<WeaponSlot> weapons});
}

/// @nodoc
class _$SideCopyWithImpl<$Res, $Val extends Side>
    implements $SideCopyWith<$Res> {
  _$SideCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? armor = freezed,
    Object? weapons = null,
  }) {
    return _then(_value.copyWith(
      armor: freezed == armor
          ? _value.armor
          : armor // ignore: cast_nullable_to_non_nullable
              as int?,
      weapons: null == weapons
          ? _value.weapons
          : weapons // ignore: cast_nullable_to_non_nullable
              as List<WeaponSlot>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SideCopyWith<$Res> implements $SideCopyWith<$Res> {
  factory _$$_SideCopyWith(_$_Side value, $Res Function(_$_Side) then) =
      __$$_SideCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? armor, List<WeaponSlot> weapons});
}

/// @nodoc
class __$$_SideCopyWithImpl<$Res> extends _$SideCopyWithImpl<$Res, _$_Side>
    implements _$$_SideCopyWith<$Res> {
  __$$_SideCopyWithImpl(_$_Side _value, $Res Function(_$_Side) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? armor = freezed,
    Object? weapons = null,
  }) {
    return _then(_$_Side(
      armor: freezed == armor
          ? _value.armor
          : armor // ignore: cast_nullable_to_non_nullable
              as int?,
      weapons: null == weapons
          ? _value._weapons
          : weapons // ignore: cast_nullable_to_non_nullable
              as List<WeaponSlot>,
    ));
  }
}

/// @nodoc

class _$_Side extends _Side {
  const _$_Side({this.armor, required final List<WeaponSlot> weapons})
      : _weapons = weapons,
        super._();

  @override
  final int? armor;
  final List<WeaponSlot> _weapons;
  @override
  List<WeaponSlot> get weapons {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weapons);
  }

  @override
  String toString() {
    return 'Side(armor: $armor, weapons: $weapons)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Side &&
            (identical(other.armor, armor) || other.armor == armor) &&
            const DeepCollectionEquality().equals(other._weapons, _weapons));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, armor, const DeepCollectionEquality().hash(_weapons));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SideCopyWith<_$_Side> get copyWith =>
      __$$_SideCopyWithImpl<_$_Side>(this, _$identity);
}

abstract class _Side extends Side {
  const factory _Side(
      {final int? armor, required final List<WeaponSlot> weapons}) = _$_Side;
  const _Side._() : super._();

  @override
  int? get armor;
  @override
  List<WeaponSlot> get weapons;
  @override
  @JsonKey(ignore: true)
  _$$_SideCopyWith<_$_Side> get copyWith => throw _privateConstructorUsedError;
}
