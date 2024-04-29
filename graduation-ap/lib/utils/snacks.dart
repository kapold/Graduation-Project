import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';

class Snacks {
  static void success(BuildContext context, String label) {
    IconSnackBar.show(
      context,
      snackBarType: SnackBarType.success,
      label: label,
    );
  }

  static void failed(BuildContext context, String label) {
    IconSnackBar.show(
      context,
      snackBarType: SnackBarType.fail,
      label: label,
    );
  }

  static void alert(BuildContext context, String label) {
    IconSnackBar.show(
      context,
      snackBarType: SnackBarType.alert,
      label: label,
    );
  }
}
