import 'package:flutter/material.dart';

class LandscapeWidget extends StatelessWidget {
  const LandscapeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Stack(
        children: [
          Positioned(bottom: 0, left: -40, child: _hill(140, 60)),

          Positioned(bottom: 0, left: 70, child: _hill(180, 70)),

          Positioned(bottom: 0, right: 40, child: _hill(150, 60)),

          Positioned(bottom: 0, right: -30, child: _hill(120, 50)),

          const Positioned(
            bottom: 30,
            left: 10,
            child: Icon(Icons.park, color: Color(0xFF2E7D32), size: 40),
          ),

          const Positioned(
            bottom: 38,
            left: 70,
            child: Icon(Icons.park, color: Color(0xFF2E7D32), size: 30),
          ),

          const Positioned(
            bottom: 40,
            right: 80,
            child: Icon(Icons.park, color: Color(0xFF2E7D32), size: 24),
          ),

          const Positioned(
            bottom: 20,
            right: 60,
            child: Icon(Icons.park, color: Color(0xFF2E7D32), size: 40),
          ),

          const Positioned(
            bottom: 40,
            right: 10,
            child: Icon(Icons.park, color: Color(0xFF2E7D32), size: 50),
          ),
        ],
      ),
    );
  }

  Widget _hill(double width, double height) {
    return Container(
      width: width,
      height: 75,
      decoration: const BoxDecoration(
        color: Color(0xFF4CAF50),
        borderRadius: BorderRadius.vertical(top: Radius.circular(1000)),
      ),
    );
  }
}
