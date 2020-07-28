import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fast_kara/ui/material/ColorDefine.dart';
import 'package:fast_kara/ui/pages/home_tab_page.dart';
import 'package:fast_kara/ui/pages/favorite_tab_page.dart';
import 'package:fast_kara/ui/pages/user_tab_page.dart';
import 'package:fast_kara/ui/pages/search_tab_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
              backgroundColor: const Color.fromRGBO(33, 38, 43, 1.0),
              selectedItemColor: CommonColor.textBaseColor,
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
