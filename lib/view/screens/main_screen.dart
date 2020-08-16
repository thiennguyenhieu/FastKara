import 'package:fast_kara/bloc/bloc_provider.dart';
import 'package:fast_kara/bloc/search_manager_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fast_kara/static/const_color.dart';
import 'package:fast_kara/view/pages/home_tab_page.dart';
import 'package:fast_kara/view/pages/user_tab_page.dart';
import 'package:fast_kara/view/pages/search_tab_page.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final searchTabBloc = BlocProvider.of(context).searchManagerBloc;
    return _MainScreen(searchTabBloc);
  }
}

class _MainScreen extends StatefulWidget {
  final SearchManagerBloc bloc;

  const _MainScreen(this.bloc);
  @override
  _MainScreenState createState() => _MainScreenState(bloc);
}

class _MainScreenState extends State<_MainScreen> {
  List<Widget> _pages;
  Widget _pageHome;
  Widget _pageSearch;
  Widget _pageUserAccount;
  final SearchManagerBloc searchTabBloc;
  _MainScreenState(this.searchTabBloc);

  @override
  void initState() {
    super.initState();
    _pageHome = HomeTab();
    _pageSearch = SearchTab(searchTabBloc);
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
            onTap: (index) {
              if (index == 1) {
                searchTabBloc.requestFocus();
              }
            },
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
