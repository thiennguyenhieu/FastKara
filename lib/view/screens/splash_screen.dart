import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:fast_kara/static/const_color.dart';
import 'package:fast_kara/view/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LogInScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColor.colorBackground,
      body: Container(
        child: new Stack(
          children: <Widget>[
            new Positioned(
              child: new Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 80),
                    child: Shimmer.fromColors(
                        child: Text(
                          'FASTKARA',
                          style: TextStyle(fontSize: 60.0, fontFamily: 'Bebas'),
                        ),
                        baseColor: CommonColor.colorSplashBaseText,
                        highlightColor: CommonColor.colorTextBase),
                  )),
            ),
            new Positioned(
                child: new Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 100),
                      child: Text(
                        'from',
                        style: TextStyle(
                            color: CommonColor.colorSplashFooterText,
                            fontWeight: FontWeight.bold),
                      ),
                    ))),
            new Positioned(
                child: new Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 80),
                child: Text(
                  'FASTAPP STUDIO',
                  style: TextStyle(
                    color: CommonColor.colorSplashBaseText,
                    fontFamily: 'Fialla',
                    fontSize: 15.0,
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
