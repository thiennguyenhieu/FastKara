import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../model/user_model.dart';
import '../static/const_color.dart';
import 'package:fast_kara/ui/pages/login_screen.dart';

class UserDetails extends StatefulWidget {
  @override
  _UserDetails createState() => _UserDetails();
}

class _UserDetails extends State<UserDetails> {
  var userModel = UserModel.getInstance();
  final _storage = new FlutterSecureStorage();
  final _key = "login_key";
  String _message = 'Log in/out by pressing the buttons below.';
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future delete() async {
    await _storage.delete(key: _key);
  }

  Future<Null> _logOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    await facebookSignIn.logOut();
    delete();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LogInScreen()),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColor.colorBackground,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(padding: const EdgeInsets.all(50)),
              Icon(
                Icons.account_circle,
                size: 80.0,
                color: Colors.white,
              ),
              Text(
                userModel.getUserName != null ? userModel.getUserName : '0',
                style: TextStyle(color: Colors.orange, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _logOut();
          },
          label: Text(
            'Log out ',
            style: TextStyle(color: Colors.orange),
          )),
    );
  }
}
