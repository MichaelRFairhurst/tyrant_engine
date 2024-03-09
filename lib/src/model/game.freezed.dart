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
  Player get player => throw _privateConstructorUsedError;
  Player get enemy => throw _privateConstructorUsedError;
  List<Projectile> get projectiles => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameCopyWith<Game> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameCopyWith<$Res> {
  factory $GameCopyWith(Game value, $Res Function(Game) then) =
      _$GameCopyWithImpl<$Res, Game>;
  @useResult
  $Res call({Player player, Player enemy, List<Projectile> projectiles});
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
    Object? player = null,
    Object? enemy = null,
    Object? projectiles = null,
  }) {
    return _then(_value.copyWith(
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as Player,
      enemy: null == enemy
          ? _value.enemy
          : enemy // ignore: cast_nullable_to_non_nullable
              as Player,
      projectiles: null == projectiles
          ? _value.projectiles
          : projectiles // ignore: cast_nullable_to_non_nullable
              as List<Projectile>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GameCopyWith<$Res> implements $GameCopyWith<$Res> {
  factory _$$_GameCopyWith(_$_Game value, $Res Function(_$_Game) then) =
      __$$_GameCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Player player, Player enemy, List<Projectile> projectiles});
}

/// @nodoc
class __$$_GameCopyWithImpl<$Res> extends _$GameCopyWithImpl<$Res, _$_Game>
    implements _$$_GameCopyWith<$Res> {
  __$$_GameCopyWithImpl(_$_Game _value, $Res Function(_$_Game) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? player = null,
    Object? enemy = null,
    Object? projectiles = null,
  }) {
    return _then(_$_Game(
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as Player,
      enemy: null == enemy
          ? _value.enemy
          : enemy // ignore: cast_nullable_to_non_nullable
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
      {required this.player,
      required this.enemy,
      required final List<Projectile> projectiles})
      : _projectiles = projectiles,
        super._();

  @override
  final Player player;
  @override
  final Player enemy;
  final List<Projectile> _projectiles;
  @override
  List<Projectile> get projectiles {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_projectiles);
  }

  @override
  String toString() {
    return 'Game(player: $player, enemy: $enemy, projectiles: $projectiles)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Game &&
            const DeepCollectionEquality().equals(other.player, player) &&
            const DeepCollectionEquality().equals(other.enemy, enemy) &&
            const DeepCollectionEquality()
                .equals(other._projectiles, _projectiles));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(player),
      const DeepCollectionEquality().hash(enemy),
      const DeepCollectionEquality().hash(_projectiles));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GameCopyWith<_$_Game> get copyWith =>
      __$$_GameCopyWithImpl<_$_Game>(this, _$identity);
}

abstract class _Game extends Game {
  const factory _Game(
      {required final Player player,
      required final Player enemy,
      required final List<Projectile> projectiles}) = _$_Game;
  const _Game._() : super._();

  @override
  Player get player;
  @override
  Player get enemy;
  @override
  List<Projectile> get projectiles;
  @override
  @JsonKey(ignore: true)
  _$$_GameCopyWith<_$_Game> get copyWith => throw _privateConstructorUsedError;
}
