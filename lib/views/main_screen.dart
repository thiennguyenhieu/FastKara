import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fast_kara/views/home_screen_tab.dart';
import 'package:fast_kara/views/favorite_tab.dart';
import 'package:fast_kara/views/user_info_tab.dart';
import 'package:fast_kara/views/search_tab.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen>
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

    final List<Tab> tabList= <Tab>[      
      Tab( /* Home Tab */
        icon: Icon(Icons.home),
      ),
      Tab( /* Search Tab */
        icon: Icon(Icons.search),
      ),
      Tab( /* Favorite Tab */
        icon: Icon(Icons.favorite),
      ),
      Tab( /* UserInfo Tab */
        icon: Icon(Icons.account_circle),
      ),
    ];
    
    return SafeArea(
      child: Scaffold(        
      backgroundColor: backgroundColor,
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
            tabs: tabList,
            controller: _controller,
          )
      ),
    ),
   );
  }
}
