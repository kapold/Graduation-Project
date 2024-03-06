import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../styles/app_colors.dart';

class Loaders {
  static Center getDotsTriangle(double size) {
    return Center(
      child: LoadingAnimationWidget.dotsTriangle(
        color: AppColors.deepOrange,
        size: size,
      ),
    );
  }

  static Widget getAdaptiveLoader() {
    return const Center(
      child: CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.deepOrange),
      ),
    );
  }
}
