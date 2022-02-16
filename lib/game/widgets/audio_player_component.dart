import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

class AudioPlayerComponent extends Component {
  @override
  Future<void>? onLoad() async {
    await FlameAudio.audioCache.loadAll([
      '1up.mp3',
      'death.m4a',
      'game-over.mp3',
      'jump.mp3',
      'level-complete.mp3',
    ]);
    await FlameAudio.bgm.loadAll([
      'power-star.mp3',
      'overworld.mp3',
      'underground.mp3',
    ]);
    return super.onLoad();
  }

  void playBgm() {
    FlameAudio.bgm.play('overworld.mp3');
  }

  void resumeBgm() {
    FlameAudio.bgm.resume();
  }

  void playSfx(String filename) {
    FlameAudio.play(filename);
  }

  void pauseBgm() {
    FlameAudio.bgm.pause();
  }

  void stopBgm() {
    FlameAudio.bgm.stop();
  }
}
