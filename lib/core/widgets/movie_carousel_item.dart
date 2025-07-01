import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/core/colors_manager/colors_Manager.dart';

import '../../data/models/movies_response/movie.dart';

class MovieCarouselItem extends StatelessWidget {
  const MovieCarouselItem({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Image.network(
            movie.mediumCoverImage!,
            fit: BoxFit.fitHeight,
          ),
        ),
        Padding(
          padding: REdgeInsets.all(10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            margin: EdgeInsets.zero,
            color: ColorsManager.black.withValues(alpha: 0.29),
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${movie.rating.toString()} ',
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
        ),
      ],
    );
  }
}
