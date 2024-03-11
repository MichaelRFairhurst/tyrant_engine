// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'outcomes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Outcome<T> {
  Set<RandomOutcome<T>> get randomOutcomes =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OutcomeCopyWith<T, Outcome<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutcomeCopyWith<T, $Res> {
  factory $OutcomeCopyWith(Outcome<T> value, $Res Function(Outcome<T>) then) =
      _$OutcomeCopyWithImpl<T, $Res, Outcome<T>>;
  @useResult
  $Res call({Set<RandomOutcome<T>> randomOutcomes});
}

/// @nodoc
class _$OutcomeCopyWithImpl<T, $Res, $Val extends Outcome<T>>
    implements $OutcomeCopyWith<T, $Res> {
  _$OutcomeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? randomOutcomes = null,
  }) {
    return _then(_value.copyWith(
      randomOutcomes: null == randomOutcomes
          ? _value.randomOutcomes
          : randomOutcomes // ignore: cast_nullable_to_non_nullable
              as Set<RandomOutcome<T>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OutcomeCopyWith<T, $Res>
    implements $OutcomeCopyWith<T, $Res> {
  factory _$$_OutcomeCopyWith(
          _$_Outcome<T> value, $Res Function(_$_Outcome<T>) then) =
      __$$_OutcomeCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({Set<RandomOutcome<T>> randomOutcomes});
}

/// @nodoc
class __$$_OutcomeCopyWithImpl<T, $Res>
    extends _$OutcomeCopyWithImpl<T, $Res, _$_Outcome<T>>
    implements _$$_OutcomeCopyWith<T, $Res> {
  __$$_OutcomeCopyWithImpl(
      _$_Outcome<T> _value, $Res Function(_$_Outcome<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? randomOutcomes = null,
  }) {
    return _then(_$_Outcome<T>(
      randomOutcomes: null == randomOutcomes
          ? _value._randomOutcomes
          : randomOutcomes // ignore: cast_nullable_to_non_nullable
              as Set<RandomOutcome<T>>,
    ));
  }
}

/// @nodoc

class _$_Outcome<T> implements _Outcome<T> {
  const _$_Outcome({required final Set<RandomOutcome<T>> randomOutcomes})
      : _randomOutcomes = randomOutcomes;

  final Set<RandomOutcome<T>> _randomOutcomes;
  @override
  Set<RandomOutcome<T>> get randomOutcomes {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_randomOutcomes);
  }

  @override
  String toString() {
    return 'Outcome<$T>(randomOutcomes: $randomOutcomes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Outcome<T> &&
            const DeepCollectionEquality()
                .equals(other._randomOutcomes, _randomOutcomes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_randomOutcomes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OutcomeCopyWith<T, _$_Outcome<T>> get copyWith =>
      __$$_OutcomeCopyWithImpl<T, _$_Outcome<T>>(this, _$identity);
}

abstract class _Outcome<T> implements Outcome<T> {
  const factory _Outcome(
      {required final Set<RandomOutcome<T>> randomOutcomes}) = _$_Outcome<T>;

  @override
  Set<RandomOutcome<T>> get randomOutcomes;
  @override
  @JsonKey(ignore: true)
  _$$_OutcomeCopyWith<T, _$_Outcome<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RandomOutcome<T> {
  String get explanation => throw _privateConstructorUsedError;
  double get probability => throw _privateConstructorUsedError;
  T get result => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RandomOutcomeCopyWith<T, RandomOutcome<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RandomOutcomeCopyWith<T, $Res> {
  factory $RandomOutcomeCopyWith(
          RandomOutcome<T> value, $Res Function(RandomOutcome<T>) then) =
      _$RandomOutcomeCopyWithImpl<T, $Res, RandomOutcome<T>>;
  @useResult
  $Res call({String explanation, double probability, T result});
}

/// @nodoc
class _$RandomOutcomeCopyWithImpl<T, $Res, $Val extends RandomOutcome<T>>
    implements $RandomOutcomeCopyWith<T, $Res> {
  _$RandomOutcomeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? explanation = null,
    Object? probability = null,
    Object? result = null,
  }) {
    return _then(_value.copyWith(
      explanation: null == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
      probability: null == probability
          ? _value.probability
          : probability // ignore: cast_nullable_to_non_nullable
              as double,
      result: null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as T,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RandomOutcomeCopyWith<T, $Res>
    implements $RandomOutcomeCopyWith<T, $Res> {
  factory _$$_RandomOutcomeCopyWith(
          _$_RandomOutcome<T> value, $Res Function(_$_RandomOutcome<T>) then) =
      __$$_RandomOutcomeCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({String explanation, double probability, T result});
}

/// @nodoc
class __$$_RandomOutcomeCopyWithImpl<T, $Res>
    extends _$RandomOutcomeCopyWithImpl<T, $Res, _$_RandomOutcome<T>>
    implements _$$_RandomOutcomeCopyWith<T, $Res> {
  __$$_RandomOutcomeCopyWithImpl(
      _$_RandomOutcome<T> _value, $Res Function(_$_RandomOutcome<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? explanation = null,
    Object? probability = null,
    Object? result = null,
  }) {
    return _then(_$_RandomOutcome<T>(
      explanation: null == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
      probability: null == probability
          ? _value.probability
          : probability // ignore: cast_nullable_to_non_nullable
              as double,
      result: null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$_RandomOutcome<T> implements _RandomOutcome<T> {
  const _$_RandomOutcome(
      {required this.explanation,
      required this.probability,
      required this.result});

  @override
  final String explanation;
  @override
  final double probability;
  @override
  final T result;

  @override
  String toString() {
    return 'RandomOutcome<$T>(explanation: $explanation, probability: $probability, result: $result)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RandomOutcome<T> &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation) &&
            (identical(other.probability, probability) ||
                other.probability == probability) &&
            const DeepCollectionEquality().equals(other.result, result));
  }

  @override
  int get hashCode => Object.hash(runtimeType, explanation, probability,
      const DeepCollectionEquality().hash(result));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RandomOutcomeCopyWith<T, _$_RandomOutcome<T>> get copyWith =>
      __$$_RandomOutcomeCopyWithImpl<T, _$_RandomOutcome<T>>(this, _$identity);
}

abstract class _RandomOutcome<T> implements RandomOutcome<T> {
  const factory _RandomOutcome(
      {required final String explanation,
      required final double probability,
      required final T result}) = _$_RandomOutcome<T>;

  @override
  String get explanation;
  @override
  double get probability;
  @override
  T get result;
  @override
  @JsonKey(ignore: true)
  _$$_RandomOutcomeCopyWith<T, _$_RandomOutcome<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
