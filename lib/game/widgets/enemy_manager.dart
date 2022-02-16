import 'dart:math';

import 'package:first_game/game/game.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class EnemyManager extends Component with HasGameRef<World> {
  EnemyManager() : super() {
    _timer = Timer(5, onTick: _spawnEnemy, repeat: true);
  }

  final Random _random = Random();
  late Timer _timer;

  Future<void> _spawnEnemy() async {
    if (gameRef.running) {
      final initialSize = Vector2.all(50);
      final position = Vector2(_random.nextDouble() * gameRef.size.x, 674)
        ..clamp(
          Vector2.zero() + initialSize / 2,
          gameRef.size - initialSize / 2,
        );
      final enemy = EnemyComponent(
        sheet: SpriteSheet(
          image: await gameRef.images.load('goomba.png'),
          srcSize: Vector2(88, 92),
        ),
        initialSize: initialSize,
        initialPosition: position,
      );
      await add(enemy);
    }
  }

  @override
  void onMount() {
    super.onMount();
    _timer.start();
  }

  @override
  void onRemove() {
    super.onRemove();
    _timer.stop();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timer.update(dt);
  }
}
