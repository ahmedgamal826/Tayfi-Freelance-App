import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tayfi/services/sound_service.dart';
import 'package:tayfi/views/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  await SoundService.prewarm();
  runApp(const TayfiApp());
}

class TayfiApp extends StatelessWidget {
  const TayfiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tayfi',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF6F2EA),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0E5C5A),
          brightness: Brightness.light,
        ),
        fontFamily: 'sans-serif',
      ),
      home: const SplashScreen(),
    );
  }
}
