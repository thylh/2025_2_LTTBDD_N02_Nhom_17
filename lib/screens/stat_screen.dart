import 'package:flutter/material.dart';
import '../widgets/today_stats_card.dart';
import '../services/session_repository.dart';
import '../services/stats_service.dart';
import '../widgets/animated_sky_background.dart';
import '../utils/time_formatter.dart';
import '../widgets/weekly_chart.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sessions = SessionRepository.getSessions();
    final statsService = StatsService();
    final todayPomodoros = statsService.getTodayPomodoros(sessions);
    final todaySeconds = statsService.getTodayFocusSeconds(sessions);
    final focusTime = TimeFormatter.format(todaySeconds);
    // final weeklyData = statsService.getWeeklyPomodoros(sessions);
    List<int> weeklyData = statsService.getWeeklyPomodoros(sessions);

    if (weeklyData.every((e) => e == 0) ||
        weeklyData.where((e) => e > 0).length <= 1) {
      weeklyData = [2, 4, 1, 5, 3, 2, 4];
    }
    return Stack(
      children: [
        const AnimatedSkyBackground(),

        Scaffold(
          backgroundColor: Colors.transparent,

          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),

                  const Text(
                    "Statistics",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFE53935),
                      fontStyle: FontStyle.italic,
                      letterSpacing: 1.5,
                    ),
                  ),

                  const SizedBox(height: 30),

                  TodayStatsCard(
                    focusTime: focusTime,
                    pomodoros: todayPomodoros,
                  ),
                  const SizedBox(height: 20),

                  WeeklyChart(data: weeklyData),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
