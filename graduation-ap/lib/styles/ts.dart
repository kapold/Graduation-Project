import 'package:flutter/material.dart';

class TS {
  static TextStyle getPoiret(
      double fontSize, FontWeight fontWeight, Color color) {
    return TextStyle(
      fontFamily: 'Poiret',
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle getOpenSans(
      double fontSize, FontWeight fontWeight, Color color) {
    return TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle getPoppins(
      double fontSize, FontWeight fontWeight, Color color) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    );
  }
}
