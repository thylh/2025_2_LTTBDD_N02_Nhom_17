import 'package:flutter/material.dart';

class TimerCircle extends StatelessWidget {
  final String time;

  const TimerCircle({super.key, required this.time});

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
      child: Text(
        time,
        style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      ),
    );
  }
}
