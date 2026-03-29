import 'package:flutter/material.dart';

class SplashLoadingSection extends StatelessWidget {
  const SplashLoadingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 130,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: const LinearProgressIndicator(
              minHeight: 6,
              valueColor: AlwaysStoppedAnimation(Color(0xFF0E5C5A)),
              backgroundColor: Color(0x110E5C5A),
            ),
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'Preparing your experience...',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF5A7370),
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}
