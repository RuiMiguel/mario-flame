import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  const Score({Key? key, required this.points}) : super(key: key);

  final int points;

  @override
  Widget build(BuildContext context) {
    return Text(
      'SCORE $points',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 40,
        color: Colors.black,
      ),
    );
  }
}
