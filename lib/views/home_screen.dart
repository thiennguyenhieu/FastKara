import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fast_kara/tabs/home_screen_tab.dart';
import 'package:fast_kara/tabs/favorite_tab.dart';
import 'package:fast_kara/tabs/user_info_tab.dart';
import 'package:fast_kara/tabs/search_tab.dart';
import 'package:fast_kara/custom_icons/user_info_icon_icons.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TabController(length: 4, vsync: this);
    _controller.addListener(_trackSeletedTab);
  }

  void _trackSeletedTab() {
    print("_tabController index: ${_controller.index}");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color appBarColor = const Color.fromRGBO(33, 38, 43, 1.0);
    Color backgroundColor = const Color.fromRGBO(31, 31, 31, 1.0);
    Color appBarTitleColor = const Color.fromRGBO(255, 218, 159, 1.0);
    
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'FastKara',
          style: TextStyle(color: appBarTitleColor),
        ),
        backgroundColor: backgroundColor,
      ),
      body: TabBarView(
        children: <Widget>[
          HomeScreenTab(),
          SearchTab(),
          FavoriteTab(),
          UserInfoTab(),
        ],
        controller: _controller,
      ),
      bottomNavigationBar: Material(
          color: appBarColor,
          child: TabBar(
            labelColor: appBarTitleColor,
            unselectedLabelColor: Colors.white,
            indicatorColor: Colors.transparent,
            tabs: <Tab>[
              Tab(
                icon: Icon(Icons.home),
               ),
              Tab(
                icon: Icon(Icons.search),
              ),
              Tab(
                icon: Icon(Icons.favorite),
              ),
              Tab(
                icon: Icon(UserInfoIcons.user),
              ),
            ],
            controller: _controller,
          )
      ),
    );
  }
}
