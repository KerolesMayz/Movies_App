import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/core/colors_manager/colors_Manager.dart';

class ThemeManager {
  static ThemeData dark = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.transparent,
      foregroundColor: ColorsManager.yellow,
      titleTextStyle: GoogleFonts.roboto(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: ColorsManager.yellow,
      ),
        centerTitle: true,
    ),
    scaffoldBackgroundColor: ColorsManager.black,
    textTheme: TextTheme(
      titleLarge: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 36.sp,
        color: ColorsManager.white,
      ),
      titleMedium: GoogleFonts.inter(
        fontWeight: FontWeight.w700,
        fontSize: 24.sp,
        color: ColorsManager.white,
      ),
      titleSmall: GoogleFonts.inter(
        fontWeight: FontWeight.w400,
        fontSize: 20.sp,
        color: ColorsManager.white,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: ColorsManager.mediumBlack,
      showUnselectedLabels: false,
      showSelectedLabels: false,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      padding: EdgeInsets.zero,
      color: ColorsManager.transparent,
    ),
    splashFactory: NoSplash.splashFactory,
  );
}
