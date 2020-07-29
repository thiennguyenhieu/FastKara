import 'dart:async';
import 'dart:convert';

import 'package:fast_kara/ui/pages/play_song_page.dart';
import 'package:flutter/material.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:http/http.dart' as http;

import '../../model/song_model.dart';
import '../static/const_color.dart';
import '../static/const_http_path.dart';
import '../widgets/list_item.dart';
import '../widgets/custom_route.dart';
import 'play_song_page.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  Future<List<SongModel>> _getListSongs() async {
    List<SongModel> songList = [];

    var response = await http.get(HttpPath.pathSongBook);

    if (response.statusCode == 200) {
      var songsJsonData = json.decode(response.body);

      for (var songsInfo in songsJsonData) {
        SongModel song = SongModel(songsInfo["songid"], songsInfo["title"],
            songsInfo["singer"], songsInfo["imgurl"], songsInfo["beaturl"]);
        songList.add(song);
      }
      return songList;
    } else {
      //Todo: Show Error Code
      return songList;
    }
  }

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
            future: _getListSongs(),
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
                      return _listSong(listSong, index);
                    });
              }
            },
          ),
        ));
  }

  Widget _listSong(AsyncSnapshot snapshot, int index) {
    return ListItem(
        imageUrl: snapshot.data[index].imgUrl,
        title: snapshot.data[index].title,
        subtitle: snapshot.data[index].singer,
        onItemTab: _onItemTab,
        onMoreBtnPressed: _onMoreBtnPressed);
  }

  void _onItemTab() {
    _navigateToSubPage(context);
  }

  Future _navigateToSubPage(context) async {
    Navigator.push(
        context,
        CustomRoute(
            previousPage: this.widget, builder: (context) => PlaySongPage()));
  }

  void _onMoreBtnPressed() {}
}
