import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Color appBarColor = const Color.fromRGBO(33, 38, 43, 1.0);
    Color backgroundColor = const Color.fromRGBO(31, 31, 31, 1.0);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar (
        title: Text('FastKara'),
        backgroundColor: appBarColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              onPressed: () {
                /*...*/
              },
              child: Text(
                "Flat Button",
                style: TextStyle(fontSize: 20.0),
              ),
            )
          ],
          ),
        ),
      );
  }
}