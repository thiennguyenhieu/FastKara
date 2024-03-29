import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fast_kara/static/const_color.dart';
import 'package:fast_kara/bloc/bloc_provider.dart';
import 'package:fast_kara/bloc/search_manager_bloc.dart';
import 'package:fast_kara/model/song_model.dart';
import 'package:fast_kara/view/widgets/custom_search_bar.dart';
import 'package:fast_kara/view/widgets/songbook_list_item.dart';
import 'package:fast_kara/package/localization/app_translations.dart';

class SearchTab extends StatefulWidget {
  final SearchManagerBloc bloc;

  const SearchTab(this.bloc);

  @override
  State<StatefulWidget> createState() => _SearchWidgetState(this.bloc);
}

class _SearchWidgetState extends State<SearchTab>
    with SingleTickerProviderStateMixin {
  TextEditingController _searchTextController = TextEditingController();
  Animation _animation;
  AnimationController _animationController;
  String _searchTextInProgress;

  final SearchManagerBloc bloc;
  _SearchWidgetState(this.bloc);

  @override
  initState() {
    super.initState();
    _animationController = new AnimationController(
      duration: new Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );

    bloc.getFocusNode().addListener(() {
      if (!_animationController.isAnimating) {
        _animationController.forward();
      }
    });

    _searchTextController.addListener(_performSearch);
  }

  _performSearch() {
    final text = _searchTextController.text;
    if (text == _searchTextInProgress) {
      return;
    }

    if (text.isEmpty) {
      this.setState(() {
        _searchTextInProgress = null;
      });
      return;
    }

    this.setState(() {
      _searchTextInProgress = text;
    });
  }

  _cancelSearch() {
    _searchTextController.clear();
    bloc.getFocusNode().unfocus();
    _animationController.reverse();

    this.setState(() {
      _searchTextInProgress = null;
    });
  }

  _clearSearch() {
    _searchTextController.clear();
    this.setState(() {
      _searchTextInProgress = null;
    });
  }

  @override
  dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          heroTag: 'searchtabpage',
          transitionBetweenRoutes: false,
          backgroundColor: AppColors.colorAppBackground,
          middle: CustomSearchBar(
            controller: _searchTextController,
            focusNode: bloc.getFocusNode(),
            animation: _animation,
            onCancel: _cancelSearch,
            onClear: _clearSearch,
          ),
        ),
        child: _SearchPageBody(
            this.bloc, _searchTextInProgress == null, _searchTextInProgress));
  }
}

class _SearchPageBody extends StatelessWidget {
  final SearchManagerBloc bloc;
  final _searchTextInProgress;
  final _isInSearch;
  _SearchPageBody(this.bloc, this._isInSearch, this._searchTextInProgress);

  @override
  Widget build(BuildContext context) {
    if (_isInSearch) {
      return Scaffold(
          appBar: CupertinoNavigationBar(
            padding: EdgeInsetsDirectional.only(top: 8.0, start: 8.0),
            heroTag: 'searchtabpage',
            transitionBetweenRoutes: false,
            backgroundColor: AppColors.colorAppBackground,
            middle: Row(
              children: [
                Text(
                  AppTranslations.of(context).text("search_tab_title"),
                  style: TextStyle(
                    color: AppColors.colorAppText,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: AppColors.colorAppBackground,
          body: _SongBookList());
    } else {
      return Scaffold(
          appBar: CupertinoNavigationBar(
            padding: EdgeInsetsDirectional.only(top: 8.0, start: 8.0),
            heroTag: 'searchtabpage',
            transitionBetweenRoutes: false,
            backgroundColor: AppColors.colorAppBackground,
            middle: Row(
              children: [
                Text(
                  AppTranslations.of(context).text("search_tab_search") +
                      """ "$_searchTextInProgress" """,
                  style: TextStyle(
                    color: AppColors.colorAppText,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: AppColors.colorAppBackground,
          body: _SongBookListInSearch(this._searchTextInProgress, this.bloc));
    }
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
        stream: bloc.getSongBookByView,
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

class _SongBookListInSearch extends StatelessWidget {
  final _searchTextInProgress;
  final SearchManagerBloc searchBloc;
  _SongBookListInSearch(this._searchTextInProgress, this.searchBloc);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).songBookBloc;

    searchBloc.searchProcess(bloc.getSongBook(), _searchTextInProgress);

    return Container(
      child: StreamBuilder<List<SongModel>>(
        initialData: [],
        stream: searchBloc.getSongBookInSearch,
        builder: (context, snapshot) {
          if (snapshot.data.length > 0) {
            return ListView.builder(
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
              ),
            );
          }
        },
      ),
    );
  }
}
