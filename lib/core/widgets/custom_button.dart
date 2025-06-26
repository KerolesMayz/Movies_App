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
  });

  final String text;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        padding: REdgeInsets.all(16),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: ColorsManager.yellow),
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(fontSize: 20.sp, fontWeight: FontWeight.w600),
      ),
    );
  }
}
