import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fast_kara/static/const_color.dart';

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
              'You',
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
  Language _language = Language.English;

  @override
  Widget build(BuildContext context) {
    final languages = [
      'English',
      'Vietnamese',
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
              setState(() {
                _language = value;
              });
            },
          ),
        );
      },
    );
  }
}
