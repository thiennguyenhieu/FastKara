import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';

import 'package:fast_kara/static/const_color.dart';
import 'package:fast_kara/api/rest_api.dart';
import 'package:fast_kara/model/song_model.dart';
import 'package:fast_kara/view/widgets/list_item.dart';
import 'package:fast_kara/view/widgets/custom_route.dart';
import 'package:fast_kara/view/pages/play_song_page.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<SongModel> _songBook = SongSingleton.instance.getSongList();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Popular Songs',
              style:
                  TextStyle(color: CommonColor.colorTextBase, fontSize: 25.0)),
          backgroundColor: Colors.black,
        ),
        child: Scaffold(
            appBar: null,
            backgroundColor: Colors.black,
            body: Container(
              child: ListView.builder(
                itemCount: _songBook.length,
                itemBuilder: (BuildContext context, int index) {
                  SongModel song = _songBook[index];
                  return ListItem(
                    imageUrl: song.imgUrl,
                    title: song.title,
                    subtitle: song.singer,
                    onItemTab: () {
                      _onItemTab(song);
                    },
                    onMoreBtnPressed: _onMoreBtnPressed,
                  );
                },
              ),
            )));
  }

  void _onItemTab(SongModel song) {
    _navigateToSubPage(context, song);
  }

  Future _navigateToSubPage(context, SongModel song) async {
    Navigator.of(context, rootNavigator: true).push(
        CupertinoPageRoute(builder: (context) => PlaySongPage(song)));
  }

  void _onMoreBtnPressed() {}
}
