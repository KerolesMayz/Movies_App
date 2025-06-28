import 'package:flutter/material.dart';
import 'package:movies/screens/auth/forget_password/forget_password.dart';
import 'package:movies/screens/auth/login/login.dart';
import 'package:movies/screens/auth/register/register.dart';
import 'package:movies/screens/explore/explore.dart';
import 'package:movies/screens/onboarding/onboarding.dart';
import 'package:movies/screens/update_profile/update_profile.dart';

import '../../screens/home_screen/home_screen.dart';

class RoutesManager {
  static const String explore = '/explore';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgetPassword = '/forgetPassword';
  static const String homeScreen = '/homeScreen';
  static const String updateProfile = '/updateProfile';

  static Route? router(RouteSettings settings) {
    switch (settings.name) {
      case explore:
        return MaterialPageRoute(builder: (context) => const Explore());
      case onboarding:
        return MaterialPageRoute(builder: (context) => const Onboarding());
      case login:
        return MaterialPageRoute(builder: (context) => const Login());
      case register:
        return MaterialPageRoute(builder: (context) => const Register());
      case forgetPassword:
        return MaterialPageRoute(builder: (context) => const ForgetPassword());
      case homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case updateProfile:
        return MaterialPageRoute(builder: (context) => const UpdateProfile());
    }
    return null;
  }
}
