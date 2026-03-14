import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'services/app_language.dart';
import 'services/app_theme.dart';

void main() {
  runApp(const FocusFlowApp());
}

class FocusFlowApp extends StatelessWidget {
  const FocusFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AppLanguage.languageNotifier,
      builder: (context, value, child) {
        return ValueListenableBuilder(
          valueListenable: AppTheme.themeNotifier,
          builder: (context, themeMode, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,

              themeMode: themeMode,

              theme: ThemeData(
                brightness: Brightness.light,
                scaffoldBackgroundColor: Colors.white,
              ),

              darkTheme: ThemeData(
                brightness: Brightness.dark,
                scaffoldBackgroundColor: const Color(0xFF121212),
              ),

              home: const HomeScreen(),
            );
          },
        );
      },
    );
  }
}
