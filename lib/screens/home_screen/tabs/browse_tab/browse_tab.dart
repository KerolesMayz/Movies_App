import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:movies/core/colors_manager/colors_Manager.dart';
import 'package:movies/core/constants_manager/constants_manager.dart';
import 'package:movies/core/widgets/error_state_widget.dart';
import 'package:movies/providers/explore_tab_provider.dart';
import 'package:movies/providers/home_tab_provider.dart';
import 'package:movies/screens/home_screen/tabs/browse_tab/widgets/custom_tab.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/movie_card.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({super.key});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  int currentTab = 0;
  int page = 1;
  bool isLoading = false;
  late ExploreTabProvider exploreTabProvider;
  late ScrollController controller;

  void listener() async {
    if (isLoading) return;
    if (controller.position.pixels >=
            controller.position.maxScrollExtent - 200 &&
        exploreTabProvider.moviesState is MoviesSuccessState) {
      if (exploreTabProvider.moviesState is MoviesSuccessState) {
        setState(() {
          isLoading = true;
        });
        page++;
        await exploreTabProvider.getMoviesList(
          page: page,
          genre: ConstantsManager.genres[currentTab],
        );
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    exploreTabProvider = ExploreTabProvider();
    exploreTabProvider.getMoviesList(
      page: page,
      genre: ConstantsManager.genres[currentTab],
    );
    controller.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ExploreTabProvider>.value(
      value: exploreTabProvider,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            DefaultTabController(
              length: ConstantsManager.genres.length,
              child: TabBar(
                padding: REdgeInsets.symmetric(horizontal: 8, vertical: 10),
                indicatorWeight: 0.1,
                dividerHeight: 0,
                labelPadding: REdgeInsets.symmetric(horizontal: 8),
                tabAlignment: TabAlignment.start,
                onTap: (value) async {
                  setState(() {
                    currentTab = value;
                    page = 1;
                    exploreTabProvider.getMoviesList(
                      page: page,
                      genre: ConstantsManager.genres[currentTab],
                    );
                  });
                },
                labelColor: ColorsManager.black,
                unselectedLabelColor: ColorsManager.yellow,
                labelStyle: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                ),
                indicatorColor: ColorsManager.transparent,
                isScrollable: true,
                tabs: ConstantsManager.genres
                    .map(
                      (genre) => CustomTab(
                        text: genre,
                        isSelected:
                            currentTab ==
                            ConstantsManager.genres.indexOf(genre),
                      ),
                    )
                    .toList(),
              ),
            ),
            Consumer<ExploreTabProvider>(
              builder: (_, provider, _) {
                var state = provider.moviesState;
                switch (state) {
                  case MoviesSuccessState():
                    return Expanded(
                      child: GridView.builder(
                        controller: controller,
                        padding: REdgeInsets.all(16),
                        itemCount: isLoading
                            ? provider.movies.length % 2 == 0
                                  ? provider.movies.length + 2
                                  : provider.movies.length + 1
                            : provider.movies.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 16.h,
                          crossAxisSpacing: 16.w,
                          childAspectRatio: 12 / 17,
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (_, index) {
                          return index < provider.movies.length
                              ? MovieCard(
                                  width: 190.w,
                                  imageUrl:
                                      provider.movies[index].mediumCoverImage!,
                                  rating: provider.movies[index].rating!,
                                  id: provider.movies[index].id.toString(),
                                )
                              : Center(
                                  child: Lottie.asset(
                                    'assets/animations/amogus.json',
                                  ),
                                );
                        },
                      ),
                    );
                  case MoviesLoadingState():
                    return Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    );
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
      ),
    );
  }
}
