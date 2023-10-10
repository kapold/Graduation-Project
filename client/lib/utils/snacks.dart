import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';

class Snacks {
  static void success(BuildContext context, String label) {
    IconSnackBar.show(
      context: context,
      snackBarType: SnackBarType.save,
      label: label
    );
  }

  static void failed(BuildContext context, String label) {
    IconSnackBar.show(
        context: context,
        snackBarType: SnackBarType.fail,
        label: label
    );
  }

  static void alert(BuildContext context, String label) {
    IconSnackBar.show(
        context: context,
        snackBarType: SnackBarType.alert,
        label: label
    );
  }
}