import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tyrant_engine/src/model/player.dart';
import 'package:tyrant_engine/src/model/projectile.dart';
import 'package:tyrant_engine/src/rules/rule_engine.dart';

part 'game.freezed.dart';

@freezed
class Game with _$Game {
  const Game._();

  const factory Game({
    required int round,
    required Phase phase,
    required PlayerType turn,
    required Player firstPlayer,
    required Player secondPlayer,
    required List<Projectile> projectiles,
  }) = _Game;

  Player get currentPlayer => playerType(turn);

  Player get enemyPlayer =>
      turn == PlayerType.firstPlayer ? secondPlayer : firstPlayer;

  Player playerType(PlayerType type) =>
      type == PlayerType.firstPlayer ? firstPlayer : secondPlayer;

  Game updateCurrentPlayer(Player Function(Player) update) =>
      updatePlayer(turn, update);

  Game updatePlayer(PlayerType type, Player Function(Player) update) =>
      copyWith(
        firstPlayer:
            type == PlayerType.firstPlayer ? update(firstPlayer) : firstPlayer,
        secondPlayer: type == PlayerType.secondPlayer
            ? update(secondPlayer)
            : secondPlayer,
      );

  int get turnCount => round * 2 + (turn == PlayerType.secondPlayer ? 1 : 0);
}
