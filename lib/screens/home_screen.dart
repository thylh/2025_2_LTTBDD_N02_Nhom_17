import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/timer_circle.dart';
import '../widgets/control_buttons.dart';
import '../utils/constants.dart';
import '../utils/time_formatter.dart';
import '../widgets/status_pill.dart';
import '../widgets/animated_sky_background.dart';
import '../widgets/pomodoro_progress.dart';
import '../widgets/landscape.dart';
import '../screens/stat_screen.dart';
import '../services/session_repository.dart';
import '../models/focus_session.dart';

enum TimerState { working, breakTime, finished }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int totalSeconds;

  int selectedTab = 1;

  Timer? timer;
  bool isRunning = false;

  TimerState currentState = TimerState.working;
  int pomodoroCount = 0;

  int get workSeconds => AppConstants.defaultFocusMinutes * 60;
  int get breakSeconds => AppConstants.defaultBreakMinutes * 60;
  int get longBreakSeconds => AppConstants.defaultLongBreakMinutes * 60;

  @override
  void initState() {
    super.initState();
    totalSeconds = workSeconds;
  }

  void startTimer() {
    if (isRunning || currentState == TimerState.finished) return;

    timer?.cancel();

    setState(() {
      isRunning = true;
      if (totalSeconds > 0) {
        totalSeconds--;
      }
    });

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (totalSeconds > 0) {
        setState(() {
          totalSeconds--;
        });
      } else {
        timer?.cancel();
        isRunning = false;
        handlePhaseComplete();
      }
    });
  }

  void handlePhaseComplete() {
    if (currentState == TimerState.working) {
      SessionRepository.addSession(
        FocusSession(date: DateTime.now(), duration: workSeconds),
      );
      pomodoroCount++;

      setState(() {
        currentState = TimerState.breakTime;
        totalSeconds = (pomodoroCount % 4 == 0)
            ? longBreakSeconds
            : breakSeconds;
      });

      Future.delayed(const Duration(seconds: 2), startTimer);
    } else if (currentState == TimerState.breakTime) {
      if (pomodoroCount % 4 == 0) {
        setState(() {
          currentState = TimerState.finished;
          isRunning = false;
        });
        timer?.cancel();
        return;
      }

      setState(() {
        currentState = TimerState.working;
        totalSeconds = workSeconds;
      });

      Future.delayed(const Duration(seconds: 2), startTimer);
    }
  }

  void pauseTimer() {
    timer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void resetTimer() {
    timer?.cancel();

    setState(() {
      currentState = TimerState.working;
      totalSeconds = workSeconds;
      pomodoroCount = 0;
      isRunning = false;
    });
  }

  String get statusText {
    switch (currentState) {
      case TimerState.working:
        return "🔥 Working... Stay focused!";
      case TimerState.breakTime:
        return pomodoroCount % 4 == 0
            ? "🌴 Long Break... Relax!"
            : "☕ Short Break... Relax!";
      case TimerState.finished:
        return "✅ Pomodoro Finished!";
    }
  }

  double get progress {
    if (currentState == TimerState.working) {
      return totalSeconds / workSeconds;
    } else if (currentState == TimerState.breakTime) {
      return totalSeconds /
          (pomodoroCount % 4 == 0 ? longBreakSeconds : breakSeconds);
    }
    return 0;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Widget buildTimerUI() {
    final formattedTime = TimeFormatter.format(totalSeconds);

    return Column(
      children: [
        const SizedBox(height: 30),

        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
            children: [
              TextSpan(
                text: "Focus",
                style: TextStyle(color: Colors.black),
              ),
              TextSpan(
                text: "Flow...",
                style: TextStyle(
                  color: Color(0xFFE53935),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 90),

        StatusPill(
          text: statusText,
          isBreak: currentState == TimerState.breakTime,
        ),

        const SizedBox(height: 45),

        TimerCircle(
          time: formattedTime,
          progress: progress,
          isBreak: currentState == TimerState.breakTime,
        ),

        const SizedBox(height: 30),

        PomodoroProgress(pomodoroCount: pomodoroCount),

        const SizedBox(height: 60),

        ControlButtons(
          isRunning: isRunning,
          isBreak: currentState == TimerState.breakTime,
          onStart: startTimer,
          onPause: pauseTimer,
          onReset: resetTimer,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      const StatsScreen(),
      buildTimerUI(),
      const Center(child: Text("Settings")),
      const Center(child: Text("About")),
    ];

    return Stack(
      children: [
        const AnimatedSkyBackground(),

        Scaffold(
          backgroundColor: Colors.transparent,

          body: SafeArea(child: screens[selectedTab]),

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedTab,
            onTap: (index) {
              setState(() {
                selectedTab = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            selectedItemColor: Color(0xFFE53935),
            unselectedItemColor: Colors.grey,
            selectedFontSize: 15,
            iconSize: 26,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
                label: "Stats",
              ),
              BottomNavigationBarItem(icon: Icon(Icons.timer), label: "Timer"),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings",
              ),
              BottomNavigationBarItem(icon: Icon(Icons.info), label: "About"),
            ],
          ),
        ),

        const Positioned(
          bottom: 60,
          left: 0,
          right: 0,
          child: LandscapeWidget(),
        ),
      ],
    );
  }
}
