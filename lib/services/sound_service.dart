import 'package:audioplayers/audioplayers.dart';

class SoundService {
  SoundService._();

  static final AudioPlayer _player = AudioPlayer()
    ..setReleaseMode(ReleaseMode.stop);
  static bool _isPrewarmed = false;

  static Future<void> prewarm() async {
    if (_isPrewarmed) return;
    try {
      // Warm up decoder/buffer once to reduce the first-tap delay.
      await _player.play(AssetSource('sounds/category_click.wav'), volume: 0);
      await _player.stop();
      await _player.play(AssetSource('sounds/toolTone.mp3'), volume: 0);
      await _player.stop();
      await _player.setVolume(1.0);
      _isPrewarmed = true;
    } catch (_) {
      // Ignore warm-up failures to avoid blocking app startup.
    }
  }

  static Future<void> playCategoryClick() async {
    try {
      await _player.setVolume(1.0);
      await _player.stop();
      await _player.play(AssetSource('sounds/category_click.wav'));
    } catch (_) {
      // Ignore audio errors so taps continue to work normally.
    }
  }

  static Future<void> playToolTone() async {
    try {
      await _player.setVolume(1.0);
      await _player.stop();
      await _player.play(AssetSource('sounds/toolTone.mp3'));
    } catch (_) {
      // Ignore audio errors so taps continue to work normally.
    }
  }
}
