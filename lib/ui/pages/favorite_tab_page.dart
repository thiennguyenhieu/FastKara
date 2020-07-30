import 'package:flutter/material.dart';

import '../../static/const_color.dart';

class FavoriteTab extends StatelessWidget {
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
                Icons.favorite,
                size: 100.0,
                color: Colors.white,
              ),
              Text(
                "Favorite Tab",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
