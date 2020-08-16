import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:fast_kara/bloc/bloc_provider.dart';
import 'package:fast_kara/static/const_color.dart';
import 'package:fast_kara/model/song_model.dart';
import 'package:fast_kara/view/widgets/songbook_list_item.dart';
import 'package:fast_kara/view/widgets/more_detail_list_item.dart';
import 'package:fast_kara/view/pages/play_song_page.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        heroTag: 'hometabpage',
        transitionBetweenRoutes: false,
        middle: Row(
          children: [
            Text(
              'Trending now',
              style: TextStyle(
                color: AppColors.colorAppText,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.colorAppBackground,
      ),
      child: _SongBookList(),
      backgroundColor: AppColors.colorAppBackground,
    );
  }
}

class _SongBookList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).songBookBloc;

    return Container(
      color: AppColors.colorAppBackground,
      child: StreamBuilder<List<SongModel>>(
        initialData: [],
        stream: bloc.updateSongBook,
        builder: (context, snapshot) {
          if (snapshot.data.length > 0) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                SongModel song = snapshot.data[index];
                return SongBookListItem(
                  imageUrl: song.imgUrl,
                  title: song.title,
                  subtitle: song.singer,
                  onItemTab: () {
                    _navigateToSubPage(context, song);
                  },
                  onMoreBtnPressed: () {
                    _showModalSheet(context, song);
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
        },
      ),
    );
  }

  Future _navigateToSubPage(context, SongModel song) async {
    Navigator.of(context, rootNavigator: true)
        .push(CupertinoPageRoute(builder: (context) => PlaySongPage(song)));
  }

  void _showModalSheet(BuildContext  context, SongModel song) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 300,
            child: MoreDetailListItem(
                 subtitle: song.singer,
                 imageUrl: song.imgUrl,
                 title: song.title,
                 onDownloadButtonPress: (){
                   _onPressDownload(context);
                 },
                 onFavoriteButtonPress: (){
                   _onPressFavorite(context);
                 },
            ),
          );
        }
    );
  }

  void _onPressFavorite(context) {
    Fluttertoast.cancel();
    Navigator.of(context).pop();
    Fluttertoast.showToast(
        msg: "Added to Favorite",
        backgroundColor: Colors.white,
        textColor: Colors.black,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _onPressDownload(context) {
    Fluttertoast.cancel();
    Navigator.of(context).pop();
    Fluttertoast.showToast(
        msg: "Downloading...",
        backgroundColor: Colors.white,
        textColor: Colors.black,
        toastLength: Toast.LENGTH_SHORT);
  }
}
