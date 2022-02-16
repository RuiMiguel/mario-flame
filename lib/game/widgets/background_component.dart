import 'package:first_game/game/game.dart';
import 'package:flame/components.dart';

class BackgroundComponent extends SpriteComponent with HasGameRef<World> {
  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite('background.png');
    width = 1400;
    height = 840;
    return super.onLoad();
  }
}
