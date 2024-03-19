// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'mcts_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MctsResult _$MctsResultFromJson(Map<String, dynamic> json) {
  return _MctsResult.fromJson(json);
}

/// @nodoc
mixin _$MctsResult {
  int get victoryCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MctsResultCopyWith<MctsResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MctsResultCopyWith<$Res> {
  factory $MctsResultCopyWith(
          MctsResult value, $Res Function(MctsResult) then) =
      _$MctsResultCopyWithImpl<$Res, MctsResult>;
  @useResult
  $Res call({int victoryCount});
}

/// @nodoc
class _$MctsResultCopyWithImpl<$Res, $Val extends MctsResult>
    implements $MctsResultCopyWith<$Res> {
  _$MctsResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? victoryCount = null,
  }) {
    return _then(_value.copyWith(
      victoryCount: null == victoryCount
          ? _value.victoryCount
          : victoryCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MctsResultCopyWith<$Res>
    implements $MctsResultCopyWith<$Res> {
  factory _$$_MctsResultCopyWith(
          _$_MctsResult value, $Res Function(_$_MctsResult) then) =
      __$$_MctsResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int victoryCount});
}

/// @nodoc
class __$$_MctsResultCopyWithImpl<$Res>
    extends _$MctsResultCopyWithImpl<$Res, _$_MctsResult>
    implements _$$_MctsResultCopyWith<$Res> {
  __$$_MctsResultCopyWithImpl(
      _$_MctsResult _value, $Res Function(_$_MctsResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? victoryCount = null,
  }) {
    return _then(_$_MctsResult(
      victoryCount: null == victoryCount
          ? _value.victoryCount
          : victoryCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MctsResult implements _MctsResult {
  const _$_MctsResult({required this.victoryCount});

  factory _$_MctsResult.fromJson(Map<String, dynamic> json) =>
      _$$_MctsResultFromJson(json);

  @override
  final int victoryCount;

  @override
  String toString() {
    return 'MctsResult(victoryCount: $victoryCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MctsResult &&
            (identical(other.victoryCount, victoryCount) ||
                other.victoryCount == victoryCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, victoryCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MctsResultCopyWith<_$_MctsResult> get copyWith =>
      __$$_MctsResultCopyWithImpl<_$_MctsResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MctsResultToJson(
      this,
    );
  }
}

abstract class _MctsResult implements MctsResult {
  const factory _MctsResult({required final int victoryCount}) = _$_MctsResult;

  factory _MctsResult.fromJson(Map<String, dynamic> json) =
      _$_MctsResult.fromJson;

  @override
  int get victoryCount;
  @override
  @JsonKey(ignore: true)
  _$$_MctsResultCopyWith<_$_MctsResult> get copyWith =>
      throw _privateConstructorUsedError;
}
