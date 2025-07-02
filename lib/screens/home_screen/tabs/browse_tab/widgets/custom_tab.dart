import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/colors_manager/colors_Manager.dart';

class CustomTab extends StatelessWidget {
  const CustomTab({super.key, required this.text, required this.isSelected});

  final String text;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: BoxBorder.all(color: ColorsManager.yellow, width: 2),
        borderRadius: BorderRadius.circular(16.r),
        color: isSelected ? ColorsManager.yellow : ColorsManager.transparent,
      ),
      padding: REdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Text(text),
    );
  }
}
