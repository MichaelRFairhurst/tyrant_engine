import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tyrant_engine/src/algorithm/deck_cache.dart';
import 'package:tyrant_engine/src/model/weapon.dart';
import 'package:tyrant_engine/src/model/ship.dart';

part 'player.freezed.dart';

enum PlayerType {
  firstPlayer,
  secondPlayer,
}

enum CrewState { cryo, active, killed }

const startingCrew = [
  CrewState.active,
  CrewState.cryo,
  CrewState.cryo,
  CrewState.cryo,
  CrewState.cryo,
  CrewState.cryo,
  CrewState.cryo,
  CrewState.cryo,
  CrewState.cryo,
  CrewState.cryo,
];

@freezed
class Player with _$Player {
  const Player._();

  const factory Player({
    @Default(10) int ru,
    @Default(0) int heat,
    @Default(startingCrew) List<CrewState> crew,
    required Ship ship,
    required Deck hand,
    required Deck deck,
  }) = _Player;

  int get activeCrew => crew.where((c) => c == CrewState.active).length;

  Player dealCard(Weapon weapon) => copyWith(
        hand: hand.add(weapon),
        deck: deck.remove(weapon),
      );

  Player playFromHand(Weapon weapon) => copyWith(
        hand: hand.remove(weapon),
      );
}
