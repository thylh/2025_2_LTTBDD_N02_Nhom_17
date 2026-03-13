import 'package:flutter/material.dart';
import '../widgets/today_stats_card.dart';
import '../services/session_repository.dart';
import '../services/stats_service.dart';
import '../widgets/animated_sky_background.dart';
import '../utils/time_formatter.dart';
import '../widgets/stats_chart.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sessions = SessionRepository.getSessions();
    final statsService = StatsService();
    final todayPomodoros = statsService.getTodayPomodoros(sessions);
    final todaySeconds = statsService.getTodayFocusSeconds(sessions);
    final focusTime = TimeFormatter.format(todaySeconds);
    final realWeekly = statsService.getWeeklyPomodoros(sessions);
    final realMonthly = statsService.getMonthlyPomodoros(sessions);
    final realYearly = statsService.getYearlyPomodoros(sessions);

    List<int> useData(List<int> realData, List<int> fakeData) {
      List<int> result = List.from(fakeData);

      for (int i = 0; i < realData.length; i++) {
        if (realData[i] > 0) {
          result[i] = realData[i];
        }
      }

      return result;
    }

    final weeklyData = useData(realWeekly, [2, 4, 1, 5, 3, 2, 4]);

    final monthlyData = useData(realMonthly, [6, 3, 5, 2]);

    final yearlyData = useData(realYearly, [
      3,
      4,
      2,
      6,
      5,
      3,
      4,
      2,
      3,
      5,
      4,
      3,
    ]);

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
                  const SizedBox(height: 18),

                  StatsCharts(
                    weeklyData: weeklyData,
                    monthlyData: monthlyData,
                    yearlyData: yearlyData,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
