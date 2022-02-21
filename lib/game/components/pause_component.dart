import 'package:first_game/game/game.dart';
import 'package:flame/components.dart';

class PauseComponent extends SpriteComponent with HasGameRef<World> {
  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite('pause.png');
    width = 50;
    height = 50;
    return super.onLoad();
  }

/*
  @override
  bool onTapDown(TapDownInfo info) {
    if (gameRef.overlays.isActive('pause')) {
      gameRef.overlays.remove('pause');
    } else {
      gameRef.overlays.add('pause');
    }
    return super.onTapDown(info);
  }
  */
}
