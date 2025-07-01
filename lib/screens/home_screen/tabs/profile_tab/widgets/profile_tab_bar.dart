import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/colors_manager/colors_Manager.dart';

class ProfileTabBar extends StatelessWidget {
  const ProfileTabBar({super.key, this.onTap, this.initialTap = 0});

  final void Function(int)? onTap;
  final int initialTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      margin: EdgeInsets.zero,
      color: ColorsManager.mediumBlack,
      child: DefaultTabController(
        initialIndex: initialTap,
        length: 2,
        child: TabBar(
          unselectedLabelColor: ColorsManager.yellow,
          labelColor: ColorsManager.yellow,
          indicatorColor: ColorsManager.yellow,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 3,
          dividerColor: ColorsManager.transparent,
          labelPadding: REdgeInsets.only(bottom: 16),
          padding: REdgeInsets.only(top: 18),
          onTap: onTap,
          tabs: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.list_rounded, size: 34.r),
                Text(
                  'Watch List',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.folder_rounded, size: 34.r),
                Text(
                  'History',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
