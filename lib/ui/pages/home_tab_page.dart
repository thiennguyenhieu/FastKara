import 'dart:async';

import 'package:fast_kara/ui/pages/play_song_page.dart';
import 'package:flutter/material.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';

import '../../static/const_color.dart';
import '../../api/rest_api.dart';
import '../../model/song_model.dart';
import '../widgets/list_item.dart';
import '../widgets/custom_route.dart';
import 'play_song_page.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  Future<List<SongModel>> _songBook = RestAPI.fetchSongBook();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.black,
          title: const Text('Popular Songs',
              style: TextStyle(color: CommonColor.colorTextBase)),
        ),
        backgroundColor: Colors.black,
        body: Container(
          child: FutureBuilder(
            future: _songBook,
            builder: (BuildContext context, AsyncSnapshot listSong) {
              if (listSong.data == null) {
                return Container(
                  child: Center(
                    child: Loading(indicator: BallPulseIndicator(), size: 50.0),
                  ),
                );
              } else {
                return ListView.builder(
                    itemCount: listSong.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      SongModel song = listSong.data[index];
                      return ListItem(
                          imageUrl: listSong.data[index].imgUrl,
                          title: listSong.data[index].title,
                          subtitle: listSong.data[index].singer,
                          onItemTab: () {
                            _onItemTab(song);
                          },
                          onMoreBtnPressed: _onMoreBtnPressed);
                    });
              }
            },
          ),
        ));
  }

  void _onItemTab(SongModel song) {
    _navigateToSubPage(context, song);
  }

  Future _navigateToSubPage(context, SongModel song) async {
    Navigator.push(
        context,
        CustomRoute(
            previousPage: this.widget,
            builder: (context) => PlaySongPage(song)));
  }

  void _onMoreBtnPressed() {}
}
