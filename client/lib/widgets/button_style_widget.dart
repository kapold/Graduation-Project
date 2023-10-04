import 'package:client/widgets/text_style_widget.dart';
import 'package:flutter/material.dart';

class ButtonStyles {
  static ButtonStyle getCutedOrangeButtonStyle() {
    return ElevatedButton.styleFrom(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 20),
        side: const BorderSide(color: Colors.deepOrange, width: 1),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), bottomRight: Radius.circular(0), bottomLeft: Radius.circular(0))),
        textStyle: TextStyles.getTextStyle('Poppins', FontWeight.w500, 20));
  }

  static ButtonStyle getCutedWhiteButtonStyle() {
    return ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepOrange,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 116, vertical: 20),
        side: const BorderSide(color: Colors.deepOrange, width: 1),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20))),
        textStyle: TextStyles.getTextStyle('Poppins', FontWeight.w500, 20));
  }

  static ButtonStyle getCommonOrangeButtonStyle(double horizontalPadding, double verticalPadding) {
    return ElevatedButton.styleFrom(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
        textStyle: TextStyles.getTextStyle('Poppins', FontWeight.w500, 20));
  }
}
