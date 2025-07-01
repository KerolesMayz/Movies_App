import 'package:flutter/material.dart';
import 'package:movies/core/extension/context_extension.dart';

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
      width: context.width,
      height: context.height * 0.6,
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
