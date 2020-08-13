import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fast_kara/static/const_color.dart';

class UserAccountTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.colorAppBackground,
      navigationBar: CupertinoNavigationBar(
        heroTag: 'usertabpage',
        transitionBetweenRoutes: false,
        backgroundColor: AppColors.colorAppBackground,
        middle: Row(
          children: <Widget>[
            Icon(
              Icons.account_circle,
              color: AppColors.colorAppText,
              size: 60.0,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
            ),
            Text(
              'You',
              style: TextStyle(color: AppColors.colorAppText, fontSize: 30.0),
            ),
          ],
        ),
      ),
      child: Scaffold(
        appBar: null,
        backgroundColor: AppColors.colorAppBackground,
        body: _UserItemList(),
      ),
    );
  }
}

class _UserItemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: ListTile.divideTiles(
        color: Colors.grey,
        context: context,
        tiles: [
          ListTile(
            leading: Icon(
              Icons.favorite_border,
              color: Colors.white,
              size: 20.0,
            ),
            title: Text(
              'Likes',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            trailing: Wrap(
              children: <Widget>[
                Text(
                  '0',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.history,
              color: Colors.white,
              size: 20.0,
            ),
            title: Text(
              'History',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            trailing: Wrap(
              children: <Widget>[
                Text(
                  '0',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.file_download,
              color: Colors.white,
              size: 20.0,
            ),
            title: Text(
              'Downloads',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            trailing: Wrap(
              children: <Widget>[
                Text(
                  '0',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ],
            ),
          ),
        ],
      ).toList(),
    );
  }
}
