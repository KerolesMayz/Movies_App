import 'package:flutter/material.dart';
import 'package:movies/data/api_services/api_services.dart';
import 'package:movies/data/models/Movies.dart';

import '../data/result/result.dart';

class MoviesProvider extends ChangeNotifier {
  MoviesState trendingState = MoviesLoadingState();
  Map<String, MoviesState> recommendedStates = {};
  Map<String, List<Movies>> recommendedLists = {};

  void emitTrending(MoviesState newState) {
    trendingState = newState;
    notifyListeners();
  }

  void emitRecommended(String sectionKey, MoviesState newState) {
    recommendedStates[sectionKey] = newState;
    notifyListeners();
  }

  Future<void> getTrendingMoviesList({
    int? page,
    String? sort,
    String? genre,
  }) async {
    if (trendingState.runtimeType != MoviesLoadingState) {
      emitTrending(MoviesLoadingState());
    }
    Result<List<Movies>> result = await ApiServices.getMoviesList(
      page: page,
      sort: sort,
      genre: genre,
    );
    switch (result) {
      case Success<List<Movies>>():
        emitTrending(MoviesSuccessState(movies: result.data));
      case ServerError<List<Movies>>():
        emitTrending(MoviesErrorState(serverError: result));
      case GeneralException<List<Movies>>():
        emitTrending(MoviesErrorState(exception: result.exception));
    }
  }

  Future<void> getRecommendedMoviesList({
    required String sectionKey,
    String? genre,
  }) async {
    final movies = await ApiServices.getMoviesList(genre: genre);

    switch (movies) {
      case Success<List<Movies>>():
        recommendedLists[sectionKey] = movies.data;
        emitRecommended(sectionKey, MoviesSuccessState(movies: movies.data));
      case ServerError<List<Movies>>():
        emitRecommended(sectionKey, MoviesErrorState(serverError: movies));
      case GeneralException<List<Movies>>():
        emitRecommended(
          sectionKey,
          MoviesErrorState(exception: movies.exception),
        );
    }
    notifyListeners();
  }
}

sealed class MoviesState {}

class MoviesSuccessState extends MoviesState {
  List<Movies> movies;

  MoviesSuccessState({required this.movies});
}

class MoviesLoadingState extends MoviesState {
  String? loadingMsg;

  MoviesLoadingState({this.loadingMsg});
}

class MoviesErrorState extends MoviesState {
  ServerError? serverError;
  Exception? exception;

  MoviesErrorState({this.serverError, this.exception});
}
