import 'package:flutter/material.dart';

import 'package:fast_kara/model/user_model.dart';
import 'package:fast_kara/static/const_color.dart';
import 'package:fast_kara/view/pages/user_detail_page.dart';

class UserAccountTab extends StatefulWidget {
  @override
  _UserAccountTab createState() => _UserAccountTab();
}

class _UserAccountTab extends State<UserAccountTab> {
  var userModel = UserModel.getInstance();

  void _viewDetails() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => UserDetailPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColor.colorBackground,
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
                  _viewDetails();
                },
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Color(0xFFFFBD4D),
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
