import 'package:flutter/material.dart';

class TodayStatsCard extends StatelessWidget {
  final String focusTime;
  final int pomodoros;

  const TodayStatsCard({
    super.key,
    required this.focusTime,
    required this.pomodoros,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Today",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text("⏱ Focus Time"), Text(focusTime)],
            ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text("🍅 Pomodoros"), Text("$pomodoros")],
            ),
          ],
        ),
      ),
    );
  }
}
