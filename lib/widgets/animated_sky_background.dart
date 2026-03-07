import 'package:flutter/material.dart';

class AnimatedSkyBackground extends StatefulWidget {
  const AnimatedSkyBackground({super.key});

  @override
  State<AnimatedSkyBackground> createState() => _AnimatedSkyBackgroundState();
}

class _AnimatedSkyBackgroundState extends State<AnimatedSkyBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _cloudAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 25),
    )..repeat();

    _cloudAnimation = Tween<double>(begin: -200, end: 400).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE3F2FD), Color(0xFFFFFFFF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),

        Positioned(
          top: 60,
          right: 40,
          child: Icon(
            Icons.wb_sunny,
            size: 80,
            color: Colors.orange.withOpacity(0.9),
          ),
        ),

        AnimatedBuilder(
          animation: _cloudAnimation,
          builder: (context, child) {
            return Positioned(
              top: 120,
              left: _cloudAnimation.value,
              child: const Icon(Icons.cloud, size: 60, color: Colors.white),
            );
          },
        ),

        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Positioned(
              top: 180,
              left: _cloudAnimation.value - 250,
              child: const Icon(Icons.cloud, size: 50, color: Colors.white),
            );
          },
        ),
      ],
    );
  }
}
