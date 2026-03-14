import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedSkyBackground extends StatefulWidget {
  const AnimatedSkyBackground({super.key});

  @override
  State<AnimatedSkyBackground> createState() => _AnimatedSkyBackgroundState();
}

class _AnimatedSkyBackgroundState extends State<AnimatedSkyBackground>
    with TickerProviderStateMixin {
  final Random random = Random();

  late AnimationController controller;

  final int cloudCount = 8;

  late List<double> cloudTops;
  late List<double> cloudSizes;
  late List<double> cloudOffsets;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    )..repeat();

    /// tạo vị trí cloud cố định
    cloudTops = List.generate(cloudCount, (_) => random.nextDouble() * 650 + 5);
    cloudSizes = List.generate(
      cloudCount,
      (_) => random.nextDouble() * 40 + 40,
    );
    cloudOffsets = List.generate(cloudCount, (_) => random.nextDouble());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget buildCloud(double screenWidth, int index, bool isDark) {
    final top = cloudTops[index];
    final size = cloudSizes[index];
    final speedOffset = cloudOffsets[index];

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        double movement =
            (controller.value + speedOffset) % 1 * (screenWidth + 200) - 100;

        return Positioned(
          top: top,
          left: movement,
          child: Icon(
            isDark ? Icons.star : Icons.cloud,
            size: size,
            color: isDark
                ? Colors.white.withValues(alpha: 0.8)
                : Colors.white.withValues(alpha: 0.9),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? [
                      const Color(0xFF1A2F38),
                      const Color(0xFF2B4A55),
                      const Color(0xFF3B6375),
                    ]
                  : [
                      const Color(0xFFE3F2FD),
                      const Color(0xFFBBDEFB),
                      const Color(0xFFFFFFFF),
                    ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),

        Positioned(
          top: 40,
          right: 30,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.2)
                      : Colors.orange.withValues(alpha: 0.4),
                  blurRadius: 40,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Icon(
              isDark ? Icons.nightlight_round : Icons.wb_sunny,
              size: 80,
              color: isDark ? Colors.white : Colors.orange,
            ),
          ),
        ),

        /// Clouds / Stars
        ...List.generate(
          cloudCount,
          (index) => buildCloud(screenWidth, index, isDark),
        ),
      ],
    );
  }
}
