import 'package:flutter/widgets.dart';

import '../screens/home_screen/tabs/home_tab/home_tab.dart';

class HomeScreenProvider extends ChangeNotifier {
  Widget tab = HomeTab();
  int currentTab = 0;

  void navigateToTab(Widget newTab, int newIndex) {
    if (tab == newTab) return;
    tab = newTab;
    currentTab = newIndex;
    notifyListeners();
  }
}
