import 'package:flutter/material.dart';

import 'package:fast_kara/static/const_color.dart';

class CommonTextStyle {
  static const signInHint = TextStyle(
    color: const Color(0xFF949494),
    fontFamily: 'BebasNeue-Regular',
  );

  static const signInNormal = TextStyle(
    color: Colors.white,
    fontFamily: 'BebasNeue-Regular',
  );

  static const signInTextBox = TextStyle(
    color: Colors.white,
    fontFamily: 'OpenSans',
  );

  static const signInButton = TextStyle(
    color: Color(0xFF150B03),
    letterSpacing: 1.5,
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
  );

  static const signInHeader = TextStyle(
      fontSize: 25.0,
      fontFamily: 'BebasNeue-Regular',
      color: AppColors.colorAppText);
}
