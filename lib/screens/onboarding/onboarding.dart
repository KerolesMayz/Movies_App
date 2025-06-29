import 'package:flutter/material.dart';
import 'package:movies/core/assets_manager/assets_manager.dart';
import 'package:movies/core/colors_manager/colors_Manager.dart';
import 'package:movies/core/routes_manager/routes_manager.dart';
import 'package:movies/core/widgets/custom_onboarding_page.dart';
import 'package:movies/providers/main_provider.dart';
import 'package:provider/provider.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late PageController controller;
  late List<CustomOnboardingPage> pages;

  void goToNextPage() {
    Navigator.pop(context);
    controller.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void goToPreviousPage() {
    Navigator.pop(context);
    controller.previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void goToLoginScreen() async {
    var mainProvider = Provider.of<MainProvider>(context, listen: false);
    Navigator.pop(context);
    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesManager.login,
      (route) => false,
    );
    await mainProvider.setInitialScreen();
  }

  @override
  void initState() {
    super.initState();
    controller = PageController();
    pages = [
      CustomOnboardingPage(
        onNext: goToNextPage,
        title: 'Discover Movies',
        imagePath: OnboardingAssets.onboarding1,
        body:
            "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
        bottomGradientColor: ColorsManager.cian,
      ),
      CustomOnboardingPage(
        onNext: goToNextPage,
        onBack: goToPreviousPage,
        title: 'Explore All Genres',
        imagePath: OnboardingAssets.onboarding2,
        body:
            "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.",
        bottomGradientColor: ColorsManager.orange,
      ),
      CustomOnboardingPage(
        onNext: goToNextPage,
        onBack: goToPreviousPage,
        title: 'Create Watchlists',
        imagePath: OnboardingAssets.onboarding3,
        body:
            "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.",
        bottomGradientColor: ColorsManager.purple,
      ),
      CustomOnboardingPage(
        onNext: goToNextPage,
        onBack: goToPreviousPage,
        title: 'Rate, Review, and Learn',
        imagePath: OnboardingAssets.onboarding4,
        body:
            "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
        bottomGradientColor: ColorsManager.darkRed,
      ),
      CustomOnboardingPage(
        isLastPage: true,
        onNext: goToLoginScreen,
        onBack: goToPreviousPage,
        title: 'Start Watching Now',
        imagePath: OnboardingAssets.onboarding5,
        bottomGradientColor: ColorsManager.lightBlack,
      ),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: pages.length,
      controller: controller,
      itemBuilder: (context, index) {
        return pages[index];
      },
    );
  }
}
