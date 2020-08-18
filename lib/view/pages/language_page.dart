import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fast_kara/static/const_color.dart';
import 'package:fast_kara/package/localization/app_translations.dart';
import 'package:fast_kara/package/localization/application.dart';

class LanguagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.colorAppBackground,
      navigationBar: CupertinoNavigationBar(
        heroTag: 'languagepage',
        transitionBetweenRoutes: false,
        backgroundColor: AppColors.colorAppBackground,
        leading: Row(
          children: <Widget>[
            CupertinoNavigationBarBackButton(
              color: AppColors.colorAppText,
              onPressed: () => {Navigator.of(context).pop()},
            ),
            Text(
              AppTranslations.of(context).text("user_tab_title"),
              style: TextStyle(color: AppColors.colorAppText),
            ),
          ],
        ),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
          ),
          _LanguageItemList(),
        ],
      ),
    );
  }
}

class _LanguageItemList extends StatefulWidget {
  @override
  _LanguageItemListState createState() => _LanguageItemListState();
}

class _LanguageItemListState extends State<_LanguageItemList> {
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
    _loadLanguage();
    application.onLocaleChanged = onLocaleChange;
  }

  void onLocaleChange(Locale locale) async {
    AppTranslations.load(locale);
  }

  @override
  Widget build(BuildContext context) {
    final languages = [
      "English",
      "Tiếng Việt",
    ];

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: languages.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          margin: EdgeInsets.only(bottom: 1.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          color: AppColors.colorListItemCard,
          child: RadioListTile(
            activeColor: AppColors.colorAppText,
            title: Text(
              languages[index],
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.left,
            ),
            value: languagesList[index],
            groupValue: _language,
            onChanged: (String value) {
              _language = value;
              setState(() {
                onLocaleChange(Locale(languagesMap[value]));
              });
              _saveLanguage(value);
            },
          ),
        );
      },
    );
  }

  void _saveLanguage(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('language', value);
  }

  void _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    _language = prefs.getString('language') ?? languagesList[1];

    setState(() => {});
  }
}
