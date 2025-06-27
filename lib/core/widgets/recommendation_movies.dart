import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/core/extension/context_extension.dart';
import 'package:movies/core/widgets/error_state_widget.dart';
import 'package:provider/provider.dart';

import '../../providers/movies_provider.dart';
import '../colors_manager/colors_Manager.dart';

class RecommendationMovies extends StatelessWidget {
  const RecommendationMovies({
    super.key,
    required this.title,
    required this.sectionKey,
  });

  final String sectionKey;
  final String title;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MoviesProvider>(context);
    final state = provider.recommendedStates[sectionKey];
    final movies = provider.recommendedLists[sectionKey] ?? [];
    switch (state) {
      case MoviesSuccessState():
        return Column(
          children: [
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      fontSize: 20.sp,
                      color: ColorsManager.white,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'See More →',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: ColorsManager.yellow,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.height * 0.24,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: REdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  return Container(
                    alignment: Alignment.topLeft,
                    padding: REdgeInsets.all(14),
                    width: 146.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: NetworkImage(movies[index].mediumCoverImage!),
                      ),
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      margin: EdgeInsets.zero,
                      color: ColorsManager.black.withValues(alpha: 0.29),
                      child: Padding(
                        padding: REdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              movies[index].rating.toString(),
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                color: ColorsManager.white,
                              ),
                            ),
                            Icon(
                              Icons.star,
                              color: ColorsManager.yellow,
                              size: 15.r,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(width: 16.w);
                },
                itemCount: movies.length,
              ),
            ),
          ],
        );
      case MoviesLoadingState():
        return Center(
          child: CircularProgressIndicator(color: ColorsManager.yellow),
        );
      case MoviesErrorState():
        return ErrorStateWidget(
          serverError: state.serverError,
          exception: state.exception,
        );
      case null:
        return Center(
          child: CircularProgressIndicator(color: ColorsManager.yellow),
        );
    }
  }
}
