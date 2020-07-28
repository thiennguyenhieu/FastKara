import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'pages/main_page.dart';
import 'package:fast_kara/ui/material/ColorDefine.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Color splashTextHighlight = const Color.fromRGBO(108, 94, 76, 1.0);
  Color textColor = const Color.fromRGBO(92, 92, 92, 1.0);
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => MainPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColor.backgroundColor,
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
                        baseColor: splashTextHighlight,
                        highlightColor: CommonColor.textBaseColor),
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
                            color: textColor, fontWeight: FontWeight.bold),
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
                    color: CommonColor.textBaseColor,
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
