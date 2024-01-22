import 'package:flutter/material.dart';

class AppBars {
  static AppBar getCommonAppBar(String title, BuildContext context) {
    return AppBar(
        title: Text(title, style: const TextStyle(color: Colors.deepOrange)),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child:
                const Icon(Icons.arrow_back_ios_new, color: Colors.deepOrange)),
        backgroundColor: Colors.white);
  }
}
