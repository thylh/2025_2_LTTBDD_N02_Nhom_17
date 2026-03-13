import '../models/focus_session.dart';

class StatsService {
  int getTodayPomodoros(List<FocusSession> sessions) {
    final now = DateTime.now();

    return sessions
        .where(
          (session) =>
              session.date.year == now.year &&
              session.date.month == now.month &&
              session.date.day == now.day,
        )
        .length;
  }

  int getTodayFocusSeconds(List<FocusSession> sessions) {
    final now = DateTime.now();

    return sessions
        .where(
          (session) =>
              session.date.year == now.year &&
              session.date.month == now.month &&
              session.date.day == now.day,
        )
        .fold(0, (sum, session) => sum + session.duration);
  }

  List<int> getWeeklyPomodoros(List<FocusSession> sessions) {
    List<int> result = List.filled(7, 0);

    DateTime now = DateTime.now();

    for (var session in sessions) {
      int diff = now.difference(session.date).inDays;

      if (diff >= 0 && diff < 7) {
        int index = session.date.weekday - 1;

        result[index] += 1;
      }
    }

    return result;
  }

  List<int> getMonthlyPomodoros(List<FocusSession> sessions) {
    List<int> weeks = [0, 0, 0, 0];

    for (var session in sessions) {
      int weekOfMonth = ((session.date.day - 1) / 7).floor();

      if (weekOfMonth < 5) {
        weeks[weekOfMonth]++;
      }
    }

    return weeks;
  }

  List<int> getYearlyPomodoros(List<FocusSession> sessions) {
    List<int> months = List.filled(12, 0);

    for (var session in sessions) {
      int monthIndex = session.date.month - 1;

      months[monthIndex]++;
    }

    return months;
  }
}
