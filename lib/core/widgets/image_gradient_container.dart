import 'package:flutter/material.dart';

import '../colors_manager/colors_Manager.dart';

class ImageGradientContainer extends StatelessWidget {
  const ImageGradientContainer({
    super.key,
    required this.imagePath,
    this.bottomGradientColor = ColorsManager.black,
  });

  final String imagePath;
  final Color bottomGradientColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      foregroundDecoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            bottomGradientColor,
            bottomGradientColor.withValues(alpha: 0.7),
            bottomGradientColor.withValues(alpha: 0.4),
            ColorsManager.transparent,
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.topCenter,
          image: AssetImage(imagePath),
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
