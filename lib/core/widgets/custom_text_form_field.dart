import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors_manager/colors_Manager.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.obscureText = false,
    this.labelText,
    this.isPassword = false,
    this.prefixIcon,
    this.onVisibilityClick,
    this.controller,
    this.validator,
    this.maxLength,
    this.keyboardType,
    this.prefixText,
    this.inputFormatters,
  });

  final TextEditingController? controller;
  final int? maxLength;
  final bool obscureText;
  final String? labelText;
  final Widget? prefixIcon;
  final bool isPassword;
  final VoidCallback? onVisibilityClick;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final String? prefixText;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.lightBlack,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        maxLength: maxLength,
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        inputFormatters: inputFormatters,
        style: TextStyle(color: ColorsManager.white),
        decoration: InputDecoration(
          errorStyle: GoogleFonts.roboto(fontSize: 14.sp, color: Colors.red),
          prefixText: prefixText,
          labelText: labelText,
          prefixIcon: prefixIcon,
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: onVisibilityClick,
                  icon: Icon(
                    obscureText
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                  ),
                )
              : null,
          contentPadding: REdgeInsets.symmetric(vertical: 14, horizontal: 0),
        ),
      ),
    );
  }
}
