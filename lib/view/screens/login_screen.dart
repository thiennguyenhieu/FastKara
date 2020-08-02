import 'package:flutter/material.dart';

import 'package:fast_kara/model/user_model.dart';
import 'package:fast_kara/static/const_color.dart';
import 'package:fast_kara/view/screens/main_screen.dart';
import 'package:fast_kara/view/widgets/sign_in_parts.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  UserModel _userModel = UserModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: CommonColor.colorBackground,
      body: Column(
        children: <Widget>[
          SignInHeader(),
          SignInEmailTextBox(),
          SignInPasswordTextBox(),
          SignInForgotPasswordButton(
            onPressed: _onForgotBtnPressed,
          ),
          SignInLoginButton(
            onPressed: _onLoginBtnPressed,
          ),
          SignInSocialLogin(
            onLoginFacebook: _onLoginFacebook,
            onLoginGoogle: _onLoginGoogle,
          ),
          SignUpButton(
            onPressed: _onSignUpBtnPressed,
          ),
        ],
      ),
    );
  }

  void _onForgotBtnPressed() {}

  void _onLoginBtnPressed() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => MainScreen()));
  }

  void _onLoginFacebook() {}

  void _onLoginGoogle() {}

  void _onSignUpBtnPressed() {}
}
