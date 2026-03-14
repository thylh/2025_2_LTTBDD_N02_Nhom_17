import 'package:flutter/material.dart';

class AppLanguage {
  static ValueNotifier<String> languageNotifier = ValueNotifier("en");

  static final Map<String, Map<String, String>> texts = {
    "en": {
      "settings": "Settings",
      "language": "Language",
      "appearance": "Appearance",
      "dark_mode": "Dark Mode",
      "sound": "Sound",
      "notification": "Notification",
      "statistics": "Statistics",
      "today": "Today",
      "focus_time": "Focus Time",
      "pomodoros": "Pomodoro",
      "stats": "Stats",
      "timer": "Timer",
      "about": "About",
      "working": "Working... Stay focused!",
      "short_break": "Short Break... Relax!",
      "long_break": "Long Break... Relax!",
      "completed": "Completed! Congratulations.",
      "total_focus": "Total Focus",
      "weekly_activity": "Weekly Activity",
      "monthly_focus": "Monthly Focus",
      "yearly_focus": "Yearly Focus",
      "theme_switch": "Switch between light and dark theme",
      "sound_finish": "Play sound when timer finishes",
      "notification_receive": "Receive timer notifications",
    },

    "vi": {
      "settings": "Cài đặt",
      "language": "Ngôn ngữ",
      "appearance": "Giao diện",
      "dark_mode": "Chế độ tối",
      "sound": "Âm thanh",
      "notification": "Thông báo",
      "statistics": "Thống kê",
      "today": "Hôm nay",
      "focus_time": "Thời gian tập trung",
      "pomodoros": "Pomodoro",
      "stats": "Thống kê",
      "timer": "Hẹn giờ",
      "about": "Thông tin",
      "working": "Đang làm việc... Hãy tập trung!",
      "short_break": "Nghỉ ngắn... Thư giãn!",
      "long_break": "Nghỉ dài... Thư giãn!",
      "completed": "Hoàn thành! Chúc mừng.",
      "total_focus": "Tổng thời gian tập trung",
      "weekly_activity": "Hoạt động tuần",
      "monthly_focus": "Tập trung tháng",
      "yearly_focus": "Tập trung năm",
      "theme_switch": "Chuyển đổi giữa giao diện sáng và tối",
      "sound_finish": "Phát âm thanh khi bộ đếm kết thúc",
      "notification_receive": "Nhận thông báo từ bộ đếm",
    },
  };

  static String t(String key) {
    return texts[languageNotifier.value]?[key] ?? key;
  }
}
