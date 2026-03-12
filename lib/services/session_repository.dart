import '../models/focus_session.dart';

class SessionRepository {
  static final List<FocusSession> _sessions = [];

  static void addSession(FocusSession session) {
    _sessions.add(session);
  }

  static List<FocusSession> getSessions() {
    return _sessions;
  }
}
