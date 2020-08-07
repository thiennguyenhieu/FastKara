import 'package:fast_kara/api/rest_api.dart';
import 'package:fast_kara/model/song_model.dart';
import 'package:fast_kara/static/const_color.dart';
import 'package:fast_kara/view/widgets/custom_search_bar.dart';
import 'package:fast_kara/view/widgets/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';

class SearchTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchWidgetState();
  }
}

class SearchWidgetState extends State<SearchTab>
    with SingleTickerProviderStateMixin {
  Future<List<SongModel>> _songBook = RestAPI.fetchSongBook();
  TextEditingController _searchTextController = TextEditingController();
  FocusNode _searchFocusNode = FocusNode();
  Animation _animation;
  AnimationController _animationController;
  String _searchTextInProgress;

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
    _searchFocusNode.addListener(() {
      if (!_animationController.isAnimating) {
        _animationController.forward();
      }
    });

    _searchTextController.addListener(_performSearch);
  }

  _performSearch() {
    final text = _searchTextController.text;
    if (_songBook != null && text == _searchTextInProgress) {
      return;
    }

    if (text.isEmpty) {
      this.setState(() {
        _songBook = null;
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
    _searchFocusNode.unfocus();
    _animationController.reverse();
    this.setState(() {
      _songBook = null;
      _searchTextInProgress = null;
    });
  }

  _clearSearch() {
    _searchTextController.clear();
    this.setState(() {
      _songBook = null;
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
          backgroundColor: Colors.black,
          middle: Text(
            'Search',
            style: TextStyle(color: CommonColor.colorTextBase, fontSize: 25.0),
          ),
        ),
        child: Scaffold(
            appBar: CupertinoNavigationBar(
              backgroundColor: Colors.black,
              middle: CustomSearchBar(
                controller: _searchTextController,
                focusNode: _searchFocusNode,
                animation: _animation,
                onCancel: _cancelSearch,
                onClear: _clearSearch,
              ),
            ),
            backgroundColor: Colors.black,
            body: Container(
                child: FutureBuilder(
              future: _songBook,
              builder: (BuildContext context, AsyncSnapshot listSong) {
                if (listSong.data == null) {
                  return Container(
                    child: Center(
                      child:
                          Loading(indicator: BallPulseIndicator(), size: 50.0),
                    ),
                  );
                } else {
                  return ListView.builder(
                      itemCount: listSong.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListItem(
                            imageUrl: listSong.data[index].imgUrl,
                            title: listSong.data[index].title,
                            subtitle: listSong.data[index].singer,
                            onMoreBtnPressed: _onMoreBtnPressed);
                      });
                }
              },
            ))));
  }

  void _onMoreBtnPressed() {}
}
