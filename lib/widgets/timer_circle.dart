import 'package:flutter/material.dart';

class TimerCircle extends StatelessWidget {
  const TimerCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 220,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.red, width: 8),
      ),
      alignment: Alignment.center,
      child: const Text(
        "25:00",
        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      ),
    );
  }
}
