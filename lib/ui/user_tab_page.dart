import 'package:flutter/material.dart';

class UserAccountTab extends StatelessWidget {
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
                Icons.account_circle,
                size: 100.0,
                color: Colors.white,
              ),
              Text(
                "UserAccount Tab",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
