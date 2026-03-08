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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        children: [
          const Spacer(),

          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: IconButton(
              iconSize: 50,
              padding: const EdgeInsets.all(18),
              icon: Icon(
                isRunning ? Icons.pause : Icons.play_arrow,
                color: Colors.black,
              ),
              onPressed: isRunning ? onPause : onStart,
            ),
          ),

          const Spacer(),

          IconButton(
            iconSize: 34,
            icon: const Icon(Icons.refresh, color: Colors.black),
            onPressed: onReset,
          ),
        ],
      ),
    );
  }
}
