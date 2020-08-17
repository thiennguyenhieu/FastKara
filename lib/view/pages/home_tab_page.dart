import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fast_kara/bloc/bloc_provider.dart';
import 'package:fast_kara/static/const_color.dart';
import 'package:fast_kara/model/song_model.dart';
import 'package:fast_kara/view/widgets/songbook_list_item.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        heroTag: 'hometabpage',
        transitionBetweenRoutes: false,
        backgroundColor: AppColors.colorAppBackground,
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
      ),
      backgroundColor: AppColors.colorAppBackground,
      child: _SongBookList(),
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
                  song: song,
                  context: context,
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
}
