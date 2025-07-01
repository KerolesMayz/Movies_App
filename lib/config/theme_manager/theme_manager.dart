import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/core/colors_manager/colors_Manager.dart';

class ThemeManager {
  static ThemeData dark = ThemeData(
      progressIndicatorTheme: ProgressIndicatorThemeData(
          color: ColorsManager.yellow
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: GoogleFonts.roboto(color: ColorsManager.white),
          contentPadding: REdgeInsets.symmetric(vertical: 14, horizontal: 0),
        prefixIconColor: ColorsManager.white,
          errorStyle: GoogleFonts.roboto(fontSize: 14.sp, color: Colors.red),
        suffixIconColor: ColorsManager.white,
        border: InputBorder.none,
          prefixStyle: GoogleFonts.roboto(
            fontSize: 16.sp,
            color: ColorsManager.white,
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          fillColor: ColorsManager.lightBlack
      ),
    appBarTheme: AppBarTheme(
      toolbarHeight: 60.h,
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
        displayMedium: GoogleFonts.roboto(
          fontWeight: FontWeight.w400,
          color: ColorsManager.white,
          fontSize: 20.sp,
        ),
        headlineMedium: GoogleFonts.roboto(
          fontWeight: FontWeight.w700,
          color: ColorsManager.white,
          fontSize: 20.sp,
        ),
        headlineLarge: GoogleFonts.roboto(
          fontWeight: FontWeight.w700,
          color: ColorsManager.white,
          fontSize: 36.sp,
        )
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: ColorsManager.mediumBlack,
      showUnselectedLabels: false,
      showSelectedLabels: false,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      height: 70.h,
      padding: EdgeInsets.zero,
      color: ColorsManager.transparent,
    ),
    splashFactory: NoSplash.splashFactory,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: ColorsManager.mediumBlack,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
      )
  );
}
