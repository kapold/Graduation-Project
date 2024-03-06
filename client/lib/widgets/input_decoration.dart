import 'package:client/styles/ts.dart';
import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

class InputDecorations {
  static InputDecoration getOrangeDecoration(String label, String hint, IconData icon) {
    return InputDecoration(
      contentPadding:
          const EdgeInsets.only(left: 48, right: 20, top: 20, bottom: 20),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      prefixIcon: Icon(icon),
      focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.deepOrange)),
      labelStyle: TS.getOpenSans(18, FontWeight.w500, AppColors.deepOrange),
      labelText: label,
      hintText: hint,
    );
  }

  static InputDecoration getSearch(String label, String hint, IconData icon) {
    return InputDecoration(
      contentPadding:
      const EdgeInsets.only(left: 48, right: 20, top: 20, bottom: 20),
      border: InputBorder.none,
      prefixIcon: Icon(icon),
      labelStyle: TS.getOpenSans(18, FontWeight.w500, AppColors.deepOrange),
      labelText: label,
      hintText: hint,
    );
  }
}
