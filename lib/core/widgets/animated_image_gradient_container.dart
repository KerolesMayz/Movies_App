import 'package:flutter/material.dart';

import '../colors_manager/colors_Manager.dart';

class AnimatedImageGradientContainer extends StatelessWidget {
  const AnimatedImageGradientContainer({
    super.key,
    required this.imageUrl,
    this.bottomGradientColor = ColorsManager.black,
  });

  final String imageUrl;
  final Color bottomGradientColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: double.infinity,
      height: double.infinity,
      foregroundDecoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            bottomGradientColor.withValues(alpha: 1),
            bottomGradientColor.withValues(alpha: 0.6),
            bottomGradientColor.withValues(alpha: 0.8),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.topCenter,
          image: NetworkImage(imageUrl),
          fit: BoxFit.fitWidth,
        ),
      ),
      duration: Duration(milliseconds: 300),
    );
  }
}
