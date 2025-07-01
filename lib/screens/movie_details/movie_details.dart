import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:movies/core/assets_manager/assets_manager.dart';
import 'package:movies/core/colors_manager/colors_Manager.dart';
import 'package:movies/core/extension/context_extension.dart';
import 'package:movies/core/widgets/animated_image_gradient_container.dart';
import 'package:movies/core/widgets/custom_button.dart';
import 'package:movies/core/widgets/error_state_widget.dart';
import 'package:movies/core/widgets/suggestion_grid.dart';
import 'package:movies/providers/home_tab_provider.dart';
import 'package:movies/providers/movie_details_provider.dart';
import 'package:movies/screens/movie_details/widgets/cast_item.dart';
import 'package:movies/screens/movie_details/widgets/custom_chip.dart';
import 'package:provider/provider.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({super.key, required this.id});

  final String id;

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  late MovieDetailsProvider movieDetailsProvider;

  void _loadData() async {
    movieDetailsProvider = MovieDetailsProvider();
    await movieDetailsProvider.getMovieDetails(id: widget.id);
    if (movieDetailsProvider.movieDetailsState.runtimeType ==
        MovieDetailsSuccessState) {
      await movieDetailsProvider.getMovieSuggestionList(id: widget.id);
      await movieDetailsProvider.isFavCheck(id: widget.id);
    } else {
      movieDetailsProvider.setErrorState();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Widget isFavButton() {
    return Consumer<MovieDetailsProvider>(
      builder: (_, provider, __) {
        if (provider.isFavCheckLoading) {
          return Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        }

        if (provider.fetchedError) {
          return const SizedBox.shrink();
        }

        return IconButton(
          onPressed: () {
            final movie =
                (provider.movieDetailsState as MovieDetailsSuccessState).movie;
            if (!provider.isFav) {
              provider.addToFavourites(
                id: movie.id.toString(),
                name: movie.title ?? '',
                imageUrl: movie.largeCoverImage ?? '',
                year: movie.year.toString(),
                rating: double.parse(movie.rating.toString()),
              );
            } else {
              (provider.movieDetailsState as MovieDetailsSuccessState).movie;
              movieDetailsProvider.removeFromFavourites(
                  id: movie.id.toString());
            }
          },
          icon: Icon(
            provider.isFav
                ? Icons.bookmark_rounded
                : Icons.bookmark_outline_rounded,
            color: ColorsManager.white,
            size: 30,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MovieDetailsProvider>.value(
      value: movieDetailsProvider,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              size: 30,
              color: ColorsManager.white,
            ),
          ),
          actions: [isFavButton()],
        ),
        body: CustomScrollView(
          slivers: [
            Consumer<MovieDetailsProvider>(
              builder: (_, movieSuggestion, _) {
                final state = movieSuggestion.movieDetailsState;
                switch (state) {
                  case MovieDetailsSuccessState():
                    return state.movie.id != 0
                        ? SliverToBoxAdapter(
                      child: Stack(
                        children: [
                          AnimatedImageGradientContainer(
                            imageUrl: state.movie.largeCoverImage!,
                          ),
                          Padding(
                            padding: REdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  width: context.width,
                                  height: context.height * 0.5,
                                  child: Center(
                                    child: SvgPicture.asset(
                                      SvgIcons.play,
                                      height: 100.r,
                                    ),
                                  ),
                                ),
                                Text(
                                  state.movie.title!,
                                  textAlign: TextAlign.center,
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(fontSize: 24.sp),
                                ),
                                Text(
                                  state.movie.year.toString(),
                                  textAlign: TextAlign.center,
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                    color: ColorsManager.gray,
                                    height: 3.h,
                                  ),
                                ),
                                CustomButton(
                                  text: 'Watch',
                                  onTap: () {},
                                  backgroundColor: Colors.red,
                                  foregroundColor: ColorsManager.white,
                                  borderColor: Colors.red,
                                ),
                                SizedBox(height: 16.h),
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 16.w,
                                  runSpacing: 10.h,
                                  children: [
                                    CustomChip(
                                      text: state.movie.likeCount
                                          .toString(),
                                      svgIconPath: SvgIcons.heart,
                                    ),
                                    CustomChip(
                                      text: state.movie.runtime
                                          .toString(),
                                      svgIconPath: SvgIcons.time,
                                    ),
                                    CustomChip(
                                      text: state.movie.rating.toString(),
                                      svgIconPath: SvgIcons.star,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  'Screen Shoots',
                                  style: Theme
                                      .of(
                                    context,
                                  )
                                      .textTheme
                                      .labelMedium,
                                ),
                                SizedBox(height: 20.h),
                                ClipRRect(
                                  borderRadius:
                                  BorderRadiusGeometry.circular(16.r),
                                  child: Image.network(
                                    state.movie.largeScreenshotImage1!,
                                  ),
                                ),
                                SizedBox(height: 14.h),
                                ClipRRect(
                                  borderRadius:
                                  BorderRadiusGeometry.circular(16.r),
                                  child: Image.network(
                                    state.movie.largeScreenshotImage2!,
                                  ),
                                ),
                                SizedBox(height: 14.h),
                                ClipRRect(
                                  borderRadius:
                                  BorderRadiusGeometry.circular(16.r),
                                  child: Image.network(
                                    state.movie.largeScreenshotImage3!,
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  'Similar',
                                  style: Theme
                                      .of(
                                    context,
                                  )
                                      .textTheme
                                      .labelMedium,
                                ),
                                SizedBox(height: 20.h),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                        : SliverToBoxAdapter(
                      child: SafeArea(
                        child: Padding(
                          padding: REdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Bad Data from Server 💀💀',
                                textAlign: TextAlign.center,
                                style: Theme
                                    .of(
                                  context,
                                )
                                    .textTheme
                                    .titleLarge,
                              ),
                              Lottie.asset(
                                'assets/animations/popcorn.json',
                                reverse: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  case MovieDetailsLoadingState():
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: context.width * 0.5,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    );
                  case MovieDetailsErrorState():
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: context.width * 0.5,
                        child: ErrorStateWidget(
                          serverError: state.serverError,
                          exception: state.exception,
                        ),
                      ),
                    );
                }
              },
            ),
            Consumer<MovieDetailsProvider>(
              builder: (_, moviesSuggestions, _) {
                var state = moviesSuggestions.moviesSuggestionState;
                switch (state) {
                  case MoviesSuccessState():
                    return SliverPadding(
                      padding: REdgeInsets.symmetric(horizontal: 16),
                      sliver: suggestionGrid(movies: state.movies),
                    );
                  case MoviesLoadingState():
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: context.height * 0.5,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    );
                  case MoviesErrorState():
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: context.height * 0.5,
                        child: ErrorStateWidget(
                          serverError: state.serverError,
                          exception: state.exception,
                        ),
                      ),
                    );
                }
              },
            ),
            Consumer<MovieDetailsProvider>(
              builder: (_, movieSuggestion, _) {
                final state = movieSuggestion.movieDetailsState;
                switch (state) {
                  case MovieDetailsSuccessState():
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: REdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 20.h),
                            Text(
                              'Summary',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .labelMedium,
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              state.movie.descriptionFull ?? '',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodySmall,
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              'Cast',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .labelMedium,
                            ),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    );
                  case MovieDetailsLoadingState():
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: context.height * 0.5,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    );
                  case MovieDetailsErrorState():
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: context.height * 0.5,
                        child: ErrorStateWidget(
                          serverError: state.serverError,
                          exception: state.exception,
                        ),
                      ),
                    );
                }
              },
            ),
            Consumer<MovieDetailsProvider>(
              builder: (_, movieSuggestion, _) {
                final state = movieSuggestion.movieDetailsState;
                switch (state) {
                  case MovieDetailsSuccessState():
                    return state.movie.cast != null
                        ? SliverPadding(
                      padding: REdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList.separated(
                        itemBuilder: (_, index) {
                          return CastItem(
                            movieCast: state.movie.cast![index],
                          );
                        },
                        separatorBuilder: (_, _) {
                          return SizedBox(height: 8.h);
                        },
                        itemCount: state.movie.cast!.length,
                      ),
                    )
                        : SliverToBoxAdapter(
                      child: Lottie.asset(
                        'assets/animations/popcorn.json',
                        reverse: true,
                      ),
                    );
                  case MovieDetailsLoadingState():
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: context.height * 0.5,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    );
                  case MovieDetailsErrorState():
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: context.height * 0.5,
                        child: ErrorStateWidget(
                          serverError: state.serverError,
                          exception: state.exception,
                        ),
                      ),
                    );
                }
              },
            ),
            Consumer<MovieDetailsProvider>(
              builder: (_, movieDetails, _) {
                final state = movieDetails.movieDetailsState;
                switch (state) {
                  case MovieDetailsSuccessState():
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: REdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: Theme
                              .of(context)
                              .bottomAppBarTheme
                              .height!,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 20.h),
                            Text(
                              'Genres',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .labelMedium,
                            ),
                            SizedBox(height: 20.h),
                            Wrap(
                              alignment: WrapAlignment.start,
                              spacing: 16.w,
                              runSpacing: 10.h,
                              children: state.movie.genres!
                                  .map((genre) => Chip(label: Text(genre)))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    );
                  case MovieDetailsLoadingState():
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: context.height * 0.5,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    );
                  case MovieDetailsErrorState():
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: context.height * 0.5,
                        child: ErrorStateWidget(
                          serverError: state.serverError,
                          exception: state.exception,
                        ),
                      ),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
