import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle getTextStyle(
      String fontFamily, FontWeight fontWeight, double fontSize) {
    return TextStyle(
        fontFamily: fontFamily, fontWeight: fontWeight, fontSize: fontSize);
  }
}
