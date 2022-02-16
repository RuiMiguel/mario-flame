import 'package:first_game/game/game.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class EnemyComponent extends SpriteAnimationComponent with HasGameRef<World> {
  EnemyComponent();

  late Sprite _initSprite;
  late Vector2 _initSize;
  late Vector2 _initPosition;
  late SpriteSheet _sheet;

  Direction direction = Direction.none;

  final double _playerSpeed = 200;
  final double _animationSpeed = 0.15;
  late final SpriteAnimation _standingAnimation;
  late final SpriteAnimation _runUpAnimation;
  late final SpriteAnimation _runRightAnimation;
  late final SpriteAnimation _runDownAnimation;
  late final SpriteAnimation _runLeftAnimation;

  @override
  Future<void>? onLoad() async {
    super.onLoad();

    _sheet = SpriteSheet.fromColumnsAndRows(
      image: await gameRef.images.load('goomba.png'),
      columns: 31,
      rows: 12,
    );
    _loadAnimations().then((_) => animation = _standingAnimation);

    _initSize = Vector2.all(80);
    _initPosition = Vector2(1000, 30);

    size = _initSize;
    position = _initPosition;
  }

  @override
  void update(double dt) {
    super.update(dt);
    _movePlayer(dt);
  }

  Future<void> _loadAnimations() async {
    _standingAnimation =
        _sheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 1);
    _runUpAnimation =
        _sheet.createAnimation(row: 2, stepTime: _animationSpeed, to: 4);
    _runRightAnimation =
        _sheet.createAnimation(row: 2, stepTime: _animationSpeed, to: 4);
    _runDownAnimation =
        _sheet.createAnimation(row: 2, stepTime: _animationSpeed, to: 4);
    _runLeftAnimation =
        _sheet.createAnimation(row: 2, stepTime: _animationSpeed, to: 4);
  }

  void _movePlayer(double dt) {
    if (_isGameRunning()) {
      switch (direction) {
        case Direction.none:
          animation = _standingAnimation;
          _stop();
          break;
        case Direction.up:
          if (_canMoveUp()) {
            animation = _runUpAnimation;
            _moveUp(dt);
          }
          break;
        case Direction.right:
          if (_canMoveRight()) {
            animation = _runRightAnimation;
            _moveRight(dt);
          }
          break;
        case Direction.down:
          if (_canMoveDown()) {
            animation = _runDownAnimation;
            _moveDown(dt);
          }
          break;
        case Direction.left:
          if (_canMoveLeft()) {
            animation = _runLeftAnimation;
            _moveLeft(dt);
          }
          break;
      }
    }
  }

  bool _isGameRunning() => gameRef.running;
  bool _canMoveUp() => false;
  bool _canMoveRight() => position.x < (gameRef.size.x - size.x / 2);
  bool _canMoveDown() => false;
  bool _canMoveLeft() => position.x > (0 - size.x / 2);

  void _stop() {
    position = Vector2(position.x, 640);
  }

  void _moveUp(double dt) {
    position.add(Vector2(0, -size.y / 2));
  }

  void _moveRight(double dt) {
    position.add(Vector2(dt * _playerSpeed, 0));
  }

  void _moveDown(double dt) {
    position.add(Vector2(0, 10));
  }

  void _moveLeft(double dt) {
    position.add(Vector2(-dt * _playerSpeed, 0));
  }
}
