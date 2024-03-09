// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'weapon_slot_descriptor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WeaponSlotDescriptor {
  Quadrant get quadrant => throw _privateConstructorUsedError;
  int get slotIdx => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WeaponSlotDescriptorCopyWith<WeaponSlotDescriptor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeaponSlotDescriptorCopyWith<$Res> {
  factory $WeaponSlotDescriptorCopyWith(WeaponSlotDescriptor value,
          $Res Function(WeaponSlotDescriptor) then) =
      _$WeaponSlotDescriptorCopyWithImpl<$Res, WeaponSlotDescriptor>;
  @useResult
  $Res call({Quadrant quadrant, int slotIdx});
}

/// @nodoc
class _$WeaponSlotDescriptorCopyWithImpl<$Res,
        $Val extends WeaponSlotDescriptor>
    implements $WeaponSlotDescriptorCopyWith<$Res> {
  _$WeaponSlotDescriptorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quadrant = null,
    Object? slotIdx = null,
  }) {
    return _then(_value.copyWith(
      quadrant: null == quadrant
          ? _value.quadrant
          : quadrant // ignore: cast_nullable_to_non_nullable
              as Quadrant,
      slotIdx: null == slotIdx
          ? _value.slotIdx
          : slotIdx // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WeaponSlotDescriptorCopyWith<$Res>
    implements $WeaponSlotDescriptorCopyWith<$Res> {
  factory _$$_WeaponSlotDescriptorCopyWith(_$_WeaponSlotDescriptor value,
          $Res Function(_$_WeaponSlotDescriptor) then) =
      __$$_WeaponSlotDescriptorCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Quadrant quadrant, int slotIdx});
}

/// @nodoc
class __$$_WeaponSlotDescriptorCopyWithImpl<$Res>
    extends _$WeaponSlotDescriptorCopyWithImpl<$Res, _$_WeaponSlotDescriptor>
    implements _$$_WeaponSlotDescriptorCopyWith<$Res> {
  __$$_WeaponSlotDescriptorCopyWithImpl(_$_WeaponSlotDescriptor _value,
      $Res Function(_$_WeaponSlotDescriptor) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quadrant = null,
    Object? slotIdx = null,
  }) {
    return _then(_$_WeaponSlotDescriptor(
      quadrant: null == quadrant
          ? _value.quadrant
          : quadrant // ignore: cast_nullable_to_non_nullable
              as Quadrant,
      slotIdx: null == slotIdx
          ? _value.slotIdx
          : slotIdx // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_WeaponSlotDescriptor implements _WeaponSlotDescriptor {
  const _$_WeaponSlotDescriptor(
      {required this.quadrant, required this.slotIdx});

  @override
  final Quadrant quadrant;
  @override
  final int slotIdx;

  @override
  String toString() {
    return 'WeaponSlotDescriptor(quadrant: $quadrant, slotIdx: $slotIdx)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WeaponSlotDescriptor &&
            const DeepCollectionEquality().equals(other.quadrant, quadrant) &&
            (identical(other.slotIdx, slotIdx) || other.slotIdx == slotIdx));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(quadrant), slotIdx);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WeaponSlotDescriptorCopyWith<_$_WeaponSlotDescriptor> get copyWith =>
      __$$_WeaponSlotDescriptorCopyWithImpl<_$_WeaponSlotDescriptor>(
          this, _$identity);
}

abstract class _WeaponSlotDescriptor implements WeaponSlotDescriptor {
  const factory _WeaponSlotDescriptor(
      {required final Quadrant quadrant,
      required final int slotIdx}) = _$_WeaponSlotDescriptor;

  @override
  Quadrant get quadrant;
  @override
  int get slotIdx;
  @override
  @JsonKey(ignore: true)
  _$$_WeaponSlotDescriptorCopyWith<_$_WeaponSlotDescriptor> get copyWith =>
      throw _privateConstructorUsedError;
}
