import 'package:flutter/material.dart';
import 'package:movies/data/models/watch_list_response/favourite_movie.dart';

import '../data/api_services/api_services.dart';
import '../data/result/result.dart';

class FavouritesProvider extends ChangeNotifier {
  FavouritesState state = FavouritesLoadingState();

  void emit(FavouritesState newState) {
    state = newState;
    notifyListeners();
  }

  Future<void> getProfile() async {
    if (state != FavouritesLoadingState()) {
      emit(FavouritesLoadingState());
    }
    Result<List<FavouriteMovie>> result =
        await ApiServices.getUserFavouritesList();
    switch (result) {
      case Success<List<FavouriteMovie>>():
        emit(FavouritesSuccessState(data: result.data));
      case ServerError<List<FavouriteMovie>>():
        emit(FavouritesErrorState(serverError: result));
      case GeneralException<List<FavouriteMovie>>():
        emit(FavouritesErrorState(exception: result.exception));
    }
  }
}

sealed class FavouritesState {}

class FavouritesSuccessState extends FavouritesState {
  List<FavouriteMovie> data;

  FavouritesSuccessState({required this.data});
}

class FavouritesLoadingState extends FavouritesState {}

class FavouritesErrorState extends FavouritesState {
  ServerError? serverError;
  Exception? exception;

  FavouritesErrorState({this.serverError, this.exception});
}
