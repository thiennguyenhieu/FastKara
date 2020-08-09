import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fast_kara/bloc/bloc_provider.dart';
import 'package:fast_kara/static/const_color.dart';
import 'package:fast_kara/model/song_model.dart';
import 'package:fast_kara/view/widgets/list_item.dart';
import 'package:fast_kara/view/pages/play_song_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          heroTag: 'hometabpage',
          transitionBetweenRoutes: false,
          middle: Text('Popular Songs',
              style: TextStyle(color: AppColors.colorAppText, fontSize: 25.0)),
          backgroundColor: AppColors.colorAppBackground,
        ),
        child: Scaffold(
            appBar: null,
            backgroundColor: AppColors.colorAppBackground,
            body: _SongBookList()));
  }
}

class _SongBookList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).songBookBloc;

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
                        _navigateToSubPage(context, song);
                      },
                      onMoreBtnPressed: (){
                        _onMoreBtnPressed(context, song);
                      },
                    );
                  },
                );
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 5,
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(AppColors.colorAppText),
                ));
              }
            }));
  }

  Future _navigateToSubPage(context, SongModel song) async {
    Navigator.of(context, rootNavigator: true)
        .push(CupertinoPageRoute(builder: (context) => PlaySongPage(song)));
  }

  void _onMoreBtnPressed(context, SongModel song) {
    showBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 200,
            color: Colors.grey[900],
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: (Image.network(song.imgUrl)),
                  title: Text(
                    song.title,
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    song.singer,
                    style: TextStyle(color: Colors.white60),
                  ),
                ),
                Divider(
                  color: Colors.white,
                  endIndent: 40,
                  indent: 40,
                ),
                ListTile(
                  leading: Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Add To Favorite",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: _onPressFavorite,
                ),
                ListTile(
                  leading: Icon(
                    Icons.file_download,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Download",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: _onPressDownload,
                )
              ],
            ),
          );
    });
  }

  void _onPressFavorite(){
    Fluttertoast.showToast(msg: "Added to Favorite", backgroundColor: Colors.white, textColor: Colors.black, toastLength: Toast.LENGTH_SHORT);
  }
  void _onPressDownload(){
    Fluttertoast.showToast(msg: "Downloading...", backgroundColor: Colors.white, textColor: Colors.black, toastLength: Toast.LENGTH_SHORT);
  }


}
