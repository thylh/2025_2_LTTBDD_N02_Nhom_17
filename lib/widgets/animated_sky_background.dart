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

  final int cloudCount = 6;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget buildCloud(double screenWidth, int index) {
    final top = random.nextDouble() * 350 + 10;
    final size = random.nextDouble() * 40 + 50;
    final speedOffset = random.nextDouble();

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        double movement =
            (controller.value + speedOffset) % 1 * (screenWidth + 200) - 100;

        return Positioned(
          top: top,
          left: movement,
          child: Icon(
            Icons.cloud,
            size: size,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB), Color(0xFFFFFFFF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),

        Positioned(
          top: 60,
          right: 40,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withValues(alpha: 0.4),
                  blurRadius: 40,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: const Icon(Icons.wb_sunny, size: 80, color: Colors.orange),
          ),
        ),

        ...List.generate(cloudCount, (index) => buildCloud(screenWidth, index)),
      ],
    );
  }
}
