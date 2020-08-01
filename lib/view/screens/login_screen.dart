import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:fast_kara/model/user_model.dart';
import 'package:fast_kara/static/const_color.dart';
import 'package:fast_kara/view/screens/main_screen.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final hintTextStyle = TextStyle(
    color: const Color(0xFF949494),
    fontFamily: 'BebasNeue-Regular',
  );

  final normalTextStyle = TextStyle(
    color: Colors.white,
    fontFamily: 'BebasNeue-Regular',
  );

  @override
  void initState() {
    _checkGoogleLogin();
    super.initState();
  }

  final _storage = new FlutterSecureStorage();
  final _key = "login_key";
  String _message = 'Log in/out by pressing the buttons below.';

  //social sign in
  static final FacebookLogin facebookSignIn = FacebookLogin();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var userModel = UserModel.getInstance();
  TextEditingController _user = new TextEditingController();
  TextEditingController _pass = new TextEditingController();

  Widget _buildIconImage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(120, 100, 120, 0),
          child: Container(
            width: 80.0,
            height: 80.0,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new AssetImage('assets/icons/fastkara_icon.png'))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(120, 60, 120, 20),
          child: Text(
            "Sign In",
            style: TextStyle(
                fontSize: 50.0,
                fontFamily: 'Bebas',
                color: CommonColor.colorTextBase),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailTF() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Color(0xFF393B3A),
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
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              controller: _user,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.email,
                  color: const Color.fromRGBO(255, 218, 159, 1.0),
                ),
                hintText: 'Enter your Email',
                hintStyle: hintTextStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Color(0xFF393B3A),
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
                style: TextStyle(
                  color: Color(0xFFFFBD4D),
                  fontFamily: 'OpenSans',
                ),
                controller: this._pass,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: const Color.fromRGBO(255, 218, 159, 1.0),
                  ),
                  hintText: 'Enter your Password',
                  hintStyle: hintTextStyle,
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 30.0),
        child: Text(
          'Forgot Password?',
          style: normalTextStyle,
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          _onSignInClicked();
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Color(0xFFF9E29C),
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Color(0xFF150B03),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        SizedBox(height: 20),
        Text(
          'Sign in with',
          style: normalTextStyle,
        ),
      ],
    );
  }

  Widget _buildFaceBookBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45.0,
        width: 45.0,
        child: FlatButton(
            onPressed: () => _loginFacebook(),
            padding: EdgeInsets.only(right: 30.0)),
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
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45.0,
        width: 45.0,
        child: FlatButton(
            onPressed: () => _handleGoogleSignIn(),
            padding: EdgeInsets.only(right: 30.0)),
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
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildFaceBookBtn(
            () => print('Login with Facebook'),
            AssetImage(
              'assets/icons/facebook.jpg',
            ),
          ),
          _buildGoogleBtn(
            () => print('Login with Google'),
            AssetImage(
              'assets/icons/google.jpg',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => print('Sign Up Button Pressed'),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: hintTextStyle,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(color: CommonColor.colorBackground),
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      _buildIconImage(),
                      _buildEmailTF(),
                      SizedBox(height: 20),
                      _buildPasswordTF(),
                      _buildForgotPasswordBtn(),
                      _buildLoginBtn(),
                      _buildSignInWithText(),
                      _buildSocialBtnRow(),
                      _buildSignupBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future writeUser(String user, String pass) async {
    _storage.write(key: _key, value: user);
  }

  void _onSignInClicked() {
    if (UserModel.isValidUser(_user.text) &&
        UserModel.isValidPass(_pass.text)) {
      userModel.setUserName(_user.text);
      writeUser(_user.text, _pass.text);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainScreen()));
    } else {
      _showAlertDialog();
    }
  }

  void _showAlertDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("Invalid username or password\nPlease try again..."),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Close")),
            ],
          );
        });
  }

  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  Future<Null> _loginFacebook() async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        userModel.setUserName(accessToken.userId);
        writeUser(_user.text, _pass.text);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
        break;
      case FacebookLoginStatus.cancelledByUser:
        _showMessage('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        _showMessage('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

  Future<FirebaseUser> _handleGoogleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    userModel.setUserName(user.displayName);
    writeUser(_user.text, _pass.text);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainScreen()));
    return user;
  }

  Future _checkGoogleLogin() async {
    final fbLogin = await _auth.currentUser();
    final FirebaseUser ggLogin = await _auth.currentUser();
    if (fbLogin != null) {
      setState(() {
        _showMessage("You are signed in");
        userModel.setUserName(fbLogin.displayName);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
      });
    } else if (ggLogin != null) {
      setState(() {
        _showMessage("You are signed in");
        userModel.setUserName(ggLogin.displayName);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
      });
    }
  }
}
