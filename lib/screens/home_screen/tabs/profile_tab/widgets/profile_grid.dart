import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/widgets/movie_card.dart';
import 'package:movies/data/models/watch_list_response/favourite_movie.dart';

class ProfileGrid extends StatelessWidget {
  const ProfileGrid({super.key, required this.favMovies});

  final List<FavouriteMovie> favMovies;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 24.h,
        bottom: Theme.of(context).bottomAppBarTheme.height!,
      ),
      itemCount: favMovies.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 8.h,
        crossAxisSpacing: 8.w,
        childAspectRatio: 12 / 18,
        crossAxisCount: 3,
      ),
      itemBuilder: (_, index) {
        return MovieCard(
          imageUrl: favMovies[index].imageURL!,
          rating: favMovies[index].rating!,
          id: favMovies[index].movieId!,
          fit: BoxFit.fill,
        );
      },
    );
  }
}
