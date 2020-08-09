import 'package:fast_kara/static/const_color.dart';
import 'package:fast_kara/view/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SearchTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchWidgetState();
  }
}

class SearchWidgetState extends State<SearchTab>
    with SingleTickerProviderStateMixin {
  TextEditingController _searchTextController = TextEditingController();
  FocusNode _searchFocusNode = FocusNode();
  Animation _animation;
  AnimationController _animationController;
  String _searchTextInProgress;

  var _defaultrecent = [
    'Sau tất cả',
    'Ghen',
    'Niềm tin chiến thắng',
    'Gọi giấc mơ về',
    'Màu nước mắt'
  ];

  var isItemSelected = true;
  var itemSelectedText = '';

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
    _searchFocusNode.unfocus();
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
    return (isItemSelected)
        ? CupertinoPageScaffold(
            child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    CupertinoSliverNavigationBar(
                      heroTag: 'searchtabpage',
                      transitionBetweenRoutes: false,
                      largeTitle: Text(
                        'Search',
                        style: TextStyle(color: AppColors.colorAppText),
                      ),
                      backgroundColor: Colors.black,
                    ),
                  ];
                },
                body: Scaffold(
                  appBar: CupertinoNavigationBar(
                    heroTag: 'searchtabpage',
                    transitionBetweenRoutes: false,
                    padding: EdgeInsetsDirectional.only(bottom: 10),
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
                  body: Scaffold(
                    backgroundColor: Colors.black,
                    appBar: CupertinoNavigationBar(
                        heroTag: 'searchtabpage',
                        transitionBetweenRoutes: false,
                        backgroundColor: Colors.black,
                        leading: Text('Recent',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold))),
                    body: ListView.builder(
                      itemCount: _defaultrecent.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: new Text(
                            _defaultrecent[index],
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            onTapItem(_defaultrecent[index]);
                          },
                        );
                      },
                    ),
                  ),
                )))
        : CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              heroTag: 'searchtabpage',
              transitionBetweenRoutes: false,
              backgroundColor: Colors.black,
              leading: CupertinoNavigationBarBackButton(
                  color: AppColors.colorAppText,
                  onPressed: () => onTapItem(itemSelectedText)),
              middle: Text(
                """Search for "$itemSelectedText" """,
                style: TextStyle(color: AppColors.colorAppText, fontSize: 20.0),
              ),
            ),
            child: Scaffold(
              appBar: null,
              backgroundColor: Colors.black,
              body: ListView.builder(
                itemCount: _defaultrecent.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: new Text(
                      '$itemSelectedText $index',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          );
  }

  void onTapItem(String value) {
    this.setState(() {
      if (!isItemSelected) {
        itemSelectedText = '';
      } else {
        itemSelectedText = value;
      }
      isItemSelected = !isItemSelected;
    });
  }
}
