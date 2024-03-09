import 'package:tyrant_engine/src/model/game.dart';
import 'package:tyrant_engine/src/rules/rule_engine.dart';
import 'package:tyrant_engine/src/content/decks.dart' as decks;
import 'package:tyrant_engine/src/content/ships.dart' as ships;

class TyrantEngine {
  final ruleEngine = RuleEngine();

  void run(Game game) {}

  Game defaultGame() {
    return ruleEngine.initializeGame(
      playerDeck: decks.defaultDeck,
      playerBuild: ships.defaultBuild,
      enemyDeck: decks.defaultDeck,
      enemyBuild: ships.defaultBuild,
    );
  }
}
