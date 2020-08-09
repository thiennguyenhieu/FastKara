import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fast_kara/model/user_model.dart';
import 'package:fast_kara/view/screens/login_screen.dart';

class UserAccountTab extends StatefulWidget {
  @override
  _UserAccountTab createState() => _UserAccountTab();
}

class _UserAccountTab extends State<UserAccountTab> {
  var userModel = UserModel();

  void _logOut() {
    Navigator.of(context, rootNavigator: true).pushReplacement(
        CupertinoPageRoute(builder: (BuildContext context) => LogInScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(padding: const EdgeInsets.all(50)),
              Icon(
                Icons.account_circle,
                size: 80.0,
                color: Colors.white,
              ),
              Text(
                userModel.getUserName != null ? userModel.getUserName : '0',
                style: TextStyle(color: Colors.orange, fontSize: 20),
              ),
              RaisedButton(
                elevation: 5.0,
                onPressed: () {
                  _logOut();
                },
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.orange[200],
                child: Text(
                  'Log out',
                  style: TextStyle(
                    color: Color(0xFF150B03),
                    letterSpacing: 1.5,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
