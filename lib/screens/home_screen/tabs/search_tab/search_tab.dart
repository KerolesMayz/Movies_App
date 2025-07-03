import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:movies/core/assets_manager/assets_manager.dart';
import 'package:movies/core/widgets/custom_text_form_field.dart';
import 'package:movies/providers/home_tab_provider.dart';
import 'package:movies/providers/search_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/error_state_widget.dart';
import '../../../../core/widgets/movie_card.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  String _query = '0';
  int _page = 1;
  late SearchProvider _searchProvider;
  bool _isLoading = false;
  late ScrollController _controller;

  void listener() async {
    if (_isLoading) return;
    if (_controller.position.pixels >=
            _controller.position.maxScrollExtent - 200 &&
        _searchProvider.moviesState is MoviesSuccessState) {
      if (_searchProvider.moviesState is MoviesSuccessState) {
        setState(() {
          _isLoading = true;
        });
        _page++;
        await _searchProvider.getSearchedList(query: _query, page: _page);
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _searchProvider = SearchProvider();
    _searchProvider.getSearchedList(query: _query, page: _page);
    _controller.addListener(listener);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _searchProvider.dispose();
  }

  void search(String value) async {
    _query = value;
    _page = 1;
    await _searchProvider.getSearchedList(query: _query, page: _page);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _searchProvider,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: CustomTextFormField(
                onChanged: search,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(14),
                  child: SvgPicture.asset(SvgIcons.search, height: 24.r),
                ),
                prefixIconConstraints: BoxConstraints(
                  minHeight: 30.r,
                  minWidth: 30.r,
                ),
                hintText: 'Search',
              ),
            ),
            Consumer<SearchProvider>(
              builder: (_, searchProvider, _) {
                var state = searchProvider.moviesState;
                switch (state) {
                  case MoviesSuccessState():
                    return searchProvider.movies.isNotEmpty
                        ? Expanded(
                            child: GridView.builder(
                              controller: _controller,
                              padding: REdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 6,
                              ),
                              itemCount: _isLoading
                                  ? searchProvider.movies.length % 2 == 0
                                        ? searchProvider.movies.length + 2
                                        : searchProvider.movies.length + 1
                                  : searchProvider.movies.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 16.h,
                                    crossAxisSpacing: 16.w,
                                    childAspectRatio: 12 / 17,
                                    crossAxisCount: 2,
                                  ),
                              itemBuilder: (_, index) {
                                return index < searchProvider.movies.length
                                    ? MovieCard(
                                        width: 190.w,
                                        imageUrl: searchProvider
                                            .movies[index]
                                            .mediumCoverImage!,
                                        rating: searchProvider
                                            .movies[index]
                                            .rating!,
                                        id: searchProvider.movies[index].id
                                            .toString(),
                                      )
                                    : Center(
                                        child: Lottie.asset(
                                          'assets/animations/amogus.json',
                                        ),
                                      );
                              },
                            ),
                          )
                        : Expanded(
                            child: Padding(
                              padding: REdgeInsets.all(16),
                              child: Center(
                                child: Text(
                                  'No Movies Where Found 😪',
                                  style: Theme.of(context).textTheme.titleLarge,
                                  textAlign: TextAlign.center,
                                ),
                              ),
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
