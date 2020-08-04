import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fast_kara/view/screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This app is designed only to work vertically, so we limit
    // orientations to portrait up and down.
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return CupertinoApp(
      debugShowCheckedModeBanner: false 
      /*  app is slow when it's in checked mode. In checked mode, Flutter enables a large number of
      expensive diagnostics to aid in development,
      and so performance in checked mode is not representative of what will happen in release mode. */,
      title: 'FastKara',
      home: SplashScreen(),
    );
  }
}
