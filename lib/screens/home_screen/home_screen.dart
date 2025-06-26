import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/core/assets_manager/assets_manager.dart';
import 'package:movies/core/colors_manager/colors_Manager.dart';
import 'package:movies/screens/home_screen/tabs/browse_tab/browse_tab.dart';
import 'package:movies/screens/home_screen/tabs/home_tab/home_tab.dart';
import 'package:movies/screens/home_screen/tabs/profile_tab/profile_tab.dart';
import 'package:movies/screens/home_screen/tabs/search_tab/search_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    HomeTab(),
    SearchTab(),
    BrowseTab(),
    ProfileTab(),
  ];

  BottomNavigationBarItem customBottomNavigationBarItem({
    required String iconPath,
    required String label,
    required int index,
  }) {
    Color color = index == _currentIndex
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
        padding: REdgeInsets.symmetric(horizontal: 10),
        child: BottomAppBar(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BottomNavigationBar(
              currentIndex: 0,
              selectedFontSize: 0,
              unselectedFontSize: 0,
              onTap: (value) {
                setState(() {
                  _currentIndex = value;
                });
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
      body: _tabs[_currentIndex],
    );
  }
}
