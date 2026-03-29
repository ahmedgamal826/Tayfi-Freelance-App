import 'package:flutter/material.dart';

class SplashBackground extends StatelessWidget {
  const SplashBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(color: Colors.white),
      child: Stack(
        children: [
          Positioned(
            top: -60,
            left: -50,
            child: _FloatingOrb(size: 170, color: Color(0x10D7E6E2)),
          ),
          Positioned(
            top: 120,
            right: -40,
            child: _FloatingOrb(size: 140, color: Color(0x10F7E4C4)),
          ),
          Positioned(
            bottom: -70,
            left: -30,
            child: _FloatingOrb(size: 180, color: Color(0x100E5C5A)),
          ),
        ],
      ),
    );
  }
}

class _FloatingOrb extends StatelessWidget {
  const _FloatingOrb({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.6),
            blurRadius: 50,
            spreadRadius: 10,
          ),
        ],
      ),
    );
  }
}
