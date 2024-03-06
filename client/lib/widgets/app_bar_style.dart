import 'package:client/styles/ts.dart';
import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

class AppBars {
  static AppBar getCommonAppBar(String title, BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TS.getOpenSans(
          22,
          FontWeight.w400,
          AppColors.deepOrange,
        ),
      ),
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.deepOrange,
        ),
      ),
      backgroundColor: AppColors.white,
    );
  }
}
