import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration getOrangeDecoration(String label, String hint, IconData icon) {
    return InputDecoration(
        contentPadding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        prefixIcon: Icon(icon),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.deepOrange),
          borderRadius: BorderRadius.circular(25.7),
        ),
        labelStyle: const TextStyle(fontSize: 18, color: Colors.deepOrange),
        labelText: label,
        hintText: hint
    );
  }
}