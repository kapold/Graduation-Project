import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration getOrangeDecoration(String label, String hint, IconData icon) {
    return InputDecoration(
        contentPadding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        prefixIcon: Icon(icon),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.deepOrange)),
        labelStyle: const TextStyle(fontSize: 18, color: Colors.deepOrange),
        labelText: label,
        hintText: hint
    );
  }

  static InputDecoration getSearch(String hint, TextEditingController controller) {
    return InputDecoration(
        contentPadding: const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40)
        ),
        suffixIcon: GestureDetector(
            onTap: () {
              controller.text = '';
            },
            child: const Icon(Icons.close)
        ),
        prefixIcon: const Icon(Icons.search),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.deepOrange),
          borderRadius: BorderRadius.circular(25.7),
        ),
        labelStyle: const TextStyle(fontSize: 18, color: Colors.deepOrange),
        hintText: hint
    );
  }
}