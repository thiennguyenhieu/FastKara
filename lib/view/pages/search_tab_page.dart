import 'package:flutter/material.dart';

import 'package:fast_kara/static/const_color.dart';

class SearchTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColor.colorBackground,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.youtube_searched_for,
                size: 100.0,
                color: Colors.white,
              ),
              Text(
                "Search Tab",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
