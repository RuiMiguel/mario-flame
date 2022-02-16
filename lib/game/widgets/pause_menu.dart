import 'package:first_game/game/game.dart';
import 'package:flutter/material.dart';

class PauseMenu extends StatelessWidget {
  const PauseMenu({Key? key, required this.game}) : super(key: key);

  final World game;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.red,
                width: 2,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 4,
                )
              ],
            ),
            padding: const EdgeInsets.all(10),
            child: ListView(
              shrinkWrap: true,
              children: [
                const Center(
                  child: Text(
                    'Pause',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.red,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                ElevatedButton(
                  onPressed: () {
                    game.overlays.remove('pause');
                  },
                  child: const Text('Resume'),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                ElevatedButton(
                  onPressed: () {
                    game.overlays.remove('pause');
                    //game.restart();
                  },
                  child: const Text('Restart'),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                ElevatedButton(
                  onPressed: () {
                    game.overlays.remove('pause');
                  },
                  child: const Text('Exit'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
