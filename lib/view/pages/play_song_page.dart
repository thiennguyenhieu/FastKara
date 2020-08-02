import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fast_kara/static/const_color.dart';
import 'package:fast_kara/model/song_model.dart';

class PlaySongPage extends StatefulWidget {
  final SongModel song;
  const PlaySongPage(this.song);
  @override
  _PlaySongPageState createState() => _PlaySongPageState();
}

class _PlaySongPageState extends State<PlaySongPage> {
  var testBeatURL = "https://luan.xyz/files/audio/ambient_c_motion.mp3";
  Duration _duration = new Duration(seconds:1);
  Duration _position = new Duration(seconds:1);
  AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;


  @override
  void initState() {
    super.initState();
    initPlayer();
  }


  void initPlayer() {
    _audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() => _duration = d);});

    _audioPlayer.onAudioPositionChanged.listen((Duration  p) => {
        setState(() => _position = p)});
  }

  void goBack(BuildContext context) {
    _audioPlayer.stop();
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: CupertinoNavigationBarBackButton(
            color: CommonColor.colorTextBase,
            onPressed: () => goBack(context)
            ,
          ),
          middle: Text(
            'FastKara',
            style: TextStyle(color: CommonColor.colorTextBase, fontSize: 20.0),
          ),
          backgroundColor: CommonColor.colorBackground,
          border: Border(bottom: BorderSide(color: Colors.transparent)),
        ),
        child: Scaffold(
            appBar: null,
            backgroundColor: CommonColor.colorBackground,
            body: Column(children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10.0, top: 0.0, right: 10.0),
                height: MediaQuery.of(context).size.height / 2,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(5),
                  image: new DecorationImage(
                    image:
                        new ExactAssetImage('assets/images/playsong_image.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    widget.song.lyrics,
                    style: TextStyle(fontSize: 30, color: Colors.white70),
                  ),
                ),
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
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(Colors.white),
                  value: _position.inSeconds.toDouble()/_duration.inSeconds.toDouble(),
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
                          _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          int status;
                          if(_isPlaying){
                            status = await _audioPlayer.pause();
                          }
                          else {
                            status = await _audioPlayer.play(testBeatURL);
                          }
                          if(status == 1){
                            setState(() {
                              _isPlaying = !_isPlaying;
                            });
                          }

                        }),
                    IconButton(
                        icon: Icon(
                          Icons.replay,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          int status = 0;
                          if(_isPlaying) {
                             status = await _audioPlayer.stop();
                             status = await _audioPlayer.play(testBeatURL);
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

}
