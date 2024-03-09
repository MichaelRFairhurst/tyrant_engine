import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tyrant_engine/src/model/player.dart';
import 'package:tyrant_engine/src/model/projectile.dart';

part 'game.freezed.dart';

@freezed
class Game with _$Game {
  const Game._();

  const factory Game({
    required Player player,
    required Player enemy,
    required List<Projectile> projectiles,
  }) = _Game;

  Player playerType(PlayerType type) =>
      type == PlayerType.player ? player : enemy;

  Game updatePlayer(PlayerType type, Player Function(Player) update) =>
      copyWith(
        player: type == PlayerType.player ? update(player) : player,
        enemy: type == PlayerType.enemy ? update(enemy) : enemy,
      );
}
