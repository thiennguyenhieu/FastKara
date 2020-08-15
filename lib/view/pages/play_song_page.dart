import 'dart:convert' show utf8;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:fast_kara/extpackage/flutter_lyric/lyric_widget.dart';
import 'package:fast_kara/extpackage/flutter_lyric/lyric_controller.dart';
import 'package:fast_kara/extpackage/flutter_lyric/lyric_util.dart';
import 'package:fast_kara/extpackage/flutter_lyric/lyric.dart';

import 'package:fast_kara/bloc/bloc_provider.dart';
import 'package:fast_kara/bloc/play_song_bloc.dart';
import 'package:fast_kara/static/const_color.dart';
import 'package:fast_kara/model/song_model.dart';

class PlaySongPage extends StatelessWidget {
  final SongModel song;
  const PlaySongPage(this.song);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).playSongBloc;
    bloc.setBeatUrl(song.beatUrl);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        heroTag: 'playsongpage',
        transitionBetweenRoutes: false,
        leading: Row(
          children: <Widget>[
            CupertinoNavigationBarBackButton(
              color: AppColors.colorAppText,
              onPressed: () => _exitPage(context, bloc),
            ),
            Text(
              'Home',
              style: TextStyle(color: AppColors.colorAppText),
            ),
          ],
        ),
        backgroundColor: AppColors.colorAppBackground,
        border: Border(bottom: BorderSide(color: Colors.transparent)),
      ),
      child: Scaffold(
        appBar: null,
        backgroundColor: AppColors.colorAppBackground,
        body: Column(
          children: <Widget>[
            _LyricsPlayer(song.lyrics, bloc),
            _SongInfo(song.title, song.singer),
            _PropressBar(bloc),
            _ButtonBar(bloc),
            _BluetoothDevice(),
          ],
        ),
      ),
    );
  }

  void _exitPage(BuildContext context, PlaySongBloc bloc) {
    bloc.releaseAudio();
    Navigator.of(context).pop();
  }
}

class _LyricsPlayer extends StatefulWidget {
  final PlaySongBloc bloc;
  final String lyricsUrl;
  const _LyricsPlayer(this.lyricsUrl, this.bloc);

  @override
  _LyricsPlayerState createState() => _LyricsPlayerState();
}

class _LyricsPlayerState extends State<_LyricsPlayer>
    with TickerProviderStateMixin {
  LyricController _controller;
  List<Lyric> _lyrics = [];

  @override
  void initState() {
    _controller = LyricController(vsync: this);
    widget.bloc.setLyricsController(_controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, top: 0.0, right: 10.0),
      height: MediaQuery.of(context).size.height / 2,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.colorAppChildComponent,
      ),
      child: FutureBuilder(
        future: _getTextFromFile(widget.lyricsUrl),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
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
              enableDrag: false,
              controller: _controller,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 5,
                valueColor:
                    new AlwaysStoppedAnimation<Color>(AppColors.colorAppText),
              ),
            );
          }
        },
      ),
    );
  }

  Future<String> _getTextFromFile(String path) async {
    var response = await http.get(path);
    return utf8.decode(response.bodyBytes);
  }
}

class _SongInfo extends StatelessWidget {
  final String title;
  final String singer;
  const _SongInfo(this.title, this.singer);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 40.0, left: 10.0, right: 10.0),
          alignment: Alignment.topLeft,
          child: Text(
            title,
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
            singer,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white70,
            ),
          ),
        ),
      ],
    );
  }
}

class _PropressBar extends StatelessWidget {
  final PlaySongBloc bloc;
  const _PropressBar(this.bloc);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
          alignment: Alignment.topLeft,
          child: StreamBuilder<double>(
              initialData: 0.0,
              stream: bloc.audioProgress,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return LinearProgressIndicator(
                    backgroundColor: Colors.grey[800],
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                    value: snapshot.data,
                  );
                } else {
                  return Container();
                }
              }),
        ),
        Container(
          margin: EdgeInsets.only(top: 5.0, right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Container(
                margin: EdgeInsets.only(left: 10.0),
                child: StreamBuilder<Duration>(
                  initialData: Duration(seconds: 0),
                  stream: bloc.audioPosition,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data.toString().substring(2, 7),
                        style: TextStyle(color: Colors.white),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
              new Container(
                child: StreamBuilder<Duration>(
                  initialData: Duration(seconds: 0),
                  stream: bloc.audioDuration,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data.toString().substring(2, 7),
                        style: TextStyle(color: Colors.white),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ButtonBar extends StatelessWidget {
  final PlaySongBloc bloc;
  const _ButtonBar(this.bloc);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
      alignment: Alignment.topLeft,
      child: StreamBuilder<bool>(
        initialData: false,
        stream: bloc.audioPlaying,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    Icons.file_download,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  iconSize: 60,
                  icon: Icon(
                    snapshot.data
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_filled,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    if (snapshot.data) {
                      await bloc.pauseAudio();
                    } else {
                      await bloc.playAudio();
                    }
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.replay,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await bloc.stopAudio();
                    await bloc.playAudio();
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.keyboard_voice,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class _BluetoothDevice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
