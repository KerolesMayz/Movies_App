import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors_manager/colors_Manager.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.foregroundColor = ColorsManager.black,
    this.backgroundColor = ColorsManager.yellow,
    this.borderColor = ColorsManager.yellow,
    this.child,
  });

  final String text;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        padding: REdgeInsets.all(16),
        textStyle: GoogleFonts.roboto(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      child:
      child ??
          Text(
            text,
          ),
    );
  }
}
