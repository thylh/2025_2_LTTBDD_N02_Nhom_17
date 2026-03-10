import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/timer_circle.dart';
import '../widgets/control_buttons.dart';
import '../utils/constants.dart';
import '../utils/time_formatter.dart';
import '../widgets/status_pill.dart';
import '../widgets/animated_sky_background.dart';
import '../widgets/pomodoro_progress.dart';

enum TimerState { working, breakTime, finished }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int totalSeconds;
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
      pomodoroCount++;

      setState(() {
        currentState = TimerState.breakTime;

        if (pomodoroCount % 4 == 0) {
          totalSeconds = longBreakSeconds;
        } else {
          totalSeconds = breakSeconds;
        }
      });

      Future.delayed(const Duration(seconds: 2), () {
        startTimer();
      });
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

      Future.delayed(const Duration(seconds: 2), () {
        startTimer();
      });
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
    if (currentState == TimerState.working) {
      return "🔥 Working... Stay focused!";
    }

    if (currentState == TimerState.breakTime) {
      if (pomodoroCount % 4 == 0) {
        return "🌴 Long Break... Relax!";
      }

      return "☕ Short Break... Relax!";
    }

    return "✅ Pomodoro Finished!";
  }

  double get progress {
    if (currentState == TimerState.working) {
      return totalSeconds / workSeconds;
    } else if (currentState == TimerState.breakTime) {
      return totalSeconds / breakSeconds;
    }
    return 0;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formattedTime = TimeFormatter.format(totalSeconds);

    return Stack(
      children: [
        const AnimatedSkyBackground(),

        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 30),

                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                      shadows: [
                        Shadow(
                          color: Color(0x66E53935),
                          blurRadius: 5,
                          offset: Offset(0, 9),
                        ),
                      ],
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
            ),
          ),
        ),
      ],
    );
  }
}
