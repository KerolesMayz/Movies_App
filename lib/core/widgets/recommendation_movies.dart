import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/core/constants_manager/constants_manager.dart';
import 'package:movies/core/widgets/movie_card.dart';
import 'package:movies/data/models/movies_response/movie.dart';
import 'package:movies/screens/home_screen/tabs/browse_tab/browse_tab.dart';
import 'package:provider/provider.dart';

import '../../providers/home_screen_provider.dart';
import '../colors_manager/colors_Manager.dart';

class RecommendationMovies extends StatelessWidget {
  const RecommendationMovies({
    super.key,
    required this.movies,
    required this.title,
  });

  final String title;
  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
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
                onTap: () {
                  Provider.of<HomeScreenProvider>(
                    context,
                    listen: false,
                  ).navigateToTab(
                    BrowseTab(
                      initialTap: ConstantsManager.genres.indexOf(title),
                    ),
                    2,
                  );
                },
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
          height: 220.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: REdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              return MovieCard(
                imageUrl: movies[index].mediumCoverImage!,
                rating: movies[index].rating,
                id: movies[index].id.toString(),
                width: 146.w,
                fit: BoxFit.fill,
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
  }
}
