import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fast_kara/static/const_color.dart';
import 'package:fast_kara/view/pages/home_tab_page.dart';
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
  Widget _pageUserAccount;

  @override
  void initState() {
    super.initState();
    _pageHome = HomeTab();
    _pageSearch = SearchTab();
    _pageUserAccount = UserAccountTab();
    _pages = [_pageHome, _pageSearch, _pageUserAccount];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            backgroundColor: AppColors.colorAppChildComponent,
            activeColor: AppColors.colorAppText,
            inactiveColor: Colors.white,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Container()),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), title: Container()),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle), title: Container()),
            ],
          ),
          tabBuilder: (context, index) {
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: _pages[index],
              );
            });
          },
        ));
  }
}
