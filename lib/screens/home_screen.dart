import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/timer_circle.dart';
import '../widgets/control_buttons.dart';
import '../utils/constants.dart';
import '../utils/time_formatter.dart';

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

  int get workSeconds => AppConstants.defaultFocusMinutes * 60;
  int get breakSeconds => AppConstants.defaultBreakMinutes * 60;

  @override
  void initState() {
    super.initState();
    totalSeconds = workSeconds;
  }

  void startTimer() {
    if (isRunning || currentState == TimerState.finished) return;

    isRunning = true;

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
      setState(() {
        currentState = TimerState.breakTime;
        totalSeconds = breakSeconds;
      });

      // Tự động bắt đầu break sau 2 giây
      Future.delayed(const Duration(seconds: 2), () {
        startTimer();
      });
    } else if (currentState == TimerState.breakTime) {
      setState(() {
        currentState = TimerState.finished;
      });
    }
  }

  void pauseTimer() {
    timer?.cancel();
    isRunning = false;
  }

  void resetTimer() {
    timer?.cancel();
    setState(() {
      currentState = TimerState.working;
      totalSeconds = workSeconds;
      isRunning = false;
    });
  }

  String get statusText {
    switch (currentState) {
      case TimerState.working:
        return "🔥 Working... Stay focused!";
      case TimerState.breakTime:
        return "☕ Break time... Relax!";
      case TimerState.finished:
        return "✅ Hoàn thành 1 phiên Pomodoro!";
    }
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

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "FocusFlow",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            statusText,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),
          TimerCircle(
            time: formattedTime,
            progress: progress,
            isBreak: currentState == TimerState.breakTime,
          ),
          const SizedBox(height: 40),
          ControlButtons(
            isRunning: isRunning,
            onStart: startTimer,
            onPause: pauseTimer,
            onReset: resetTimer,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Stats"),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "About"),
        ],
      ),
    );
  }
}
