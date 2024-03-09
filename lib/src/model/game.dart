import 'package:freezed_annotation/freezed_annotation.dart';

part 'game.freezed.dart';

@freezed
class Game with _$Game {
  const Game._();

  const factory Game({
    required Player player,
    required Player enemy,
    required List<Projectile> projectiles,
  }) = _Game;

  Game updatePlayer(playerOld, playerNew) => copyWith(
        player: identical(player, playerOld) ? playerNew : player,
        enemy: identical(enemy, playerOld) ? playerNew : enemy,
      );
}
