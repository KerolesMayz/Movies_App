import 'package:flutter/cupertino.dart';
import 'package:movies/data/api_services/api_services.dart';

import '../data/models/profile_response/Profile_response.dart';
import '../data/result/result.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileState profileState = ProfileLoadingState();

  void emit(ProfileState newState) {
    profileState = newState;
    notifyListeners();
  }

  Future<void> getProfile() async {
    if (profileState != ProfileLoadingState()) {
      emit(ProfileLoadingState());
    }
    Result<ProfileResponse> result = await ApiServices.getUserProfile();
    switch (result) {
      case Success<ProfileResponse>():
        emit(ProfileSuccessState());
      case ServerError<ProfileResponse>():
        emit(ProfileErrorState(serverError: result));
      case GeneralException<ProfileResponse>():
        emit(ProfileErrorState(exception: result.exception));
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
