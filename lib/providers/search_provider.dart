import 'package:flutter/material.dart';

import '../data/api_services/api_services.dart';
import '../data/models/movies_response/movie.dart';
import '../data/result/result.dart';
import 'home_tab_provider.dart';

class SearchProvider extends ChangeNotifier {
  List<Movie> movies = [];
  MoviesState moviesState = MoviesLoadingState();

  Future<void> getSearchedList({
    required String query,
    required int page,
  }) async {
    if (moviesState is! MoviesLoadingState && page == 1) {
      emit(MoviesLoadingState());
    }
    Result<List<Movie>> result = await ApiServices.getMoviesList(
      query: query,
      page: page,
    );
    switch (result) {
      case Success<List<Movie>>():
        if (page == 1) {
          movies = result.data;
        } else {
          movies.addAll(result.data);
        }
        emit(MoviesSuccessState(movies: result.data));
      case ServerError<List<Movie>>():
        emit(MoviesErrorState(serverError: result));
      case GeneralException<List<Movie>>():
        emit(MoviesErrorState(exception: result.exception));
    }
  }

  void emit(MoviesState newState) {
    moviesState = newState;
    notifyListeners();
  }
}
