import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors_manager/colors_Manager.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.imageUrl,
    required this.rating,
    this.width,
    this.fit,
    this.radius = 16,
    required this.id,
  });

  final String imageUrl;
  final dynamic rating;
  final double? width;
  final BoxFit? fit;
  final double radius;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      width: width,
      padding: REdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        image: DecorationImage(fit: fit, image: NetworkImage(imageUrl)),
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        margin: EdgeInsets.zero,
        color: ColorsManager.black.withValues(alpha: 0.29),
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                rating.toString(),
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  color: ColorsManager.white,
                ),
              ),
              Icon(Icons.star, color: ColorsManager.yellow, size: 15.r),
            ],
          ),
        ),
      ),
    );
  }
}
