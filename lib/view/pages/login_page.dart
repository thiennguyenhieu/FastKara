import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fast_kara/bloc/bloc_provider.dart';
import 'package:fast_kara/bloc/sign_in_bloc.dart';
import 'package:fast_kara/static/const_color.dart';
import 'package:fast_kara/static/const_textstyle.dart';
import 'package:fast_kara/view/screens/main_screen.dart';
import 'package:fast_kara/package/localization/app_translations.dart';

class LogInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).signInBloc;
    return CupertinoPageScaffold(
      backgroundColor: AppColors.colorAppBackground,
      navigationBar: CupertinoNavigationBar(
        heroTag: 'loginpage',
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
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            SignInHeader(),
            SignInEmailTextBox(),
            SignInPasswordTextBox(),
            SignInForgotPasswordButton(
              onPressed: _onForgotBtnPressed,
            ),
            SignInLoginButton(
              onPressed: () {
                _onLoginBtnPressed(context);
              },
            ),
            SignInSocialLogin(
              bloc: bloc,
            ),
            SignUpButton(
              onPressed: _onSignUpBtnPressed,
            ),
          ],
        ),
      ),
    );
  }

  void _onForgotBtnPressed() {}

  void _onLoginBtnPressed(context) {
    Navigator.of(context, rootNavigator: false).pushReplacement(
        CupertinoPageRoute(builder: (BuildContext context) => MainScreen()));
  }

  void _onSignUpBtnPressed() {}
}

class SignInHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(120.0, 20.0, 120.0, 20.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60.0,
            height: 60.0,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new AssetImage('assets/icons/fastkara_icon.png'))),
          ),
          SizedBox(height: 40),
          Text(
            AppTranslations.of(context).text("signin_title"),
            style: CommonTextStyle.signInHeader,
          ),
        ],
      ),
    );
  }
}

class SignInEmailTextBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.grey[700],
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15.0,
              offset: Offset(0, 2),
            )
          ]),
      width: 330.0,
      height: 50.0,
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: StreamBuilder(
        builder: (context, snapshot) => CupertinoTextField(
          prefix: Icon(
            CupertinoIcons.mail,
            size: 32,
            color: AppColors.colorAppText,
          ),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          cursorColor: AppColors.colorAppText,
          keyboardType: TextInputType.emailAddress,
          style: CommonTextStyle.signInTextBox,
          clearButtonMode: OverlayVisibilityMode.editing,
          controller: null,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey[700],
          ),
          placeholder: AppTranslations.of(context).text("signin_enter_email"),
          placeholderStyle: CommonTextStyle.signInHint,
        ),
      ),
    );
  }
}

class SignInPasswordTextBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.grey[700],
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15.0,
              offset: Offset(0, 2),
            )
          ]),
      width: 330.0,
      height: 50.0,
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: StreamBuilder(
        builder: (context, snapshot) => CupertinoTextField(
          prefix: Icon(
            CupertinoIcons.padlock,
            size: 30,
            color: AppColors.colorAppText,
          ),
          obscureText: true,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          cursorColor: AppColors.colorAppText,
          keyboardType: TextInputType.emailAddress,
          style: CommonTextStyle.signInTextBox,
          clearButtonMode: OverlayVisibilityMode.editing,
          controller: null,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey[700],
          ),
          placeholder:
              AppTranslations.of(context).text("signin_enter_password"),
          placeholderStyle: CommonTextStyle.signInHint,
        ),
      ),
    );
  }
}

class SignInForgotPasswordButton extends StatelessWidget {
  SignInForgotPasswordButton({this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 0.0, 30.0, 20.0),
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: onPressed,
        child: Text(
          AppTranslations.of(context).text("signin_forgot_password"),
          style: CommonTextStyle.signInNormal,
        ),
      ),
    );
  }
}

class SignInLoginButton extends StatelessWidget {
  SignInLoginButton({this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: RaisedButton(
        onPressed: onPressed,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange[200], Colors.yellow[100]],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 320.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              AppTranslations.of(context).text("signin_title"),
              textAlign: TextAlign.center,
              style: CommonTextStyle.signInButton,
            ),
          ),
        ),
      ),
    );
  }
}

class SignInSocialLogin extends StatelessWidget {
  SignInSocialLogin({this.bloc});

  final SignInBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 30),
            child: Text(
              AppTranslations.of(context).text("signin_signin_with"),
              style: CommonTextStyle.signInNormal,
            )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  _loginFacebook(context);
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 6.0,
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage('assets/icons/facebook_icon.jpg'),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _loginGoogle(context);
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 6.0,
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage('assets/icons/google_icon.jpg'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _loginFacebook(context) async {
    var loginFacebook = await bloc.logInFacebook();
    if (loginFacebook) {
      Navigator.of(context, rootNavigator: true)
          .push(CupertinoPageRoute(builder: (context) => MainScreen()));
    }
  }

  void _loginGoogle(context) async {
    print("login by google");
  }
}

class SignUpButton extends StatelessWidget {
  SignUpButton({this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 35),
      child: GestureDetector(
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: AppTranslations.of(context).text("signin_no_account"),
                style: CommonTextStyle.signInHint,
              ),
              TextSpan(
                text: AppTranslations.of(context).text("signin_signup"),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
