import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

enum Language { English, Vietnamese }

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

  Language _language = Language.English;

  @override
  void initState() {
    super.initState();
    application.onLocaleChanged = onLocaleChange;
  }

  void onLocaleChange(Locale locale) async {
    AppTranslations.load(locale);
  }

  @override
  Widget build(BuildContext context) {
    final languages = [
      AppTranslations.of(context).text("language_english"),
      AppTranslations.of(context).text("language_vietnamese"),
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
            value: Language.values[index],
            groupValue: _language,
            onChanged: (Language value) {
              _language = value;
              _selectLanguage(value);
            },
          ),
        );
      },
    );
  }

  void _selectLanguage(Language language) {
    String strLanguage;
    if (language == Language.English) {
      strLanguage = "English";
    } else {
      strLanguage = "Vietnamese";
    }

    setState(() {
      onLocaleChange(Locale(languagesMap[strLanguage]));
    });
  }
}
