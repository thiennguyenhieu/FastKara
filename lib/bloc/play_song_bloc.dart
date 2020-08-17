import 'package:rxdart/rxdart.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:fast_kara/package/flutter_lyric/lyric_controller.dart';

class PlaySongBloc {
  AudioPlayer _audioPlayer;
  String _beatUrl;
  bool _audioPlaying;
  Duration _duration;
  Duration _position;
  LyricController _controller;

  BehaviorSubject<Duration> _subjectDuration;
  ValueStream<Duration> get audioDuration => _subjectDuration.stream;

  BehaviorSubject<Duration> _subjectPosition;
  ValueStream<Duration> get audioPosition => _subjectPosition.stream;

  BehaviorSubject<double> _subjectProgress;
  ValueStream<double> get audioProgress => _subjectProgress.stream;

  BehaviorSubject<bool> _subjectAudioPlaying;
  ValueStream<bool> get audioPlaying => _subjectAudioPlaying.stream;

  PlaySongBloc() {
    _subjectDuration = new BehaviorSubject<Duration>();
    _subjectPosition = new BehaviorSubject<Duration>();
    _subjectProgress = new BehaviorSubject<double>();
    _subjectAudioPlaying = new BehaviorSubject<bool>();

    _audioPlayer = new AudioPlayer();

    _audioPlayer.onDurationChanged.listen((Duration d) {
      _duration = d;
      _subjectDuration.sink.add(d);
      _subjectProgress.sink
          .add(_position.inSeconds.toDouble() / d.inSeconds.toDouble());
    });

    _audioPlayer.onAudioPositionChanged.listen((Duration p) {
      _position = p;
      _controller.progress = p;
      _subjectPosition.sink.add(p);
      _subjectProgress.sink
          .add(p.inSeconds.toDouble() / _duration.inSeconds.toDouble());
    });

    _audioPlayer.onPlayerStateChanged.listen((AudioPlayerState audioState) {
      _audioPlaying = (audioState == AudioPlayerState.PLAYING) ? true : false;
      _subjectAudioPlaying.sink.add(_audioPlaying);
    });
  }

  void setBeatUrl(String url) {
    _audioPlayer.setUrl(url);
    _beatUrl = url;

    // reset progress bar for the first time entering screen
    _subjectPosition.sink.add(Duration(seconds: 0));
    _subjectProgress.sink.add(0.0);
  }

  void setLyricsController(LyricController controller) {
    _controller = controller;
  }

  Future<int> playAudio() async {
    return _audioPlayer.play(_beatUrl);
  }

  Future<int> pauseAudio() async {
    return _audioPlayer.pause();
  }

  Future<int> stopAudio() async {
    return _audioPlayer.stop();
  }

  Future<int> releaseAudio() async {
    return _audioPlayer.release();
  }

  void dispose() {
    _subjectDuration.close();
    _subjectPosition.close();
    _subjectProgress.close();
    _subjectAudioPlaying.close();
  }
}
