import 'package:first_game/game/game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:fps_widget/fps_widget.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GameView();
  }
}

class GameView extends StatelessWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(
            game: World(),
            loadingBuilder: (context) =>
                const Center(child: CircularProgressIndicator()),
            errorBuilder: (context, exception) {
              debugPrint(exception.toString());
              return const Center(
                child: Text('Sorry, something went wrong. Reload me!'),
              );
            },
            overlayBuilderMap: {
              'pause': (context, World game) => PauseMenu(game: game),
            },
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                top: 10,
                left: 30,
              ),
              child: LifeBar(
                lives: 5,
              ),
            ),
          ),
          const Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                top: 10,
                right: 30,
              ),
              child: Score(
                points: 000000,
              ),
            ),
          ),
          const Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(
                top: 10,
                right: 30,
              ),
              child: FPSWidget(
                child: SizedBox(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
