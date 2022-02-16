import 'package:first_game/game/game.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class World extends FlameGame
    with HasCollidables, HasKeyboardHandlerComponents, HasDraggables
    implements KeyboardEvents {
  late BackgroundComponent _backgroundComponent;
  late AudioPlayerComponent _audioPlayerComponent;
  late PauseComponent _pauseComponent;
  late PlayerComponent _playerComponent;
  late EnemyComponent _enemyComponent;
  bool running = true;

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'background.png',
      'background2.jpg',
      'goomba.png',
      'mario.png',
      'pause.png',
    ]);

    _backgroundComponent = BackgroundComponent();
    await add(_backgroundComponent);

    _audioPlayerComponent = AudioPlayerComponent();
    await add(_audioPlayerComponent);

    _playerComponent =
        PlayerComponent(audioPlayerComponent: _audioPlayerComponent);
    await add(_playerComponent);

    _enemyComponent = EnemyComponent();
    await add(_enemyComponent);

    _pauseComponent = PauseComponent();
    await add(_pauseComponent);

    await super.onLoad();
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    super.onKeyEvent(event, keysPressed);

    if (event is RawKeyDownEvent) {
      if (running) {
        if (event.data.logicalKey == LogicalKeyboardKey.arrowUp) {
          _playerComponent.direction = Direction.up;
        }
        if (event.data.logicalKey == LogicalKeyboardKey.arrowDown) {
          _playerComponent.direction = Direction.down;
        }
        if (event.data.logicalKey == LogicalKeyboardKey.arrowLeft) {
          _playerComponent.direction = Direction.left;
          _enemyComponent.direction = Direction.left;
        }
        if (event.data.logicalKey == LogicalKeyboardKey.arrowRight) {
          _playerComponent.direction = Direction.right;
          _enemyComponent.direction = Direction.right;
        }
        if (event.data.logicalKey == LogicalKeyboardKey.space) {
          _playerComponent.direction = Direction.up;
        }
      }
      if (event.data.logicalKey == LogicalKeyboardKey.escape) {
        if (overlays.isActive('pause')) {
          running = true;
          _audioPlayerComponent.resumeBgm();
          overlays.remove('pause');
        } else {
          running = false;
          _audioPlayerComponent.pauseBgm();
          overlays.add('pause');
        }
      }
      return KeyEventResult.handled;
    } else if (event is RawKeyUpEvent) {
      _playerComponent.direction = Direction.none;
    }

    return KeyEventResult.ignored;
  }

  @override
  void onAttach() {
    _audioPlayerComponent.playBgm();
    super.onAttach();
  }

  @override
  void onDetach() {
    _audioPlayerComponent.stopBgm();
    super.onDetach();
  }
}
