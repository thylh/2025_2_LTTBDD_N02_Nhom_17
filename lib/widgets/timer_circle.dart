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
    return SizedBox(
      width: 250,
      height: 250,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(250, 250),
            painter: CirclePainter(progress: progress, isBreak: isBreak),
          ),
          Text(
            time,
            style: TextStyle(
              fontSize: 44,
              fontWeight: FontWeight.bold,
              color: isBreak ? const Color(0xFF4CAF50) : Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final double progress;
  final bool isBreak;

  CirclePainter({required this.progress, required this.isBreak});

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 14.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - strokeWidth / 2;

    final rect = Rect.fromCircle(center: center, radius: radius);

    final basePaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    canvas.drawArc(rect, -pi / 2, 2 * pi, false, basePaint);

    final progressPaint = Paint()
      ..color = isBreak ? const Color(0xFF4CAF50) : Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final sweepAngle = -2 * pi * progress;

    canvas.drawArc(rect, -pi / 2, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
