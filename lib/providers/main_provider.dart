import 'package:flutter/cupertino.dart';
import 'package:movies/core/routes_manager/routes_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainProvider extends ChangeNotifier {
  String initialScreen = RoutesManager.login;

  Future<void> getInitialScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    if (isFirstTime) {
      initialScreen = RoutesManager.explore;
      notifyListeners();
    }
  }

  Future<void> setInitialScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFirstTime', false);
  }
}
