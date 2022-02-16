import 'package:flutter/material.dart';

class LifeBar extends StatelessWidget {
  const LifeBar({Key? key, required this.lives}) : super(key: key);

  final int lives;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 50),
      child: ListView.builder(
        itemCount: lives,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, _) => const LifeIcon(),
      ),
    );
  }
}

class LifeIcon extends StatelessWidget {
  const LifeIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/life.png',
      width: 30,
      height: 30,
    );
  }
}
