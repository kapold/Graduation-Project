import 'package:client/styles/ts.dart';
import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

class ButtonStyles {
  static ButtonStyle getCutedOrangeButtonStyle(double horizontalPadding, double verticalPadding) {
    return ElevatedButton.styleFrom(
        backgroundColor: AppColors.deepOrange,
        foregroundColor: AppColors.white,
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
        side: const BorderSide(color: AppColors.deepOrange, width: 1),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), bottomRight: Radius.circular(0), bottomLeft: Radius.circular(0))),
        textStyle: TS.getPoppins(20, FontWeight.w500, AppColors.black));
  }

  static ButtonStyle getCutedWhiteButtonStyle(double horizontalPadding, double verticalPadding) {
    return ElevatedButton.styleFrom(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.deepOrange,
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
        side: const BorderSide(color: AppColors.deepOrange, width: 1),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20))),
        textStyle: TS.getPoppins(20, FontWeight.w500, AppColors.black));
  }

  static ButtonStyle getCommonOrangeButtonStyle(double horizontalPadding, double verticalPadding) {
    return ElevatedButton.styleFrom(
        backgroundColor: AppColors.deepOrange,
        foregroundColor: AppColors.white,
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
        textStyle: TS.getPoppins(20, FontWeight.w500, AppColors.black));
  }

  static ButtonStyle getOutlinedRedButtonStyle(double horizontalPadding, double verticalPadding) {
    return ElevatedButton.styleFrom(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.darkerRed,
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30)), side: BorderSide(color: AppColors.darkerRed)),
        textStyle: TS.getPoppins(20, FontWeight.w500, AppColors.black));
  }

  static ButtonStyle getOutlinedOrangeButtonStyle(double horizontalPadding, double verticalPadding) {
    return ElevatedButton.styleFrom(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.deepOrange,
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30)), side: BorderSide(color: AppColors.deepOrange)),
        textStyle: TS.getPoppins(20, FontWeight.w500, AppColors.black));
  }

  static ButtonStyle getSquaredOrangeButtonStyle(double horizontalPadding, double verticalPadding) {
    return ElevatedButton.styleFrom(
        backgroundColor: AppColors.deepOrange,
        foregroundColor: AppColors.white,
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
        textStyle: TS.getPoppins(20, FontWeight.w500, AppColors.black));
  }

  static ButtonStyle getSquaredOutlinedOrangeButtonStyle(double horizontalPadding, double verticalPadding) {
    return ElevatedButton.styleFrom(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.deepOrange,
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8)), side: BorderSide(color: AppColors.deepOrange)),
        textStyle: TS.getPoppins(20, FontWeight.w500, AppColors.black));
  }

  static ButtonStyle getSquaredOutlinedRedButtonStyle(double horizontalPadding, double verticalPadding) {
    return ElevatedButton.styleFrom(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.darkerRed,
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8)), side: BorderSide(color: AppColors.darkerRed)),
        textStyle: TS.getPoppins(20, FontWeight.w500, AppColors.black));
  }

  static ButtonStyle getOrangeOutlinedBox(double horizontalPadding, double verticalPadding) {
    return ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        side: BorderSide(color: AppColors.deepOrange),
      ),
      elevation: 0,
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.black,
    );
  }
}
