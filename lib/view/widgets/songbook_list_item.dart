import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:fast_kara/static/const_color.dart';
import 'package:fast_kara/model/song_model.dart';
import 'package:fast_kara/view/widgets/more_detail_list_item.dart';
import 'package:fast_kara/view/pages/play_song_page.dart';
import 'package:fast_kara/package/localization/app_translations.dart';

class SongBookListItem extends StatelessWidget {
  SongBookListItem({this.song, this.context});

  final SongModel song;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Card(
        color: AppColors.colorListItemCard,
        margin: EdgeInsets.all(4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 4.0, top: 0.0, bottom: 0.0),
          leading: Image.network(
            song.imgUrl,
            fit: BoxFit.fill,
          ),
          title: Text(
            song.title,
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.left,
          ),
          subtitle: Text(
            song.singer,
            style: TextStyle(color: Colors.white60),
            textAlign: TextAlign.left,
          ),
          trailing: Wrap(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.more_horiz),
                color: Colors.white60,
                onPressed: () => _showModalSheet(context, song),
              ),
            ],
          ),
          onTap: () => _navigateToSubPage(context, song),
        ),
      ),
    );
  }

  Future _navigateToSubPage(context, SongModel song) async {
    Navigator.of(context, rootNavigator: true)
        .push(CupertinoPageRoute(builder: (context) => PlaySongPage(song)));
  }

  void _showModalSheet(BuildContext context, SongModel song) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 300,
            child: MoreDetailListItem(
              subtitle: song.singer,
              imageUrl: song.imgUrl,
              title: song.title,
              onDownloadButtonPress: () => _onPressDownload(context),
              onFavoriteButtonPress: () => _onPressFavorite(context),
            ),
          );
        });
  }

  void _onPressFavorite(context) {
    Fluttertoast.cancel();
    Navigator.of(context).pop();
    Fluttertoast.showToast(
        msg: AppTranslations.of(context).text("morepopup_added_like"),
        backgroundColor: Colors.white,
        textColor: Colors.black,
        toastLength: Toast.LENGTH_LONG);
  }

  void _onPressDownload(context) {
    Fluttertoast.cancel();
    Navigator.of(context).pop();
    Fluttertoast.showToast(
        msg: AppTranslations.of(context).text("morepopup_downloading"),
        backgroundColor: Colors.white,
        textColor: Colors.black,
        toastLength: Toast.LENGTH_LONG);
  }
}
