import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

import 'views/home_screen.dart';
import 'views/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Name Generator',
      home: SplashScreen(),
    );
  }
}
