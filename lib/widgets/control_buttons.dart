import 'package:flutter/material.dart';

class ControlButtons extends StatelessWidget {
  const ControlButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: () {}, child: const Text("Start")),
        const SizedBox(width: 20),
        ElevatedButton(onPressed: () {}, child: const Text("Reset")),
      ],
    );
  }
}
