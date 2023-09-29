import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData getLightTheme() {
    return ThemeData(
        primaryColor: AppColors.darkerRed,
        scaffoldBackgroundColor: AppColors.white,
        fontFamily: 'Poppins',
        useMaterial3: true);
  }

  static ThemeData getDarkTheme() {
    return ThemeData(
        primaryColor: AppColors.darkerRed,
        scaffoldBackgroundColor: AppColors.black,
        fontFamily: 'Poppins',
        useMaterial3: true);
  }
}
