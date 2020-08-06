import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fast_kara/view/screens/splash_screen.dart';
import 'package:fast_kara/bloc/bloc_provider.dart';
import 'package:fast_kara/bloc/app_manager_bloc.dart';

void main() {
  final appBloc = AppManagerBloc();
  runApp(MyApp(appBloc));
}

class MyApp extends StatelessWidget {
  final AppManagerBloc bloc;

  MyApp(this.bloc);

  @override
  Widget build(BuildContext context) {
    // This app is designed only to work vertically, so we limit
    // orientations to portrait up and down.
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return BlocProvider(
      bloc: bloc,
      child: CupertinoApp(
        //  app is slow when it's in checked mode. In checked mode, Flutter enables a large number of
        // expensive diagnostics to aid in development,
        // and so performance in checked mode is not representative of what will happen in release mode.
        debugShowCheckedModeBanner: false,
        title: 'FastKara',
        home: SplashScreen(),
      ),
    );
  }
}
