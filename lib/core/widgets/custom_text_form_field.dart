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
    this.onChanged,
    this.hintText,
    this.prefixIconConstraints
  });

  final TextEditingController? controller;
  final int? maxLength;
  final bool obscureText;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final bool isPassword;
  final VoidCallback? onVisibilityClick;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final String? prefixText;
  final BoxConstraints? prefixIconConstraints;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      maxLength: maxLength,
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      style: GoogleFonts.roboto(
        fontSize: 16.sp,
        color: ColorsManager.white,
        fontWeight: FontWeight.w400,
      ),
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIconConstraints: prefixIconConstraints,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(16.r)
        ),
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
      ),
    );
  }
}
