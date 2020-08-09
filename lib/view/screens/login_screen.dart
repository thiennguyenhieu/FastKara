import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fast_kara/static/const_color.dart';
import 'package:fast_kara/view/screens/main_screen.dart';
import 'package:fast_kara/static/const_textstyle.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      backgroundColor: AppColors.colorAppBackground,
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
    Navigator.of(context, rootNavigator: false).pushReplacement(
        CupertinoPageRoute(builder: (BuildContext context) => MainScreen()));
  }

  void _onLoginFacebook() {}

  void _onLoginGoogle() {}

  void _onSignUpBtnPressed() {}
}

class SignInHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(120.0, 90.0, 120.0, 20.0),
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
            "SIGN IN",
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
          placeholder: 'Enter your Email',
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
          placeholder: 'Enter your password',
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
          'Forgot Password?',
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
              "Sign In",
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
  SignInSocialLogin({this.onLoginFacebook, this.onLoginGoogle});

  final VoidCallback onLoginFacebook;
  final VoidCallback onLoginGoogle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 30),
            child: Text(
              'Sign in with',
              style: CommonTextStyle.signInNormal,
            )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: IconButton(
                    icon: Image.asset('assets/icons/facebook_icon.jpg'),
                    iconSize: 35,
                    onPressed: onLoginGoogle,
                  )),
              Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: IconButton(
                    icon: Image.asset('assets/icons/google_icon.jpg'),
                    iconSize: 35,
                    onPressed: onLoginGoogle,
                  )),
            ],
          ),
        ),
      ],
    );
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
                text: 'Don\'t have an Account? ',
                style: CommonTextStyle.signInHint,
              ),
              TextSpan(
                text: 'Sign Up',
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
