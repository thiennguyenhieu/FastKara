import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class SignInBloc {
  // Facebook Login
  static final FacebookLogin facebookSignIn = new FacebookLogin();

  Future<Null> _logInFacebook() async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        break;
    }
  }

  Future<Null> _logOutFacebook() async {
    await facebookSignIn.logOut();
  }

  void logInFacebook() {
    _logInFacebook();
  }

  void logOutFacebook() {
    _logOutFacebook();
  }
}
