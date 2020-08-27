import 'package:fast_kara/bloc/bloc_provider.dart';
import 'package:fast_kara/bloc/sign_in_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fast_kara/static/const_color.dart';
import 'package:fast_kara/static/const_textstyle.dart';
import 'package:fast_kara/view/pages/login_page.dart';
import 'package:fast_kara/view/pages/language_page.dart';
import 'package:fast_kara/package/localization/app_translations.dart';

class UserAccountTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).signInBloc;
    return CupertinoPageScaffold(
      backgroundColor: AppColors.colorAppBackground,
      navigationBar: CupertinoNavigationBar(
        heroTag: 'usertabpage',
        transitionBetweenRoutes: false,
        backgroundColor: AppColors.colorAppBackground,
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.account_circle,
                color: AppColors.colorAppText,
                size: 60.0,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
              ),
              Text(
                AppTranslations.of(context).text("user_tab_title"),
                style: TextStyle(color: AppColors.colorAppText, fontSize: 30.0),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
          ),
          _UserItemList(),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
          ),
          _SettingItemList(
            bloc: bloc,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
          ),
          _SignInButton(
            bloc: bloc,
          ),
        ],
      ),
    );
  }
}

class _UserItemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final icons = [
      Icons.favorite,
      Icons.history,
      Icons.file_download,
    ];

    final titles = [
      AppTranslations.of(context).text("user_tab_likes"),
      AppTranslations.of(context).text("user_tab_history"),
      AppTranslations.of(context).text("user_tab_downloads"),
    ];

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: titles.length,
      itemBuilder: (context, index) {
        return Card(
          color: AppColors.colorListItemCard,
          margin: EdgeInsets.all(4),
          child: ListTile(
            leading: Icon(
              icons[index],
              color: Colors.grey,
            ),
            title: Text(
              titles[index],
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.left,
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey,
            ),
          ),
        );
      },
    );
  }
}

class _SettingItemList extends StatelessWidget {
  _SettingItemList({this.bloc});
  final SignInBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: AppColors.colorListItemCard,
          margin: EdgeInsets.all(4),
          child: ListTile(
            leading: Icon(
              Icons.language,
              color: Colors.grey,
            ),
            title: Text(
              AppTranslations.of(context).text("user_tab_language"),
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.left,
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey,
            ),
            onTap: () => {
              Navigator.of(context, rootNavigator: true).push(
                  CupertinoPageRoute(builder: (context) => LanguagePage()))
            },
          ),
        ),
        Card(
          color: AppColors.colorListItemCard,
          margin: EdgeInsets.all(4),
          child: ListTile(
            leading: Icon(
              Icons.signal_cellular_4_bar,
              color: Colors.grey,
            ),
            title: Text(
              AppTranslations.of(context).text("user_tab_cellular"),
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.left,
            ),
            trailing: CupertinoSwitch(
              value: false,
              onChanged: (bool value) {},
            ),
          ),
        ),
        Card(
          color: AppColors.colorListItemCard,
          margin: EdgeInsets.all(4),
          child: ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.grey,
            ),
            title: Text(
              AppTranslations.of(context).text("user_tab_signout"),
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.left,
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey,
            ),
            onTap: () => {
              _logOut(context),
            },
          ),
        ),
      ],
    );
  }

  void _logOut(context) async {
    bloc.logOutFacebook();
    bloc.logOutGoogle();
    Navigator.of(context, rootNavigator: true)
        .push(CupertinoPageRoute(builder: (context) => LogInPage()));
  }
}

class _SignInButton extends StatelessWidget {
  _SignInButton({this.bloc});
  final SignInBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      margin: EdgeInsets.all(10),
      child: RaisedButton(
        onPressed: () => {
          Navigator.of(context, rootNavigator: true)
              .push(CupertinoPageRoute(builder: (context) => LogInPage()))
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange[200], Colors.yellow[100]],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            constraints: BoxConstraints(
                maxWidth: double.maxFinite, minHeight: double.infinity),
            alignment: Alignment.center,
            child: Text(
              AppTranslations.of(context).text("user_tab_signin_btn"),
              textAlign: TextAlign.center,
              style: CommonTextStyle.signInButton,
            ),
          ),
        ),
      ),
    );
  }
}
