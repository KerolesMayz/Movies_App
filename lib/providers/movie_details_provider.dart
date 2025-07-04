import 'package:flutter/widgets.dart';
import 'package:movies/data/api_services/api_services.dart';
import 'package:movies/data/models/check_favourite_response/check_is_favourite_response.dart';
import 'package:movies/providers/home_tab_provider.dart';

import '../data/models/general_response/general_response.dart';
import '../data/models/movie_details_response/movie_details.dart';
import '../data/models/movies_response/movie.dart';
import '../data/result/result.dart';

class MovieDetailsProvider extends ChangeNotifier {
  MovieDetailsState movieDetailsState = MovieDetailsLoadingState();
  MoviesState moviesSuggestionState = MoviesLoadingState();
  bool fetchedError = false;
  bool isFavCheckLoading = true;
  bool isFav = false;

  void setErrorState() {
    moviesSuggestionState = MoviesErrorState(
      serverError: ServerError(code: '', message: ''),
    );
    notifyListeners();
  }

  Future<void> isFavCheck({required String id}) async {
    if (!isFavCheckLoading) {
      isFavCheckLoading = true;
      notifyListeners();
    }
    Result<CheckIsFavouriteResponse> result = await ApiServices.checkIsFav(
      id: id,
    );
    switch (result) {
      case Success<CheckIsFavouriteResponse>():
        isFav = result.data.isFavourite!;
      case ServerError<CheckIsFavouriteResponse>():
        fetchedError = false;
      case GeneralException<CheckIsFavouriteResponse>():
        fetchedError = false;
    }
    isFavCheckLoading = false;
    notifyListeners();
  }

  Future<void> addToFavourites({
    required String id,
    required String name,
    required String imageUrl,
    required String year,
    required double rating,
  }) async {
    if (!isFavCheckLoading) {
      isFavCheckLoading = true;
      notifyListeners();
    }
    Result<GeneralResponse> result = await ApiServices.addToFav(
      id: id,
      rating: rating,
      name: name,
      imageUrl: imageUrl,
      year: year,
    );
    switch (result) {
      case Success<GeneralResponse>():
        await isFavCheck(id: id);
      case ServerError<GeneralResponse>():
        fetchedError = false;
        isFavCheckLoading = false;
        notifyListeners();
      case GeneralException<GeneralResponse>():
        fetchedError = false;
        isFavCheckLoading = false;
        notifyListeners();
    }
  }

  Future<void> removeFromFavourites({required String id}) async {
    if (!isFavCheckLoading) {
      isFavCheckLoading = true;
      notifyListeners();
    }
    Result<GeneralResponse> result = await ApiServices.removeFromFav(id: id);
    switch (result) {
      case Success<GeneralResponse>():
        await isFavCheck(id: id);
      case ServerError<GeneralResponse>():
        fetchedError = false;
        isFavCheckLoading = false;
        notifyListeners();
      case GeneralException<GeneralResponse>():
        fetchedError = false;
        isFavCheckLoading = false;
        notifyListeners();
    }
  }

  Future<void> getMovieDetails({required String id}) async {
    if (movieDetailsState != MovieDetailsLoadingState()) {
      movieDetailsState = MovieDetailsLoadingState();
      notifyListeners();
    }
    Result<MovieDetails> result = await ApiServices.getMovieDetails(id: id);
    switch (result) {
      case Success<MovieDetails>():
        movieDetailsState = MovieDetailsSuccessState(movie: result.data);
      case ServerError<MovieDetails>():
        movieDetailsState = MovieDetailsErrorState(serverError: result);
      case GeneralException<MovieDetails>():
        movieDetailsState = MovieDetailsErrorState(exception: result.exception);
    }
    notifyListeners();
  }

  Future<void> getMovieSuggestionList({required String id}) async {
    if (moviesSuggestionState != MoviesLoadingState()) {
      moviesSuggestionState = MoviesLoadingState();
      notifyListeners();
    }
    Result<List<Movie>> result = await ApiServices.getMovieSuggestionsList(
      id: id,
    );
    switch (result) {
      case Success<List<Movie>>():
        moviesSuggestionState = MoviesSuccessState(movies: result.data);
      case ServerError<List<Movie>>():
        moviesSuggestionState = MoviesErrorState(serverError: result);
      case GeneralException<List<Movie>>():
        moviesSuggestionState = MoviesErrorState(exception: result.exception);
    }
    notifyListeners();
  }
}

sealed class MovieDetailsState {}

class MovieDetailsSuccessState extends MovieDetailsState {
  MovieDetails movie;

  MovieDetailsSuccessState({required this.movie});
}

class MovieDetailsLoadingState extends MovieDetailsState {}

class MovieDetailsErrorState extends MovieDetailsState {
  ServerError? serverError;
  Exception? exception;

  MovieDetailsErrorState({this.serverError, this.exception});
}
