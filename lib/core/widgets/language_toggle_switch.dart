import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors_manager/colors_Manager.dart';

class LanguageToggleSwitch extends StatelessWidget {
  const LanguageToggleSwitch({
    super.key,
    this.currentLanguage = 0,
    this.changeLanguage,
  });

  final void Function(int)? changeLanguage;
  final int currentLanguage;

  @override
  Widget build(BuildContext context) {
    return AnimatedToggleSwitch<int>.rolling(
      current: currentLanguage,
      values: const [0, 1],
      onChanged: changeLanguage,
      iconBuilder: (val, isSelected) {
        return val == 0
            ? Image.asset(
                'assets/images/flags/lr.png',
                width: 24.w,
                height: 24.h,
              )
            : Image.asset(
                'assets/images/flags/eg.png',
                width: 24.w,
                height: 24.h,
              );
      },
      style: ToggleStyle(
        backgroundColor: Colors.transparent,
        indicatorColor: ColorsManager.yellow,
        borderColor: ColorsManager.yellow,
        borderRadius: BorderRadius.circular(30.r),
        indicatorBorderRadius: BorderRadius.circular(30.r),
      ),
      spacing: 15.w,
    );
  }
}
