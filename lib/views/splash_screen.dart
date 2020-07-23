import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Color backgroundColor = const Color.fromRGBO(31, 31, 31, 1.0);
  Color splashTextBaseColor = const Color.fromRGBO(255, 218, 159, 1.0);
  Color splashTextHighlight = const Color.fromRGBO(108, 94, 76, 1.0);
  Color textColor = const Color.fromRGBO(92, 92, 92, 1.0);

  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen())));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
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
                        style: TextStyle(
                            fontSize: 60.0,
                            fontFamily: 'Bebas'
                        ),
                      ),
                      baseColor: splashTextHighlight,
                      highlightColor: splashTextBaseColor
                  ),
                )
              ),
            ),
            new Positioned(
                child: new Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 100),
                    child: Text(
                      'from',
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                )
            ),
            new Positioned(
                child: new Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 80),
                    child: Text(
                      'FASTAPP STUDIO',
                      style: TextStyle(
                        color: splashTextBaseColor,
                        fontFamily: 'Fialla',
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
