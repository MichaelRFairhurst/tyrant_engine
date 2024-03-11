// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'game.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Game {
  int get round => throw _privateConstructorUsedError;
  Phase get phase => throw _privateConstructorUsedError;
  PlayerType get turn => throw _privateConstructorUsedError;
  Player get firstPlayer => throw _privateConstructorUsedError;
  Player get secondPlayer => throw _privateConstructorUsedError;
  List<Projectile> get projectiles => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameCopyWith<Game> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameCopyWith<$Res> {
  factory $GameCopyWith(Game value, $Res Function(Game) then) =
      _$GameCopyWithImpl<$Res, Game>;
  @useResult
  $Res call(
      {int round,
      Phase phase,
      PlayerType turn,
      Player firstPlayer,
      Player secondPlayer,
      List<Projectile> projectiles});

  $PlayerCopyWith<$Res> get firstPlayer;
  $PlayerCopyWith<$Res> get secondPlayer;
}

/// @nodoc
class _$GameCopyWithImpl<$Res, $Val extends Game>
    implements $GameCopyWith<$Res> {
  _$GameCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? round = null,
    Object? phase = null,
    Object? turn = null,
    Object? firstPlayer = null,
    Object? secondPlayer = null,
    Object? projectiles = null,
  }) {
    return _then(_value.copyWith(
      round: null == round
          ? _value.round
          : round // ignore: cast_nullable_to_non_nullable
              as int,
      phase: null == phase
          ? _value.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as Phase,
      turn: null == turn
          ? _value.turn
          : turn // ignore: cast_nullable_to_non_nullable
              as PlayerType,
      firstPlayer: null == firstPlayer
          ? _value.firstPlayer
          : firstPlayer // ignore: cast_nullable_to_non_nullable
              as Player,
      secondPlayer: null == secondPlayer
          ? _value.secondPlayer
          : secondPlayer // ignore: cast_nullable_to_non_nullable
              as Player,
      projectiles: null == projectiles
          ? _value.projectiles
          : projectiles // ignore: cast_nullable_to_non_nullable
              as List<Projectile>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PlayerCopyWith<$Res> get firstPlayer {
    return $PlayerCopyWith<$Res>(_value.firstPlayer, (value) {
      return _then(_value.copyWith(firstPlayer: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PlayerCopyWith<$Res> get secondPlayer {
    return $PlayerCopyWith<$Res>(_value.secondPlayer, (value) {
      return _then(_value.copyWith(secondPlayer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_GameCopyWith<$Res> implements $GameCopyWith<$Res> {
  factory _$$_GameCopyWith(_$_Game value, $Res Function(_$_Game) then) =
      __$$_GameCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int round,
      Phase phase,
      PlayerType turn,
      Player firstPlayer,
      Player secondPlayer,
      List<Projectile> projectiles});

  @override
  $PlayerCopyWith<$Res> get firstPlayer;
  @override
  $PlayerCopyWith<$Res> get secondPlayer;
}

/// @nodoc
class __$$_GameCopyWithImpl<$Res> extends _$GameCopyWithImpl<$Res, _$_Game>
    implements _$$_GameCopyWith<$Res> {
  __$$_GameCopyWithImpl(_$_Game _value, $Res Function(_$_Game) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? round = null,
    Object? phase = null,
    Object? turn = null,
    Object? firstPlayer = null,
    Object? secondPlayer = null,
    Object? projectiles = null,
  }) {
    return _then(_$_Game(
      round: null == round
          ? _value.round
          : round // ignore: cast_nullable_to_non_nullable
              as int,
      phase: null == phase
          ? _value.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as Phase,
      turn: null == turn
          ? _value.turn
          : turn // ignore: cast_nullable_to_non_nullable
              as PlayerType,
      firstPlayer: null == firstPlayer
          ? _value.firstPlayer
          : firstPlayer // ignore: cast_nullable_to_non_nullable
              as Player,
      secondPlayer: null == secondPlayer
          ? _value.secondPlayer
          : secondPlayer // ignore: cast_nullable_to_non_nullable
              as Player,
      projectiles: null == projectiles
          ? _value._projectiles
          : projectiles // ignore: cast_nullable_to_non_nullable
              as List<Projectile>,
    ));
  }
}

/// @nodoc

class _$_Game extends _Game {
  const _$_Game(
      {required this.round,
      required this.phase,
      required this.turn,
      required this.firstPlayer,
      required this.secondPlayer,
      required final List<Projectile> projectiles})
      : _projectiles = projectiles,
        super._();

  @override
  final int round;
  @override
  final Phase phase;
  @override
  final PlayerType turn;
  @override
  final Player firstPlayer;
  @override
  final Player secondPlayer;
  final List<Projectile> _projectiles;
  @override
  List<Projectile> get projectiles {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_projectiles);
  }

  @override
  String toString() {
    return 'Game(round: $round, phase: $phase, turn: $turn, firstPlayer: $firstPlayer, secondPlayer: $secondPlayer, projectiles: $projectiles)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Game &&
            (identical(other.round, round) || other.round == round) &&
            const DeepCollectionEquality().equals(other.phase, phase) &&
            (identical(other.turn, turn) || other.turn == turn) &&
            (identical(other.firstPlayer, firstPlayer) ||
                other.firstPlayer == firstPlayer) &&
            (identical(other.secondPlayer, secondPlayer) ||
                other.secondPlayer == secondPlayer) &&
            const DeepCollectionEquality()
                .equals(other._projectiles, _projectiles));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      round,
      const DeepCollectionEquality().hash(phase),
      turn,
      firstPlayer,
      secondPlayer,
      const DeepCollectionEquality().hash(_projectiles));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GameCopyWith<_$_Game> get copyWith =>
      __$$_GameCopyWithImpl<_$_Game>(this, _$identity);
}

abstract class _Game extends Game {
  const factory _Game(
      {required final int round,
      required final Phase phase,
      required final PlayerType turn,
      required final Player firstPlayer,
      required final Player secondPlayer,
      required final List<Projectile> projectiles}) = _$_Game;
  const _Game._() : super._();

  @override
  int get round;
  @override
  Phase get phase;
  @override
  PlayerType get turn;
  @override
  Player get firstPlayer;
  @override
  Player get secondPlayer;
  @override
  List<Projectile> get projectiles;
  @override
  @JsonKey(ignore: true)
  _$$_GameCopyWith<_$_Game> get copyWith => throw _privateConstructorUsedError;
}
