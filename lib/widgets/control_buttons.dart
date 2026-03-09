import 'package:flutter/material.dart';

class ControlButtons extends StatelessWidget {
  final bool isRunning;
  final bool isBreak;
  final VoidCallback onStart;
  final VoidCallback onPause;
  final VoidCallback onReset;

  const ControlButtons({
    super.key,
    required this.isRunning,
    required this.isBreak,
    required this.onStart,
    required this.onPause,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    final Color mainColor = isBreak ? const Color(0xFF4CAF50) : Colors.orange;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        children: [
          Expanded(child: Container()),

          Expanded(
            child: Center(
              child: IconButton(
                iconSize: 70,
                icon: Icon(
                  isRunning ? Icons.pause : Icons.play_arrow,
                  color: mainColor,
                ),
                onPressed: isRunning ? onPause : onStart,
              ),
            ),
          ),

          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                iconSize: 36,
                icon: Icon(Icons.refresh, color: mainColor),
                onPressed: onReset,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
