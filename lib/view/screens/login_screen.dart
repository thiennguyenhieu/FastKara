import 'package:flutter/material.dart';

import 'package:fast_kara/model/user_model.dart';
import 'package:fast_kara/static/const_color.dart';
import 'package:fast_kara/view/screens/main_screen.dart';
import 'package:fast_kara/static/const_textstyle.dart';

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

class SignInHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(120.0, 100.0, 120.0, 20.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40.0,
            height: 40.0,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new AssetImage('assets/icons/fastkara_icon.png'))),
          ),
          Text(
            "Sign In",
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
          color: Colors.grey,
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
      child: StreamBuilder(
        builder: (context, snapshot) => TextField(
          keyboardType: TextInputType.emailAddress,
          style: CommonTextStyle.signInTextBox,
          controller: null,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              Icons.email,
              color: CommonColor.colorTextBase,
            ),
            hintText: 'Enter your Email',
            hintStyle: CommonTextStyle.signInHint,
          ),
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
            color: Colors.grey,
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
        child: StreamBuilder(
          builder: (context, snapshot) => TextField(
            obscureText: true,
            style: CommonTextStyle.signInTextBox,
            controller: null,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: CommonColor.colorTextBase,
              ),
              hintText: 'Enter your Password',
              hintStyle: CommonTextStyle.signInHint,
            ),
          ),
        ));
  }
}

class SignInForgotPasswordButton extends StatelessWidget {
  SignInForgotPasswordButton({this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
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
                colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              "Sign In",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
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
        Text(
          'Sign in with',
          style: CommonTextStyle.signInNormal,
        ),
        /*Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
                child: ConstrainedBox(
                    constraints: BoxConstraints.expand(),
                    child: FlatButton(
                        onPressed: onLoginFacebook,
                        padding: EdgeInsets.all(0.0),
                        child: Image.asset('assets/icons/facebook.jpg')))),
            Container(
                child: ConstrainedBox(
                    constraints: BoxConstraints.expand(),
                    child: FlatButton(
                        onPressed: onLoginGoogle,
                        padding: EdgeInsets.all(0.0),
                        child: Image.asset('assets/icons/google.jpg')))),
          ],
        ),*/
      ],
    );
  }
}

class SignUpButton extends StatelessWidget {
  SignUpButton({this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('Sign Up Button Pressed'),
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
    );
  }
}
