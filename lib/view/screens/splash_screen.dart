import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:fast_kara/static/const_color.dart';
import 'package:fast_kara/bloc/bloc_provider.dart';
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
        () => Navigator.of(context).pushReplacement(CupertinoPageRoute(
            builder: (BuildContext context) => LogInScreen())));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).songBookBloc;
    bloc.fetchSongBook();
    return Scaffold(
      backgroundColor: AppColors.colorAppBackground,
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
                        baseColor: AppColors.colorAppText,
                        highlightColor: AppColors.colorAppSplashText),
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
                            color: Colors.grey, fontWeight: FontWeight.bold),
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
                    color: AppColors.colorAppText,
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
