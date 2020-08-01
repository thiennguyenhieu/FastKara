import 'package:fast_kara/model/song_model.dart';
import 'package:flutter/material.dart';

import '../../static/const_color.dart';

class PlaySongPage extends StatefulWidget {
  final SongModel song;
  const PlaySongPage(this.song);

  @override
  _PlaySongPageState createState() => _PlaySongPageState();
}

class _PlaySongPageState extends State<PlaySongPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          iconTheme: IconThemeData(color: CommonColor.colorTextBase),
          title: Text(
            "FastKara",
            style: TextStyle(
              color: CommonColor.colorTextBase,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
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
                image: new ExactAssetImage('assets/images/playsong_image.jpg'),
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
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey[600]),
              value: 5,
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
                      Icons.play_circle_filled,
                      color: Colors.white,
                    ),
                    onPressed: () {}),
                IconButton(
                    icon: Icon(
                      Icons.replay,
                      color: Colors.white,
                    ),
                    onPressed: () {}),
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
        ]));
  }
}
