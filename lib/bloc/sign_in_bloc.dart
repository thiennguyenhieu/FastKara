import 'dart:async';

import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class SignInBloc {
  // Facebook Login
  static final FacebookLogin facebookLogin = new FacebookLogin();

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

  Future<Null> _logOutFacebook() async {
    await facebookLogin.logOut();
  }

  Future<bool> logInFacebook() async {
    var facebookLoginResult = await _logInFacebook();
    return facebookLoginResult;
  }

  void logOutFacebook() {
    _logOutFacebook();
  }

  void dispose() {}
}
