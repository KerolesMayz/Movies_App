import 'package:flutter/cupertino.dart';
import 'package:movies/data/api_services/api_services.dart';

import '../data/models/profile_response/Profile_response.dart';
import '../data/models/watch_list_response/favourite_movie.dart';
import '../data/result/result.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileState profileState = ProfileLoadingState();
  FavouritesState favouritesState = FavouritesLoadingState();

  void emitProfile(ProfileState newState) {
    profileState = newState;
    notifyListeners();
  }

  void emitFavourites(FavouritesState newState) {
    favouritesState = newState;
    notifyListeners();
  }

  Future<void> getFavourites() async {
    if (favouritesState != FavouritesLoadingState()) {
      emitFavourites(FavouritesLoadingState());
    }
    Result<List<FavouriteMovie>> result =
        await ApiServices.getUserFavouritesList();
    switch (result) {
      case Success<List<FavouriteMovie>>():
        emitFavourites(FavouritesSuccessState(data: result.data));
      case ServerError<List<FavouriteMovie>>():
        emitFavourites(FavouritesErrorState(serverError: result));
      case GeneralException<List<FavouriteMovie>>():
        emitFavourites(FavouritesErrorState(exception: result.exception));
    }
  }

  Future<void> getProfile() async {
    if (profileState != ProfileLoadingState()) {
      emitProfile(ProfileLoadingState());
    }
    Result<ProfileResponse> result = await ApiServices.getUserProfile();
    switch (result) {
      case Success<ProfileResponse>():
        emitProfile(ProfileSuccessState());
      case ServerError<ProfileResponse>():
        emitProfile(ProfileErrorState(serverError: result));
      case GeneralException<ProfileResponse>():
        emitProfile(ProfileErrorState(exception: result.exception));
    }
  }
}

sealed class ProfileState {}

class ProfileSuccessState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileErrorState extends ProfileState {
  ServerError? serverError;
  Exception? exception;

  ProfileErrorState({this.serverError, this.exception});
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
