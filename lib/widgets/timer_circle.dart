import 'package:flutter/material.dart';
import 'dart:math';

class TimerCircle extends StatelessWidget {
  final String time;
  final double progress;
  final bool isBreak;

  const TimerCircle({
    super.key,
    required this.time,
    required this.progress,
    required this.isBreak,
  });

  @override
  Widget build(BuildContext context) {
    final Color activeColor = isBreak ? const Color(0xFF4CAF50) : Colors.orange;

    return SizedBox(
      width: 250,
      height: 250,
      child: Stack(
        alignment: Alignment.center,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: progress),
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            builder: (context, value, _) {
              return CustomPaint(
                size: const Size(250, 250),
                painter: CirclePainter(progress: value, color: activeColor),
              );
            },
          ),
          Text(
            time,
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: activeColor,
            ),
          ),
        ],
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final double progress;
  final Color color;

  CirclePainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 14.0;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - strokeWidth / 2;

    final rect = Rect.fromCircle(center: center, radius: radius);

    final basePaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawArc(rect, -pi / 2, 2 * pi, false, basePaint);

    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final sweepAngle = -2 * pi * progress;

    canvas.drawArc(rect, -pi / 2, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CirclePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
