import 'package:flutter/material.dart';
import 'package:movies/core/extension/context_extension.dart';

import '../colors_manager/colors_Manager.dart';

class AnimatedImageGradientContainer extends StatelessWidget {
  const AnimatedImageGradientContainer({
    super.key,
    required this.imageUrl,
    this.gradientColor = ColorsManager.black,
  });

  final String? imageUrl;
  final Color gradientColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: context.width,
      height: context.height * 0.6,
      foregroundDecoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            gradientColor.withValues(alpha: 1),
            gradientColor.withValues(alpha: 0.6),
            gradientColor.withValues(alpha: 0.8),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      decoration: BoxDecoration(
        image: imageUrl != null
            ? DecorationImage(
                alignment: Alignment.topCenter,
                image: NetworkImage(imageUrl!),
                fit: BoxFit.fitWidth,
              )
            : null,
      ),
      duration: Duration(milliseconds: 300),
    );
  }
}
