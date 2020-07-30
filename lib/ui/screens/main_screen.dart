import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../static/const_color.dart';
import '../pages/home_tab_page.dart';
import '../pages/favorite_tab_page.dart';
import '../pages/user_tab_page.dart';
import '../pages/search_tab_page.dart';

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

  int _currentIndex;
  Widget _currentPage;

  @override
  void initState() {
    super.initState();

    _pageHome = HomeTab();
    _pageSearch = SearchTab();
    _pageFavorite = FavoriteTab();
    _pageUserAccount = UserAccountTab();

    _pages = [_pageHome, _pageSearch, _pageFavorite, _pageUserAccount];

    _currentIndex = 0;
    _currentPage = _pageHome;
  }

  void _changeTab(int index) {
    setState(() {
      _currentIndex = index;
      _currentPage = _pages[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          appBar: null,
          body: _currentPage,
          bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              backgroundColor: CommonColor.colorNavigationBar,
              selectedItemColor: CommonColor.colorTextBase,
              unselectedItemColor: Colors.white,
              onTap: (index) => _changeTab(index),
              currentIndex: _currentIndex,
              items: [
                BottomNavigationBarItem(
                    title: Text(''), icon: Icon(Icons.home)),
                BottomNavigationBarItem(
                    title: Text(''), icon: Icon(Icons.search)),
                BottomNavigationBarItem(
                    title: Text(''), icon: Icon(Icons.favorite)),
                BottomNavigationBarItem(
                    title: Text(''), icon: Icon(Icons.account_circle))
              ]),
        ));
  }
}
