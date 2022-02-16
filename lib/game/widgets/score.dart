import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  Score({Key? key, required this.points}) : super(key: key);

  int points;

  @override
  Widget build(BuildContext context) {
    return Text(
      'SCORE $points',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 40,
        color: Colors.black,
      ),
    );
  }
}
