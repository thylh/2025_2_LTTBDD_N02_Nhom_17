import 'package:flutter/material.dart';
import '../services/app_language.dart';

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
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLanguage.t("today"),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("⏱ ${AppLanguage.t("focus_time")}"),
                Text(focusTime),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("🍅 ${AppLanguage.t("pomodoros")}"),
                Text("$pomodoros"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
