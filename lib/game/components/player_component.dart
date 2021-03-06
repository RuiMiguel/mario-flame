import 'package:first_game/game/game.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

enum Direction { none, up, right, down, left }
enum LookingAt { right, left }

class PlayerComponent extends SpriteAnimationComponent with HasGameRef<World> {
  PlayerComponent({required this.audioPlayerComponent});

  late Vector2 _initSize;
  late Vector2 _initPosition;
  late SpriteSheet _sheet;

  LookingAt _lookingAt = LookingAt.right;
  Direction direction = Direction.none;
  final AudioPlayerComponent audioPlayerComponent;

  final double _playerSpeed = 300;
  final double _animationSpeed = 0.15;
  late final SpriteAnimation _standingAnimation;
  late final SpriteAnimation _runUpAnimation;
  late final SpriteAnimation _runRightAnimation;
  late final SpriteAnimation _runDownAnimation;
  late final SpriteAnimation _runLeftAnimation;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    _sheet = SpriteSheet(
      image: gameRef.images.fromCache('mario.png'),
      srcSize: Vector2(29, 37),
    );

    await _loadAnimations().then((_) => animation = _standingAnimation);

    _initSize = Vector2(70, 80);
    _initPosition = Vector2(100, 640);

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
        _sheet.createAnimation(row: 2, stepTime: _animationSpeed, to: 1);
    _runUpAnimation = _sheet.createAnimation(
      row: 2,
      stepTime: _animationSpeed,
      from: 7,
      to: 8,
    );
    _runRightAnimation = _sheet.createAnimation(
      row: 2,
      stepTime: _animationSpeed,
      from: 2,
      to: 4,
    );
    _runDownAnimation = _sheet.createAnimation(
      row: 3,
      stepTime: _animationSpeed,
      from: 4,
      to: 5,
    );
    _runLeftAnimation = _sheet.createAnimation(
      row: 2,
      stepTime: _animationSpeed,
      from: 2,
      to: 4,
    );
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
            audioPlayerComponent.playSfx('jump.mp3');
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
  bool _canMoveUp() => position.y == 640;
  bool _canMoveRight() => position.x < (gameRef.size.x - size.x / 2);
  bool _canMoveDown() => position.y == 640;
  bool _canMoveLeft() => position.x > (0 - size.x / 2);

  void _stop() {
    position = Vector2(position.x, 640);
  }

  void _moveUp(double dt) {
    position.add(Vector2(0, -size.y / 2));
  }

  void _moveRight(double dt) {
    position.add(Vector2(dt * _playerSpeed, 0));
    if (_lookingAt == LookingAt.left) {
      _lookingAt = LookingAt.right;
      flipHorizontally();
    }
  }

  void _moveDown(double dt) {
    position.add(Vector2(0, 2));
  }

  void _moveLeft(double dt) {
    position.add(Vector2(-dt * _playerSpeed, 0));
    if (_lookingAt == LookingAt.right) {
      _lookingAt = LookingAt.left;
      flipHorizontally();
    }
  }
}
