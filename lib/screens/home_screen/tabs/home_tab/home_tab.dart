import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/assets_manager/assets_manager.dart';
import 'package:movies/core/colors_manager/colors_Manager.dart';
import 'package:movies/core/constants_manager/constants_manager.dart';
import 'package:movies/core/extension/context_extension.dart';
import 'package:movies/core/widgets/animated_image_gradient_container.dart';
import 'package:movies/core/widgets/custom_carousel_slider.dart';
import 'package:movies/core/widgets/error_state_widget.dart';
import 'package:movies/core/widgets/movie_card.dart';
import 'package:movies/core/widgets/recommendation_movies.dart';
import 'package:movies/providers/home_tab_provider.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late HomeTabProvider _moviesProvider;
  List<String> shuffledGenres = [...ConstantsManager.genres]..shuffle();

  int currentMovie = 0;

  void loadMovies() async {
    _moviesProvider = HomeTabProvider();
    await _moviesProvider.getTrendingMoviesList();
    await _moviesProvider.getFirstRecommendedMoviesList(
      genre: shuffledGenres[0],
    );
    await _moviesProvider.getSecondRecommendedMoviesList(
      genre: shuffledGenres[1],
    );
    await _moviesProvider.getThirdRecommendedMoviesList(
      genre: shuffledGenres[2],
    );
  }

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _moviesProvider,
      child: ListView(
        children: [
          Consumer<HomeTabProvider>(
            builder: (context, moviesProvider, child) {
              MoviesState state = moviesProvider.trendingState;
              switch (state) {
                case MoviesSuccessState():
                  return SizedBox(
                    height: context.height * 0.72,
                    child: Stack(
                      children: [
                        AnimatedImageGradientContainer(
                          imageUrl:
                          state.movies[currentMovie].largeCoverImage!,
                        ),
                        Column(
                          children: [
                            Image.asset(
                              AssetsManager.availableNow,
                              width: 260.w,
                            ),
                            CustomCarouselSlider(
                              items: state.movies
                                  .map(
                                    (movie) =>
                                    MovieCard(
                                      imageUrl: movie.mediumCoverImage!,
                                      rating: movie.rating,
                                      id: movie.id.toString(),
                                      radius: 20.r,
                                      fit: BoxFit.fill,
                                    ),
                              )
                                  .toList(),
                              onPageChanged: (index, _) {
                                setState(() {
                                  currentMovie = index;
                                });
                              },
                            ),
                            Image.asset(AssetsManager.watchNow, width: 350.w),
                          ],
                        ),
                      ],
                    ),
                  );
                case MoviesLoadingState():
                  return SizedBox(
                    height: 100.h,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: ColorsManager.yellow,
                      ),
                    ),
                  );
                case MoviesErrorState():
                  return ErrorStateWidget(
                    serverError: state.serverError,
                    exception: state.exception,
                  );
              }
            },
          ),
          Consumer<HomeTabProvider>(
            builder: (_, provider, _) {
              var state = provider.firstRecommendationState;
              switch (state) {
                case MoviesSuccessState():
                  return RecommendationMovies(
                      movies: state.movies, title: shuffledGenres[0]);
                case MoviesLoadingState():
                  return SizedBox(height: 100.h,
                      child: Center(child: CircularProgressIndicator()));
                case MoviesErrorState():
                  return ErrorStateWidget(
                    serverError: state.serverError,
                    exception: state.exception,
                  );
              }
            },
          ),
          Consumer<HomeTabProvider>(
            builder: (_, provider, _) {
              var state = provider.secondRecommendationState;
              switch (state) {
                case MoviesSuccessState():
                  return RecommendationMovies(
                      movies: state.movies, title: shuffledGenres[1]);
                case MoviesLoadingState():
                  return SizedBox(height: 100.h,
                      child: Center(child: CircularProgressIndicator()));
                case MoviesErrorState():
                  return ErrorStateWidget(
                    serverError: state.serverError,
                    exception: state.exception,
                  );
              }
            },
          ),
          Consumer<HomeTabProvider>(
            builder: (_, provider, _) {
              var state = provider.thirdRecommendationState;
              switch (state) {
                case MoviesSuccessState():
                  return RecommendationMovies(
                      movies: state.movies, title: shuffledGenres[2]);
                case MoviesLoadingState():
                  return SizedBox(height: 100,
                      child: Center(child: CircularProgressIndicator()));
                case MoviesErrorState():
                  return ErrorStateWidget(
                    serverError: state.serverError,
                    exception: state.exception,
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}
