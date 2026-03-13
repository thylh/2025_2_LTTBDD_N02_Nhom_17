import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double focusMinutes = 25;
  double breakMinutes = 5;

  bool soundEnabled = true;
  bool notificationEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings"), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          /// Focus Time
          const Text(
            "Focus Time",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Slider(
            value: focusMinutes,
            min: 15,
            max: 60,
            divisions: 9,
            label: "${focusMinutes.round()} min",
            onChanged: (value) {
              setState(() {
                focusMinutes = value;
              });
            },
          ),
          Text(
            "${focusMinutes.round()} minutes",
            style: const TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 30),

          /// Break Time
          const Text(
            "Break Time",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Slider(
            value: breakMinutes,
            min: 3,
            max: 20,
            divisions: 17,
            label: "${breakMinutes.round()} min",
            onChanged: (value) {
              setState(() {
                breakMinutes = value;
              });
            },
          ),
          Text(
            "${breakMinutes.round()} minutes",
            style: const TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 30),

          /// Sound
          SwitchListTile(
            title: const Text("Sound"),
            subtitle: const Text("Play sound when timer finishes"),
            value: soundEnabled,
            onChanged: (value) {
              setState(() {
                soundEnabled = value;
              });
            },
          ),

          /// Notification
          SwitchListTile(
            title: const Text("Notification"),
            subtitle: const Text("Receive timer notifications"),
            value: notificationEnabled,
            onChanged: (value) {
              setState(() {
                notificationEnabled = value;
              });
            },
          ),

          const Divider(height: 40),

          /// About
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("About"),
            subtitle: const Text("Pomodoro Timer App"),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "Pomodoro Timer",
                applicationVersion: "1.0.0",
                children: const [
                  Text("Simple productivity timer using Pomodoro technique."),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
