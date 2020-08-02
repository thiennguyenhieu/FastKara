import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fast_kara/static/const_color.dart';
import 'package:fast_kara/view/pages/home_tab_page.dart';
import 'package:fast_kara/view/pages/favorite_tab_page.dart';
import 'package:fast_kara/view/pages/user_tab_page.dart';
import 'package:fast_kara/view/pages/search_tab_page.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> _pages;
  Widget _pageHome;
  Widget _pageSearch;
  Widget _pageFavorite;
  Widget _pageUserAccount;

  @override
  void initState() {
    super.initState();
    _pageHome = HomeTab();
    _pageSearch = SearchTab();
    _pageFavorite = FavoriteTab();
    _pageUserAccount = UserAccountTab();
    _pages = [_pageHome, _pageSearch, _pageFavorite, _pageUserAccount];
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            backgroundColor: CommonColor.colorNavigationBar ,
            activeColor: CommonColor.colorTextBase ,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text('Home')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), title: Text('Search')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), title: Text('Favorite')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle), title: Text('Info')),
            ],
          ),
              tabBuilder: (context, index) {
                CupertinoTabView returnValue;
                switch (index) {
                  case 0:
                    returnValue = CupertinoTabView(builder: (context) {
                      return CupertinoPageScaffold(child: _pages[index],);
                    });
                    break;
                  case 1:
                    returnValue = CupertinoTabView(builder: (context) {
                      return CupertinoPageScaffold(child: _pages[index],);
                    });
                    break;
                  case 2:
                    returnValue = CupertinoTabView(builder: (context) {
                      return CupertinoPageScaffold(child: _pages[index],);
                    });
                    break;
                  case 3:
                    returnValue = CupertinoTabView(builder: (context) {
                      return CupertinoPageScaffold(child: _pages[index],);
                    });
                    break;
                }
                return returnValue;
    },
        ));
  }
}

