import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text('FastKara'),
      ),
      body: Center(
        child: Text('Welcome to Fast Kara',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0
                ),
        ),
      ),
    ); //Scaffold
  }
}