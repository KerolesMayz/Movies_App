import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/core/assets_manager/assets_manager.dart';
import 'package:movies/core/colors_manager/colors_Manager.dart';
import 'package:movies/providers/home_screen_provider.dart';
import 'package:movies/screens/home_screen/tabs/browse_tab/browse_tab.dart';
import 'package:movies/screens/home_screen/tabs/home_tab/home_tab.dart';
import 'package:movies/screens/home_screen/tabs/profile_tab/profile_tab.dart';
import 'package:movies/screens/home_screen/tabs/search_tab/search_tab.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _tabs = [
    HomeTab(),
    SearchTab(),
    BrowseTab(initialTap: 0),
    ProfileTab(),
  ];

  BottomNavigationBarItem customBottomNavigationBarItem({
    required String iconPath,
    required String label,
    required int index,
  }) {
    int selectedIndex = Provider.of<HomeScreenProvider>(context).currentTab;
    Color color = index == selectedIndex
        ? ColorsManager.yellow
        : ColorsManager.white;
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        height: 26.r,
        iconPath,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: REdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: BottomAppBar(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BottomNavigationBar(
              currentIndex: Provider.of<HomeScreenProvider>(context).currentTab,
              selectedFontSize: 0,
              unselectedFontSize: 0,
              onTap: (value) {
                Provider.of<HomeScreenProvider>(
                  context,
                  listen: false,
                ).navigateToTab(_tabs[value], value);
              },
              items: [
                customBottomNavigationBarItem(
                  iconPath: SvgIcons.home,
                  label: 'home',
                  index: 0,
                ),
                customBottomNavigationBarItem(
                  iconPath: SvgIcons.search,
                  label: 'search',
                  index: 1,
                ),
                customBottomNavigationBarItem(
                  iconPath: SvgIcons.explore,
                  label: 'explore',
                  index: 2,
                ),
                customBottomNavigationBarItem(
                  iconPath: SvgIcons.profile,
                  label: 'profile',
                  index: 3,
                ),
              ],
            ),
          ),
        ),
      ),
      extendBody: true,
      body: Provider.of<HomeScreenProvider>(context).tab,
    );
  }
}
