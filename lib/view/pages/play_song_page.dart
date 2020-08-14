import 'dart:convert' show utf8;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;

import 'package:fast_kara/extpackage/flutter_lyric/lyric_widget.dart';
import 'package:fast_kara/extpackage/flutter_lyric/lyric_controller.dart';
import 'package:fast_kara/extpackage/flutter_lyric/lyric_util.dart';
import 'package:fast_kara/extpackage/flutter_lyric/lyric.dart';

import 'package:fast_kara/static/const_color.dart';
import 'package:fast_kara/model/song_model.dart';
import 'package:loading/loading.dart';

class PlaySongPage extends StatefulWidget {
  final SongModel song;
  const PlaySongPage(this.song);

  @override
  _PlaySongPageState createState() => _PlaySongPageState();
}

class _PlaySongPageState extends State<PlaySongPage>
    with TickerProviderStateMixin {
  Duration _duration = new Duration(seconds: 1);
  Duration _position = new Duration(seconds: 0);
  AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  LyricController _controller;
  List<Lyric> _lyrics = [];

  @override
  void initState() {
//    getTextFromFile(widget.song.lyrics).then((val) => setState(() {
//          _lyrics.clear();
//          _lyrics = LyricUtil.formatLyric(val);
//        }));

    _controller = LyricController(vsync: this);

    initPlayer();

    super.initState();
  }

  void initPlayer() {
    _audioPlayer.setUrl(widget.song.beatUrl);
    _audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() => _duration = d);
    });

    _audioPlayer.onAudioPositionChanged.listen((Duration p) {
      setState(() => _position = p);
      _controller.progress = p;
    });

    _audioPlayer.onPlayerStateChanged.listen((AudioPlayerState audioState) {
      setState(() {
        _isPlaying = (audioState == AudioPlayerState.PLAYING) ? true : false;
      });
    });
  }

  void goBack(BuildContext context) {
    _audioPlayer.release();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          heroTag: 'playsongpage',
          transitionBetweenRoutes: false,
          leading: Row(
            children: <Widget>[
              CupertinoNavigationBarBackButton(
                color: AppColors.colorAppText,
                onPressed: () => goBack(context),
              ),
              Text(
                'Home',
                style: TextStyle(color: AppColors.colorAppText, fontSize: 20.0),
              ),
            ],
          ),
          backgroundColor: AppColors.colorAppBackground,
          border: Border(bottom: BorderSide(color: Colors.transparent)),
        ),
        child: Scaffold(
            appBar: null,
            backgroundColor: AppColors.colorAppBackground,
            body: Column(children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10.0, top: 0.0, right: 10.0),
                height: MediaQuery.of(context).size.height / 2,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.colorAppChildComponent,
                ),
                child: FutureBuilder(
                    future: getTextFromFile(widget.song.lyrics),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                        _lyrics.clear();
                        _lyrics = LyricUtil.formatLyric(snapshot.data);
                        return LyricWidget(
                          size: Size(
                            double.infinity,
                            double.infinity,
                          ),
                          lyrics: _lyrics,
                          remarkLyrics: [],
                          enableDrag: true,
                          controller: _controller,
                        );
                      } else {
                        return Loading(size: 50, color: Colors.white);
                      }
                    }),
              ),
              Container(
                margin: EdgeInsets.only(top: 40.0, left: 10.0, right: 10.0),
                alignment: Alignment.topLeft,
                child: Text(
                  widget.song.title,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                alignment: Alignment.topLeft,
                child: Text(
                  widget.song.singer,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white70,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
                alignment: Alignment.topLeft,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey[800],
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                  value: _position.inSeconds.toDouble() /
                      _duration.inSeconds.toDouble(),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Container(
                      margin: EdgeInsets.only(left: 10.0),
                      child: Text(
                        _position.toString().substring(2, 7),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    new Container(
                      child: Text(
                        _duration.toString().substring(2, 7),
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                        onPressed: () {}),
                    IconButton(
                        icon: Icon(
                          Icons.file_download,
                          color: Colors.white,
                        ),
                        onPressed: () {}),
                    IconButton(
                        iconSize: 60,
                        icon: Icon(
                          _isPlaying
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_filled,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          if (_isPlaying) {
                            await _audioPlayer.pause();
                          } else {
                            await _audioPlayer.play(widget.song.beatUrl);
                          }
                        }),
                    IconButton(
                        icon: Icon(
                          Icons.replay,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          if (_isPlaying) {
                            await _audioPlayer.stop();
                            await _audioPlayer.play(widget.song.beatUrl);
                          }
                        }),
                    IconButton(
                        icon: Icon(
                          Icons.keyboard_voice,
                          color: Colors.white,
                        ),
                        onPressed: () {}),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.bluetooth_disabled,
                      color: Colors.blue,
                    ),
                    Text(
                      "No device",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ])));
  }

  /// Assumes the given path is a text-file-asset.
  Future<String> getTextFromFile(String path) async {
    var response = await http.get(path);
    return utf8.decode(response.bodyBytes);
  }
}
