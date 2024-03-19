// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'mcts_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MctsRequest _$MctsRequestFromJson(Map<String, dynamic> json) {
  return _MctsRequest.fromJson(json);
}

/// @nodoc
mixin _$MctsRequest {
  Game get game => throw _privateConstructorUsedError;
  int get actionIdx => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MctsRequestCopyWith<MctsRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MctsRequestCopyWith<$Res> {
  factory $MctsRequestCopyWith(
          MctsRequest value, $Res Function(MctsRequest) then) =
      _$MctsRequestCopyWithImpl<$Res, MctsRequest>;
  @useResult
  $Res call({Game game, int actionIdx});

  $GameCopyWith<$Res> get game;
}

/// @nodoc
class _$MctsRequestCopyWithImpl<$Res, $Val extends MctsRequest>
    implements $MctsRequestCopyWith<$Res> {
  _$MctsRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? game = null,
    Object? actionIdx = null,
  }) {
    return _then(_value.copyWith(
      game: null == game
          ? _value.game
          : game // ignore: cast_nullable_to_non_nullable
              as Game,
      actionIdx: null == actionIdx
          ? _value.actionIdx
          : actionIdx // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GameCopyWith<$Res> get game {
    return $GameCopyWith<$Res>(_value.game, (value) {
      return _then(_value.copyWith(game: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_MctsRequestCopyWith<$Res>
    implements $MctsRequestCopyWith<$Res> {
  factory _$$_MctsRequestCopyWith(
          _$_MctsRequest value, $Res Function(_$_MctsRequest) then) =
      __$$_MctsRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Game game, int actionIdx});

  @override
  $GameCopyWith<$Res> get game;
}

/// @nodoc
class __$$_MctsRequestCopyWithImpl<$Res>
    extends _$MctsRequestCopyWithImpl<$Res, _$_MctsRequest>
    implements _$$_MctsRequestCopyWith<$Res> {
  __$$_MctsRequestCopyWithImpl(
      _$_MctsRequest _value, $Res Function(_$_MctsRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? game = null,
    Object? actionIdx = null,
  }) {
    return _then(_$_MctsRequest(
      game: null == game
          ? _value.game
          : game // ignore: cast_nullable_to_non_nullable
              as Game,
      actionIdx: null == actionIdx
          ? _value.actionIdx
          : actionIdx // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MctsRequest implements _MctsRequest {
  const _$_MctsRequest({required this.game, required this.actionIdx});

  factory _$_MctsRequest.fromJson(Map<String, dynamic> json) =>
      _$$_MctsRequestFromJson(json);

  @override
  final Game game;
  @override
  final int actionIdx;

  @override
  String toString() {
    return 'MctsRequest(game: $game, actionIdx: $actionIdx)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MctsRequest &&
            (identical(other.game, game) || other.game == game) &&
            (identical(other.actionIdx, actionIdx) ||
                other.actionIdx == actionIdx));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, game, actionIdx);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MctsRequestCopyWith<_$_MctsRequest> get copyWith =>
      __$$_MctsRequestCopyWithImpl<_$_MctsRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MctsRequestToJson(
      this,
    );
  }
}

abstract class _MctsRequest implements MctsRequest {
  const factory _MctsRequest(
      {required final Game game,
      required final int actionIdx}) = _$_MctsRequest;

  factory _MctsRequest.fromJson(Map<String, dynamic> json) =
      _$_MctsRequest.fromJson;

  @override
  Game get game;
  @override
  int get actionIdx;
  @override
  @JsonKey(ignore: true)
  _$$_MctsRequestCopyWith<_$_MctsRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
