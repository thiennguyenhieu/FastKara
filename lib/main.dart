import 'package:fast_kara/HomeScreen.dart';
import 'package:fast_kara/Splash_Screen.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

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
