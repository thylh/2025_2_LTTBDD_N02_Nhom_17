import 'package:flutter/material.dart';

class ControlButtons extends StatelessWidget {
  final bool isRunning;
  final VoidCallback onStart;
  final VoidCallback onPause;
  final VoidCallback onReset;

  const ControlButtons({
    super.key,
    required this.isRunning,
    required this.onStart,
    required this.onPause,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: isRunning ? onPause : onStart,
          child: Text(isRunning ? "Pause" : "Start"),
        ),
        const SizedBox(width: 20),
        ElevatedButton(onPressed: onReset, child: const Text("Reset")),
      ],
    );
  }
}
