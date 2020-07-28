import 'package:flutter/material.dart';
import 'ui/pages/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FastKara',
      home: SplashScreen(),
    );
  }
}
