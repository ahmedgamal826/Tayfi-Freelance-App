import 'dart:math' as math;

import 'package:flutter/material.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({
    super.key,
    required this.progress,
    required this.scale,
    required this.rotation,
  });

  final double progress;
  final double scale;
  final double rotation;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: Transform.rotate(
        angle: rotation,
        child: Transform.translate(
          offset: Offset(0, math.sin(progress * 7) * 4),
          child: Image.asset(
            'assets/images/tayfi_splash_logo.png',
            width: 290,
            height: 290,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
