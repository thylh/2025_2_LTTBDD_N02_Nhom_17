import 'package:flutter/material.dart';
import '../widgets/animated_sky_background.dart';
import '../services/app_language.dart';
// import '../screens/home_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  bool soundEnabled = true;
  bool notificationEnabled = true;

  String selectedLanguage = "English";

  final List<String> languages = ["English", "Tiếng Việt"];

  @override
  Widget build(BuildContext context) {
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
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: ListView(
                          children: [
                            Text(
                              AppLanguage.t("language"),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                            DropdownButtonFormField<String>(
                              initialValue:
                                  AppLanguage.languageNotifier.value == "vi"
                                  ? "Tiếng Việt"
                                  : "English",
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
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
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SwitchListTile(
                              title: Text(AppLanguage.t("dark_mode")),
                              subtitle: Text(AppLanguage.t("theme_switch")),
                              value: isDarkMode,
                              onChanged: (value) {
                                setState(() {
                                  isDarkMode = value;
                                });
                              },
                            ),

                            const Divider(height: 40),

                            SwitchListTile(
                              title: Text(AppLanguage.t("sound")),
                              subtitle: Text(AppLanguage.t("sound_finish")),
                              value: soundEnabled,
                              onChanged: (value) {
                                setState(() {
                                  soundEnabled = value;
                                });
                              },
                            ),

                            SwitchListTile(
                              title: Text(AppLanguage.t("notification")),
                              subtitle: Text(
                                AppLanguage.t("notification_receive"),
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
