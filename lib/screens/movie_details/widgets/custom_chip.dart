import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/colors_manager/colors_Manager.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({super.key, required this.text, required this.svgIconPath});

  final String text;
  final String svgIconPath;

  @override
  Widget build(BuildContext context) {
    return Chip(
      padding: REdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: ColorsManager.mediumBlack),
        borderRadius: BorderRadius.circular(16.r),
      ),
      labelStyle: Theme.of(context).textTheme.labelMedium,
      label: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(child: SvgPicture.asset(svgIconPath, height: 30.r)),
          SizedBox(width: 14.w),
          Text(text, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
