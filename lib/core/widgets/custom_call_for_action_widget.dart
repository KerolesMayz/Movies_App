import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors_manager/colors_Manager.dart';

class CustomCallForActionWidget extends StatelessWidget {
  const CustomCallForActionWidget({
    super.key,
    required this.callForAction,
    required this.actionText,
    required this.action,
  });

  final String callForAction;
  final String actionText;
  final VoidCallback? action;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          callForAction,
          style: GoogleFonts.roboto(
            color: ColorsManager.white,
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
          ),
        ),
        InkWell(
          onTap: action,
          child: Text(
            actionText,
            style: GoogleFonts.roboto(
              color: ColorsManager.yellow,
              fontWeight: FontWeight.w900,
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
    );
  }
}
