import 'package:fast_kara/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 2000), () {} );

    return true;
  }

  void _navigateToHome(){
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => HomeScreen()
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Opacity(
                opacity: 0.5,
                child: Image.asset('assets/Fast_Kara_Splash.jpg')
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _mockCheckForSession().then(
        (status) {

          if(status) {
            _navigateToHome();
          }

        }
    );
  }
}
