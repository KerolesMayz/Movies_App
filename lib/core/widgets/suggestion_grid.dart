import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/data/models/movies_response/movie.dart';

import 'movie_card.dart';

SliverGrid suggestionGrid({required List<Movie> movies}) {
  return SliverGrid.builder(
    itemCount: movies.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      mainAxisSpacing: 16.h,
      crossAxisSpacing: 16.w,
      childAspectRatio: 12 / 17,
      crossAxisCount: 2,
    ),
    itemBuilder: (_, index) {
      return MovieCard(
        imageUrl: movies[index].mediumCoverImage!,
        rating: movies[index].rating!,
        id: movies[index].id.toString(),
        fit: BoxFit.fill,
      );
    },
  );
}
