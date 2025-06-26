import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/assets_manager/assets_manager.dart';
import 'package:movies/core/routes_manager/routes_manager.dart';
import 'package:movies/core/widgets/custom_button.dart';
import 'package:movies/core/widgets/image_gradient_container.dart';

class Explore extends StatelessWidget {
  const Explore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            ImageGradientContainer(imagePath: OnboardingAssets.explore),
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Find Your Next\nFavorite Movie Here',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Get access to a huge library of movies to suit all tastes. You will surely like it.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(height: 24.h),
                  CustomButton(
                    text: 'Explore Now',
                    onTap: () {
                      Navigator.pushNamed(context, RoutesManager.onboarding);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
