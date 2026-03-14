import 'package:flutter/material.dart';
import '../widgets/animated_sky_background.dart';
import '../services/app_language.dart';
import '../services/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool soundEnabled = true;
  bool notificationEnabled = true;

  String selectedLanguage = "English";

  final List<String> languages = ["English", "Tiếng Việt"];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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

                  Text(
                    AppLanguage.t("settings"),
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFE53935),
                      fontStyle: FontStyle.italic,
                      letterSpacing: 1.5,
                    ),
                  ),

                  const SizedBox(height: 30),

                  Expanded(
                    child: Card(
                      color: isDark ? const Color(0xFF2A2A3C) : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: ListView(
                          children: [
                            Text(
                              AppLanguage.t("language"),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),

                            const SizedBox(height: 10),

                            DropdownButtonFormField<String>(
                              initialValue:
                                  AppLanguage.languageNotifier.value == "vi"
                                  ? "Tiếng Việt"
                                  : "English",
                              dropdownColor: isDark
                                  ? const Color(0xFF2A2A3C)
                                  : null,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                              ),
                              items: languages
                                  .map(
                                    (lang) => DropdownMenuItem(
                                      value: lang,
                                      child: Text(lang),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                if (value == null) return;

                                setState(() {
                                  selectedLanguage = value;
                                });

                                if (value == "English") {
                                  AppLanguage.languageNotifier.value = "en";
                                } else {
                                  AppLanguage.languageNotifier.value = "vi";
                                }
                              },
                            ),

                            const SizedBox(height: 30),

                            Text(
                              AppLanguage.t("appearance"),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),

                            ValueListenableBuilder(
                              valueListenable: AppTheme.themeNotifier,
                              builder: (context, themeMode, child) {
                                return SwitchListTile(
                                  title: Text(
                                    AppLanguage.t("dark_mode"),
                                    style: TextStyle(
                                      color: isDark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  subtitle: Text(
                                    AppLanguage.t("theme_switch"),
                                    style: TextStyle(
                                      color: isDark
                                          ? Colors.white70
                                          : Colors.black54,
                                    ),
                                  ),
                                  value: themeMode == ThemeMode.dark,
                                  onChanged: (value) {
                                    AppTheme.toggleTheme(value);
                                  },
                                );
                              },
                            ),

                            const Divider(height: 40),

                            SwitchListTile(
                              title: Text(
                                AppLanguage.t("sound"),
                                style: TextStyle(
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                              subtitle: Text(
                                AppLanguage.t("sound_finish"),
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white70
                                      : Colors.black54,
                                ),
                              ),
                              value: soundEnabled,
                              onChanged: (value) {
                                setState(() {
                                  soundEnabled = value;
                                });
                              },
                            ),

                            SwitchListTile(
                              title: Text(
                                AppLanguage.t("notification"),
                                style: TextStyle(
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                              subtitle: Text(
                                AppLanguage.t("notification_receive"),
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white70
                                      : Colors.black54,
                                ),
                              ),
                              value: notificationEnabled,
                              onChanged: (value) {
                                setState(() {
                                  notificationEnabled = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
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
