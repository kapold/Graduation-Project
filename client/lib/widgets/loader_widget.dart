import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loaders {
  static Center getDotsTriangle() {
    return Center(
      child: LoadingAnimationWidget.dotsTriangle(
        color: Colors.deepOrange,
        size: 60
      )
    );
  }
}