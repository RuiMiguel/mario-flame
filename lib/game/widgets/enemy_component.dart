import 'package:first_game/game/game.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class EnemyComponent extends SpriteAnimationComponent with HasGameRef<World> {
  EnemyComponent({
    required this.sheet,
    required this.initialSize,
    required this.initialPosition,
  });

  Vector2 initialSize;
  Vector2 initialPosition;
  late SpriteSheet sheet;

  LookingAt _lookingAt = LookingAt.left;
  Direction direction = Direction.left;

  final double _enemySpeed = 80;
  final double _animationSpeed = 0.15;
  late final SpriteAnimation _standingAnimation;
  late final SpriteAnimation _moveRightAnimation;
  late final SpriteAnimation _moveLeftAnimation;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    await _loadAnimations().then((_) => animation = _standingAnimation);

    size = initialSize;
    position = initialPosition;
  }

  @override
  void update(double dt) {
    super.update(dt);
    _movePlayer(dt);
  }

  Future<void> _loadAnimations() async {
    _standingAnimation =
        sheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 1);
    _moveRightAnimation =
        sheet.createAnimation(row: 2, stepTime: _animationSpeed, to: 4);
    _moveLeftAnimation =
        sheet.createAnimation(row: 2, stepTime: _animationSpeed, to: 4);
  }

  void _movePlayer(double dt) {
    if (_isGameRunning()) {
      switch (direction) {
        case Direction.right:
          if (_canMoveRight()) {
            animation = _moveRightAnimation;
            _moveRight(dt);
          } else {
            direction = Direction.left;
          }
          break;
        case Direction.left:
          if (_canMoveLeft()) {
            animation = _moveLeftAnimation;
            _moveLeft(dt);
          } else {
            direction = Direction.right;
          }
          break;
        case Direction.none:
        case Direction.up:
        case Direction.down:
          break;
      }
    }
  }

  bool _isGameRunning() => gameRef.running;
  bool _canMoveRight() => position.x < (gameRef.size.x - size.x / 2);
  bool _canMoveLeft() => position.x > (0 - size.x / 2);

  void _moveRight(double dt) {
    position.add(Vector2(dt * _enemySpeed, 0));
    if (_lookingAt == LookingAt.left) {
      _lookingAt = LookingAt.right;
      flipHorizontally();
    }
  }

  void _moveLeft(double dt) {
    position.add(Vector2(-dt * _enemySpeed, 0));
    if (_lookingAt == LookingAt.right) {
      _lookingAt = LookingAt.left;
      flipHorizontally();
    }
  }
}
