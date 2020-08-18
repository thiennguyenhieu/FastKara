import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fast_kara/view/screens/splash_screen.dart';
import 'package:fast_kara/bloc/bloc_provider.dart';
import 'package:fast_kara/bloc/app_manager_bloc.dart';
import 'package:fast_kara/package/localization/app_translations_delegate.dart';
import 'package:fast_kara/package/localization/application.dart';

Future<Null> main() async {
  final appBloc = AppManagerBloc();
  runApp(FastKaraApp(appBloc));
}

class FastKaraApp extends StatefulWidget {
  final AppManagerBloc bloc;
  FastKaraApp(this.bloc);

  @override
  _FastKaraAppState createState() => _FastKaraAppState();
}

class _FastKaraAppState extends State<FastKaraApp> {
  AppTranslationsDelegate _newLocaleDelegate;

  static final List<String> languagesList = application.supportedLanguages;
  static final List<String> languageCodesList =
      application.supportedLanguagesCodes;

  final Map<dynamic, dynamic> languagesMap = {
    languagesList[0]: languageCodesList[0],
    languagesList[1]: languageCodesList[1],
  };

  String _language = "";

  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    _loadLanguage();
    application.onLocaleChanged = onLocaleChange;
  }

  @override
  Widget build(BuildContext context) {
    // This app is designed only to work vertically, so we limit
    // orientations to portrait up and down.
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return BlocProvider(
      bloc: widget.bloc,
      child: CupertinoApp(
        // app is slow when it's in checked mode. In checked mode, Flutter enables a large number of
        // expensive diagnostics to aid in development,
        // and so performance in checked mode is not representative of what will happen in release mode.
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          _newLocaleDelegate,
          //provides localised strings
          GlobalMaterialLocalizations.delegate,
          //provides RTL support
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''), // English
          const Locale('vi', ''), // Vietnamese
        ],
        home: SplashScreen(),
      ),
    );
  }

  void onLocaleChange(Locale locale) {
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
  }

  void _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    _language = prefs.getString('language') ?? languagesList[1];

    setState(() => {onLocaleChange(Locale(languagesMap[_language]))});
  }
}
