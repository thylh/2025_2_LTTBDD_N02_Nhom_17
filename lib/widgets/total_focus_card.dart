import 'package:flutter/material.dart';
import '../services/app_language.dart';

class TotalFocusCard extends StatelessWidget {
  final String totalTime;

  const TotalFocusCard({super.key, required this.totalTime});

  String formatHour(String time) {
    final parts = time.split(" ");
    int hours = 0;
    int minutes = 0;

    for (var p in parts) {
      if (p.contains("h")) {
        hours = int.tryParse(p.replaceAll("h", "")) ?? 0;
      }
      if (p.contains("m")) {
        minutes = int.tryParse(p.replaceAll("m", "")) ?? 0;
      }
    }

    double totalHour = hours + minutes / 60;
    return "${totalHour.toStringAsFixed(1)}h";
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,

      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),

          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.schedule, color: Color(0xFFE53935), size: 28),

              const SizedBox(width: 14),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLanguage.t("total_focus"),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    formatHour(totalTime),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE53935),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
