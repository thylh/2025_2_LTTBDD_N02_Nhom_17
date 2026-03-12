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
}
