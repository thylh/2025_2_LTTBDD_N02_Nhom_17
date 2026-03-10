import 'package:flutter/material.dart';

class PomodoroProgress extends StatelessWidget {
  final int pomodoroCount;

  const PomodoroProgress({super.key, required this.pomodoroCount});

  @override
  Widget build(BuildContext context) {
    int current = pomodoroCount % 4;

    const Color mainColor = Color(0xFFE53935);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(4, (index) {
            bool completed = index < current;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Icon(
                completed ? Icons.timer : Icons.timer_outlined,
                size: 22,
                color: completed ? mainColor : Colors.white,
              ),
            );
          }),
        ),
        const SizedBox(height: 6),
      ],
    );
  }
}
