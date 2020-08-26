import 'package:fast_kara/bloc/song_book_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fast_kara/bloc/bloc_provider.dart';
import 'package:fast_kara/static/const_color.dart';
import 'package:fast_kara/model/song_model.dart';
import 'package:fast_kara/view/widgets/songbook_list_item.dart';
import 'package:fast_kara/package/localization/app_translations.dart';

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
              AppTranslations.of(context).text("home_tab_title"),
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
      child: _SongBook(bloc)
    );
  }
}

class _SongBook extends StatefulWidget {
  final SongBookBloc bloc;
  _SongBook(this.bloc);
  @override
  __SongBookState createState() => __SongBookState();
}

class __SongBookState extends State<_SongBook> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        widget.bloc.fetchSongBook();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<SongModel>>(
      initialData: [],
      stream: widget.bloc.getSongBookByView,
      builder: (context, snapshot) {
        if (snapshot.data.length > 0) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: snapshot.data.length + 1,
            controller: _scrollController,
            itemBuilder: (context, index) {
              if(index == snapshot.data.length){
                return CupertinoActivityIndicator(radius: 20);
              }
              else {
                SongModel song = snapshot.data[index];
                return SongBookListItem(
                  song: song,
                  context: context,
                );
              }
            },
          );
        } else {
          return Center(
              child: CircularProgressIndicator(
                strokeWidth: 5,
                valueColor: new AlwaysStoppedAnimation<Color>(AppColors.colorAppText),
              ));
        }
      },
    );
  }
}

