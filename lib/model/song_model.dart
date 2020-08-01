import 'package:flutter/cupertino.dart';

class SongModel {
  final int songId;
  final String title;
  final String singer;
  final String imgUrl;
  final String beatUrl;
  final String lyrics;

  SongModel(this.songId, this.title, this.singer, this.imgUrl, this.beatUrl,
      this.lyrics);
}
