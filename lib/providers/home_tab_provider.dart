import 'package:flutter/material.dart';
import 'package:movies/data/api_services/api_services.dart';

import '../data/models/movies_response/movie.dart';
import '../data/result/result.dart';

class HomeTabProvider extends ChangeNotifier {
  MoviesState trendingState = MoviesLoadingState();
  MoviesState firstRecommendationState = MoviesLoadingState();
  MoviesState secondRecommendationState = MoviesLoadingState();
  MoviesState thirdRecommendationState = MoviesLoadingState();

  void emitTrending(MoviesState newState) {
    trendingState = newState;
    notifyListeners();
  }

  Future<void> getTrendingMoviesList({
    int? page,
    String? sort,
    String? genre,
  }) async
  {
    if (trendingState.runtimeType != MoviesLoadingState) {
      emitTrending(MoviesLoadingState());
    }
    Result<List<Movie>> result = await ApiServices.getMoviesList(
      page: page,
      sort: sort,
      genre: genre,
    );
    switch (result) {
      case Success<List<Movie>>():
        emitTrending(MoviesSuccessState(movies: result.data));
      case ServerError<List<Movie>>():
        emitTrending(MoviesErrorState(serverError: result));
      case GeneralException<List<Movie>>():
        emitTrending(MoviesErrorState(exception: result.exception));
    }
  }

  Future<void> getFirstRecommendedMoviesList({String? genre}) async {
    print(genre);
    if (firstRecommendationState != MoviesLoadingState()) {
      firstRecommendationState = MoviesLoadingState();
      notifyListeners();
    }
    final movies = await ApiServices.getMoviesList(genre: genre);

    switch (movies) {
      case Success<List<Movie>>():
        firstRecommendationState = MoviesSuccessState(movies: movies.data);
      case ServerError<List<Movie>>():
        firstRecommendationState = MoviesErrorState(serverError: movies);
      case GeneralException<List<Movie>>():
        firstRecommendationState = MoviesErrorState(
          exception: movies.exception,
        );
    }
    notifyListeners();
  }

  Future<void> getSecondRecommendedMoviesList({String? genre}) async {
    print(genre);
    if (secondRecommendationState != MoviesLoadingState()) {
      secondRecommendationState = MoviesLoadingState();
      notifyListeners();
    }
    final movies = await ApiServices.getMoviesList(genre: genre);

    switch (movies) {
      case Success<List<Movie>>():
        secondRecommendationState = MoviesSuccessState(movies: movies.data);
      case ServerError<List<Movie>>():
        secondRecommendationState = MoviesErrorState(serverError: movies);
      case GeneralException<List<Movie>>():
        secondRecommendationState = MoviesErrorState(
          exception: movies.exception,
        );
    }
    notifyListeners();
  }

  Future<void> getThirdRecommendedMoviesList({String? genre}) async {
    print(genre);
    if (thirdRecommendationState != MoviesLoadingState()) {
      thirdRecommendationState = MoviesLoadingState();
      notifyListeners();
    }
    final movies = await ApiServices.getMoviesList(genre: genre);

    switch (movies) {
      case Success<List<Movie>>():
        thirdRecommendationState = MoviesSuccessState(movies: movies.data);
      case ServerError<List<Movie>>():
        thirdRecommendationState = MoviesErrorState(serverError: movies);
      case GeneralException<List<Movie>>():
        thirdRecommendationState =
            MoviesErrorState(exception: movies.exception);
    }
    notifyListeners();
  }
}

sealed class MoviesState {}

class MoviesSuccessState extends MoviesState {
  List<Movie> movies;

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
