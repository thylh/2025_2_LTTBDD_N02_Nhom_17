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
        result[6 - diff] += 1;
      }
    }

    return result;
  }
}
