import 'package:flutter/material.dart';
import 'package:fast_kara/custom_icons/user_info_icon_icons.dart';

class UserInfoTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color backgroundColor = const Color.fromRGBO(31, 31, 31, 1.0);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                UserInfoIcons.user,
                size: 100.0,
                color: Colors.white,
              ),
              Text(
                "UserInfo Tab",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
