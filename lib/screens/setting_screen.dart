import 'package:flutter/material.dart';
import '../widgets/animated_sky_background.dart';

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

                  const Text(
                    "Settings",
                    style: TextStyle(
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
                            const Text(
                              "Language",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                            DropdownButtonFormField<String>(
                              initialValue: selectedLanguage,
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
                              },
                            ),

                            const SizedBox(height: 30),

                            const Text(
                              "Appearance",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SwitchListTile(
                              title: const Text("Dark Mode"),
                              subtitle: const Text(
                                "Switch between light and dark theme",
                              ),
                              value: isDarkMode,
                              onChanged: (value) {
                                setState(() {
                                  isDarkMode = value;
                                });
                              },
                            ),

                            const Divider(height: 40),

                            SwitchListTile(
                              title: const Text("Sound"),
                              subtitle: const Text(
                                "Play sound when timer finishes",
                              ),
                              value: soundEnabled,
                              onChanged: (value) {
                                setState(() {
                                  soundEnabled = value;
                                });
                              },
                            ),

                            SwitchListTile(
                              title: const Text("Notification"),
                              subtitle: const Text(
                                "Receive timer notifications",
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
