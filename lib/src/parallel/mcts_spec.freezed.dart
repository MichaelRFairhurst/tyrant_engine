// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'mcts_spec.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MctsSpec _$MctsSpecFromJson(Map<String, dynamic> json) {
  return _MctsSpec.fromJson(json);
}

/// @nodoc
mixin _$MctsSpec {
  int get sampleCount => throw _privateConstructorUsedError;
  int get threads => throw _privateConstructorUsedError;
  int get maxDepth => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MctsSpecCopyWith<MctsSpec> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MctsSpecCopyWith<$Res> {
  factory $MctsSpecCopyWith(MctsSpec value, $Res Function(MctsSpec) then) =
      _$MctsSpecCopyWithImpl<$Res, MctsSpec>;
  @useResult
  $Res call({int sampleCount, int threads, int maxDepth});
}

/// @nodoc
class _$MctsSpecCopyWithImpl<$Res, $Val extends MctsSpec>
    implements $MctsSpecCopyWith<$Res> {
  _$MctsSpecCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sampleCount = null,
    Object? threads = null,
    Object? maxDepth = null,
  }) {
    return _then(_value.copyWith(
      sampleCount: null == sampleCount
          ? _value.sampleCount
          : sampleCount // ignore: cast_nullable_to_non_nullable
              as int,
      threads: null == threads
          ? _value.threads
          : threads // ignore: cast_nullable_to_non_nullable
              as int,
      maxDepth: null == maxDepth
          ? _value.maxDepth
          : maxDepth // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MctsSpecCopyWith<$Res> implements $MctsSpecCopyWith<$Res> {
  factory _$$_MctsSpecCopyWith(
          _$_MctsSpec value, $Res Function(_$_MctsSpec) then) =
      __$$_MctsSpecCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int sampleCount, int threads, int maxDepth});
}

/// @nodoc
class __$$_MctsSpecCopyWithImpl<$Res>
    extends _$MctsSpecCopyWithImpl<$Res, _$_MctsSpec>
    implements _$$_MctsSpecCopyWith<$Res> {
  __$$_MctsSpecCopyWithImpl(
      _$_MctsSpec _value, $Res Function(_$_MctsSpec) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sampleCount = null,
    Object? threads = null,
    Object? maxDepth = null,
  }) {
    return _then(_$_MctsSpec(
      sampleCount: null == sampleCount
          ? _value.sampleCount
          : sampleCount // ignore: cast_nullable_to_non_nullable
              as int,
      threads: null == threads
          ? _value.threads
          : threads // ignore: cast_nullable_to_non_nullable
              as int,
      maxDepth: null == maxDepth
          ? _value.maxDepth
          : maxDepth // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MctsSpec implements _MctsSpec {
  const _$_MctsSpec(
      {required this.sampleCount, required this.threads, this.maxDepth = 15});

  factory _$_MctsSpec.fromJson(Map<String, dynamic> json) =>
      _$$_MctsSpecFromJson(json);

  @override
  final int sampleCount;
  @override
  final int threads;
  @override
  @JsonKey()
  final int maxDepth;

  @override
  String toString() {
    return 'MctsSpec(sampleCount: $sampleCount, threads: $threads, maxDepth: $maxDepth)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MctsSpec &&
            (identical(other.sampleCount, sampleCount) ||
                other.sampleCount == sampleCount) &&
            (identical(other.threads, threads) || other.threads == threads) &&
            (identical(other.maxDepth, maxDepth) ||
                other.maxDepth == maxDepth));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, sampleCount, threads, maxDepth);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MctsSpecCopyWith<_$_MctsSpec> get copyWith =>
      __$$_MctsSpecCopyWithImpl<_$_MctsSpec>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MctsSpecToJson(
      this,
    );
  }
}

abstract class _MctsSpec implements MctsSpec {
  const factory _MctsSpec(
      {required final int sampleCount,
      required final int threads,
      final int maxDepth}) = _$_MctsSpec;

  factory _MctsSpec.fromJson(Map<String, dynamic> json) = _$_MctsSpec.fromJson;

  @override
  int get sampleCount;
  @override
  int get threads;
  @override
  int get maxDepth;
  @override
  @JsonKey(ignore: true)
  _$$_MctsSpecCopyWith<_$_MctsSpec> get copyWith =>
      throw _privateConstructorUsedError;
}
