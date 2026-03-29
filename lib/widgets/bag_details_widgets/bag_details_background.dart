import 'package:flutter/material.dart';

class BagDetailsBackground extends StatelessWidget {
  const BagDetailsBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/homeBackgroundImage.jpg',
          fit: BoxFit.fill,
        ),
        Container(
          color: const Color(0x993E2716),
        ),
      ],
    );
  }
}
