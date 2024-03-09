// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'player.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Player {
  int get ru => throw _privateConstructorUsedError;
  int get heat => throw _privateConstructorUsedError;
  List<CrewState> get crew => throw _privateConstructorUsedError;
  Ship get ship => throw _privateConstructorUsedError;
  List<Weapon> get hand => throw _privateConstructorUsedError;
  List<Weapon> get deck => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlayerCopyWith<Player> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerCopyWith<$Res> {
  factory $PlayerCopyWith(Player value, $Res Function(Player) then) =
      _$PlayerCopyWithImpl<$Res, Player>;
  @useResult
  $Res call(
      {int ru,
      int heat,
      List<CrewState> crew,
      Ship ship,
      List<Weapon> hand,
      List<Weapon> deck});

  $ShipCopyWith<$Res> get ship;
}

/// @nodoc
class _$PlayerCopyWithImpl<$Res, $Val extends Player>
    implements $PlayerCopyWith<$Res> {
  _$PlayerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ru = null,
    Object? heat = null,
    Object? crew = null,
    Object? ship = null,
    Object? hand = null,
    Object? deck = null,
  }) {
    return _then(_value.copyWith(
      ru: null == ru
          ? _value.ru
          : ru // ignore: cast_nullable_to_non_nullable
              as int,
      heat: null == heat
          ? _value.heat
          : heat // ignore: cast_nullable_to_non_nullable
              as int,
      crew: null == crew
          ? _value.crew
          : crew // ignore: cast_nullable_to_non_nullable
              as List<CrewState>,
      ship: null == ship
          ? _value.ship
          : ship // ignore: cast_nullable_to_non_nullable
              as Ship,
      hand: null == hand
          ? _value.hand
          : hand // ignore: cast_nullable_to_non_nullable
              as List<Weapon>,
      deck: null == deck
          ? _value.deck
          : deck // ignore: cast_nullable_to_non_nullable
              as List<Weapon>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ShipCopyWith<$Res> get ship {
    return $ShipCopyWith<$Res>(_value.ship, (value) {
      return _then(_value.copyWith(ship: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_PlayerCopyWith<$Res> implements $PlayerCopyWith<$Res> {
  factory _$$_PlayerCopyWith(_$_Player value, $Res Function(_$_Player) then) =
      __$$_PlayerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int ru,
      int heat,
      List<CrewState> crew,
      Ship ship,
      List<Weapon> hand,
      List<Weapon> deck});

  @override
  $ShipCopyWith<$Res> get ship;
}

/// @nodoc
class __$$_PlayerCopyWithImpl<$Res>
    extends _$PlayerCopyWithImpl<$Res, _$_Player>
    implements _$$_PlayerCopyWith<$Res> {
  __$$_PlayerCopyWithImpl(_$_Player _value, $Res Function(_$_Player) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ru = null,
    Object? heat = null,
    Object? crew = null,
    Object? ship = null,
    Object? hand = null,
    Object? deck = null,
  }) {
    return _then(_$_Player(
      ru: null == ru
          ? _value.ru
          : ru // ignore: cast_nullable_to_non_nullable
              as int,
      heat: null == heat
          ? _value.heat
          : heat // ignore: cast_nullable_to_non_nullable
              as int,
      crew: null == crew
          ? _value._crew
          : crew // ignore: cast_nullable_to_non_nullable
              as List<CrewState>,
      ship: null == ship
          ? _value.ship
          : ship // ignore: cast_nullable_to_non_nullable
              as Ship,
      hand: null == hand
          ? _value._hand
          : hand // ignore: cast_nullable_to_non_nullable
              as List<Weapon>,
      deck: null == deck
          ? _value._deck
          : deck // ignore: cast_nullable_to_non_nullable
              as List<Weapon>,
    ));
  }
}

/// @nodoc

class _$_Player implements _Player {
  const _$_Player(
      {this.ru = 10,
      this.heat = 0,
      final List<CrewState> crew = startingCrew,
      required this.ship,
      required final List<Weapon> hand,
      required final List<Weapon> deck})
      : _crew = crew,
        _hand = hand,
        _deck = deck;

  @override
  @JsonKey()
  final int ru;
  @override
  @JsonKey()
  final int heat;
  final List<CrewState> _crew;
  @override
  @JsonKey()
  List<CrewState> get crew {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_crew);
  }

  @override
  final Ship ship;
  final List<Weapon> _hand;
  @override
  List<Weapon> get hand {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hand);
  }

  final List<Weapon> _deck;
  @override
  List<Weapon> get deck {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deck);
  }

  @override
  String toString() {
    return 'Player(ru: $ru, heat: $heat, crew: $crew, ship: $ship, hand: $hand, deck: $deck)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Player &&
            (identical(other.ru, ru) || other.ru == ru) &&
            (identical(other.heat, heat) || other.heat == heat) &&
            const DeepCollectionEquality().equals(other._crew, _crew) &&
            (identical(other.ship, ship) || other.ship == ship) &&
            const DeepCollectionEquality().equals(other._hand, _hand) &&
            const DeepCollectionEquality().equals(other._deck, _deck));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      ru,
      heat,
      const DeepCollectionEquality().hash(_crew),
      ship,
      const DeepCollectionEquality().hash(_hand),
      const DeepCollectionEquality().hash(_deck));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PlayerCopyWith<_$_Player> get copyWith =>
      __$$_PlayerCopyWithImpl<_$_Player>(this, _$identity);
}

abstract class _Player implements Player {
  const factory _Player(
      {final int ru,
      final int heat,
      final List<CrewState> crew,
      required final Ship ship,
      required final List<Weapon> hand,
      required final List<Weapon> deck}) = _$_Player;

  @override
  int get ru;
  @override
  int get heat;
  @override
  List<CrewState> get crew;
  @override
  Ship get ship;
  @override
  List<Weapon> get hand;
  @override
  List<Weapon> get deck;
  @override
  @JsonKey(ignore: true)
  _$$_PlayerCopyWith<_$_Player> get copyWith =>
      throw _privateConstructorUsedError;
}
