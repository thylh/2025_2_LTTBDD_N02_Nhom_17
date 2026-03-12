import 'package:flutter/material.dart';
import '../widgets/today_stats_card.dart';
import '../services/session_repository.dart';
import '../services/stats_service.dart';
import '../utils/time_formatter.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sessions = SessionRepository.getSessions();
    final statsService = StatsService();

    final todayPomodoros = statsService.getTodayPomodoros(sessions);

    final todaySeconds = statsService.getTodayFocusSeconds(sessions);

    final focusTime = TimeFormatter.format(todaySeconds);

    return Scaffold(
      appBar: AppBar(title: const Text("Statistics")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: TodayStatsCard(focusTime: focusTime, pomodoros: todayPomodoros),
      ),
    );
  }
}
