import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fast_kara/bloc/bloc_provider.dart';
import 'package:fast_kara/static/const_color.dart';
import 'package:fast_kara/model/song_model.dart';
import 'package:fast_kara/view/widgets/list_item.dart';
import 'package:fast_kara/view/pages/play_song_page.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          heroTag: 'hometabpage',
          transitionBetweenRoutes: false,
          middle: Text('Popular Songs',
              style:
                  TextStyle(color: CommonColor.colorTextBase, fontSize: 25.0)),
          backgroundColor: Colors.black,
        ),
        child: Scaffold(
            appBar: null,
            backgroundColor: Colors.black,
            body: _SongBookList()));
  }
}

class _SongBookList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).songBookBloc;
    bloc.fetchSongBook();
    final navigateContext = context;

    return Container(
        child: StreamBuilder<List<SongModel>>(
            initialData: [],
            stream: bloc.updateSongBook,
            builder: (context, snapshot) {
              if (snapshot.data.length > 0) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    SongModel song = snapshot.data[index];
                    return ListItem(
                      imageUrl: song.imgUrl,
                      title: song.title,
                      subtitle: song.singer,
                      onItemTab: () {
                        _navigateToSubPage(navigateContext, song);
                      },
                      onMoreBtnPressed: _onMoreBtnPressed,
                    );
                  },
                );
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 5,
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      CommonColor.colorTextBase),
                ));
              }
            }));
  }

  Future _navigateToSubPage(context, SongModel song) async {
    Navigator.of(context, rootNavigator: true)
        .push(CupertinoPageRoute(builder: (context) => PlaySongPage(song)));
  }

  void _onMoreBtnPressed() {}
}
