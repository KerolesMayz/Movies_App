import 'package:flutter/cupertino.dart';
import 'package:movies/providers/home_screen_provider.dart';
import 'package:movies/screens/auth/forget_password/forget_password.dart';
import 'package:movies/screens/auth/login/login.dart';
import 'package:movies/screens/auth/register/register.dart';
import 'package:movies/screens/explore/explore.dart';
import 'package:movies/screens/onboarding/onboarding.dart';
import 'package:provider/provider.dart';

import '../../screens/home_screen/home_screen.dart';

class RoutesManager {
  static const String explore = '/explore';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgetPassword = '/forgetPassword';
  static const String homeScreen = '/homeScreen';

  static Route? router(RouteSettings settings) {
    switch (settings.name) {
      case explore:
        return CupertinoPageRoute(builder: (_) => const Explore());
      case onboarding:
        return CupertinoPageRoute(builder: (_) => const Onboarding());
      case login:
        return CupertinoPageRoute(builder: (_) => const Login());
      case register:
        return CupertinoPageRoute(builder: (_) => const Register());
      case forgetPassword:
        return CupertinoPageRoute(builder: (_) => const ForgetPassword());
      case homeScreen:
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<HomeScreenProvider>(
            create: (_) => HomeScreenProvider(),
            child: const HomeScreen(),
          ),
        );
    }
    return null;
  }
}
