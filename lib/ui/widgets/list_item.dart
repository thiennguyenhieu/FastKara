import 'package:flutter/material.dart';

import '../../static/const_color.dart';

class ListItem extends StatelessWidget {
  ListItem(
      {this.imageUrl,
      this.title,
      this.subtitle,
      this.onMoreBtnPressed,
      this.onItemTab});

  final String imageUrl;
  final String title;
  final String subtitle;
  final VoidCallback onMoreBtnPressed;
  final VoidCallback onItemTab;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 80,
        child: Card(
            color: CommonColor.colorBackground,
            margin: EdgeInsets.all(4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.only(left: 4.0),
              leading: Image.network(
                imageUrl,
                fit: BoxFit.fill,
              ),
              title: Text(
                title,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.left,
              ),
              subtitle: Text(
                subtitle,
                style: TextStyle(color: Colors.white60),
                textAlign: TextAlign.left,
              ),
              trailing: Wrap(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.more_horiz),
                    color: Colors.white60,
                    onPressed: onMoreBtnPressed,
                  ),
                ],
              ),
              onTap: onItemTab,
            )));
  }
}
