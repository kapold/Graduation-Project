import 'package:flutter/material.dart';

class AppBars {
  static AppBar getCommonAppBar(String title) {
    return AppBar(
      title: Text(title),
      leading: const Icon(Icons.arrow_back_ios),
      backgroundColor: Colors.deepOrange,
      foregroundColor: Colors.white
    );
  }
}
