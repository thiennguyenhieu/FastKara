import 'dart:async';

import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInBloc {
  // Facebook Login
  static final FacebookLogin facebookLogin = new FacebookLogin();
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );

  Future<bool> signInGoogle() async {
    bool googleSignInResult = await _signInGoogle();
    return googleSignInResult;
  }

  Future<Null> _logOutGoogle() async {
    await googleSignIn.signOut();
  }

  void logOutFacebook() {
    _logOutFacebook();
  }

  void logOutGoogle() {
    _logOutGoogle();
  }

  Future<bool> _logInFacebook() async {
    final FacebookLoginResult result = await facebookLogin.logIn(['email']);
    bool bRet = false;

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final String token = result.accessToken.token;
        bRet = true;
        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        break;
    }

    return bRet;
  }

  Future<bool> _signInGoogle() async {
    await googleSignIn.signIn();
    bool isChecked = false;
    if (googleSignIn.isSignedIn() != null) {
      isChecked = true;
    }
    return isChecked;
  }

  Future<Null> _logOutFacebook() async {
    await facebookLogin.logOut();
  }

  Future<bool> logInFacebook() async {
    var facebookLoginResult = await _logInFacebook();
    return facebookLoginResult;
  }

  void dispose() {}
}
