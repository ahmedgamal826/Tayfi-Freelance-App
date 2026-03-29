import 'package:flutter/material.dart';

class HomeBackground extends StatelessWidget {
  const HomeBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/homeBackgroundImage.jpg',
      fit: BoxFit.fill,
      alignment: Alignment.center,
    );
  }
}
