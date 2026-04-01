import 'package:audioplayers/audioplayers.dart';

class SoundService {
  SoundService._();

  static final AudioPlayer _player = AudioPlayer()
    ..setReleaseMode(ReleaseMode.stop);

  static Future<void> playCategoryClick() async {
    try {
      await _player.stop();
      await _player.play(AssetSource('sounds/category_click.wav'));
    } catch (_) {
      // Ignore audio errors so taps continue to work normally.
    }
  }

  static Future<void> playToolTone() async {
    try {
      await _player.stop();
      await _player.play(AssetSource('sounds/toolTone.mp3'));
    } catch (_) {
      // Ignore audio errors so taps continue to work normally.
    }
  }
}
