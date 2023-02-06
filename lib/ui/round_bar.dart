import 'package:flutter/material.dart';

class RoundBar extends StatelessWidget {
  late String cupName;
  late String round;

  RoundBar(this.cupName, this.round);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
          height: 40,
          width: 400,
          child: Text(cupName + " " + round,textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.lightBlue)),
        ),
      );
  }
}
