import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/data/models/check_favourite_response/check_is_favourite_response.dart';
import 'package:movies/data/models/login_response/Login_response.dart';
import 'package:movies/data/models/movie_details_response/movie_details.dart';
import 'package:movies/data/models/movie_details_response/movie_details_response.dart';
import 'package:movies/data/models/movie_suggestions/movie_suggestions_response.dart';
import 'package:movies/data/models/register_response/Register_response.dart';
import 'package:movies/data/models/watch_list_response/favourite_movie.dart';
import 'package:movies/data/models/watch_list_response/favourite_movies_response.dart';
import 'package:movies/data/result/result.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/resources_manager/dialog_utils.dart';
import '../../core/routes_manager/routes_manager.dart';
import '../models/general_response/general_response.dart';
import '../models/movies_response/movie.dart';
import '../models/movies_response/movies_response.dart';
import '../models/profile_response/Profile_response.dart';
import '../models/profile_response/profile_data.dart';

class ApiServices {
  static const String moviesBase = 'yts.mx';
  static const String listMovies = '/api/v2/list_movies.json';
  static const String movieDetails = '/api/v2/movie_details.json';
  static const String movieSuggestion = '/api/v2/movie_suggestions.json';
  static const String authenticationBase = 'route-movie-apis.vercel.app';
  static const String removeFromFavourites = 'favorites/remove/';
  static const String checkFavourite = 'favorites/is-favorite/';
  static const String addToFavorites = 'favorites/add';
  static const String register = 'auth/register';
  static const String login = 'auth/login';
  static const String profile = 'profile';
  static const String favourites = 'favorites/all';
  static const String resetPassword = 'auth/reset-password';

  static Future<Result<List<Movie>>> getMoviesList({
    int? page,
    String? sort,
    String? genre,
    String query = '0'
  }) async {
    Map<String, dynamic> queryParameters = {
      'limit': '10',
      'page': page.toString(),
      'sort_by': sort,
      'genre': genre,
      'query_term': query
    };
    Uri uri = Uri.https(moviesBase, listMovies, queryParameters);
    try {
      http.Response response = await http.get(uri);
      var json = jsonDecode(response.body);
      MoviesResponse moviesResponse = MoviesResponse.fromJson(json);
      if (moviesResponse.status == 'ok') {
        return Success(data: moviesResponse.data!.movies ?? []);
      } else {
        return ServerError(
          code: moviesResponse.status!,
          message: moviesResponse.statusMessage!,
        );
      }
    } on Exception catch (e) {
      return GeneralException(exception: e);
    }
  }

  static Future<Result<MovieDetails>> getMovieDetails({
    required String id,
  }) async {
    Map<String, dynamic> queryParameters = {
      'movie_id': id,
      'with_images': "true",
      'with_cast': "true",
    };
    Uri uri = Uri.https(moviesBase, movieDetails, queryParameters);
    try {
      http.Response response = await http.get(uri);
      var json = jsonDecode(response.body);
      MovieDetailsResponse movieDetailsResponse = MovieDetailsResponse.fromJson(
        json,
      );
      if (movieDetailsResponse.status == 'ok') {
        return Success(data: movieDetailsResponse.data!.movie!);
      } else {
        return ServerError(
          code: movieDetailsResponse.status!,
          message: movieDetailsResponse.statusMessage!,
        );
      }
    } on Exception catch (e) {
      return GeneralException(exception: e);
    }
  }

  static Future<Result<List<Movie>>> getMovieSuggestionsList({
    required String id,
  }) async {
    Map<String, dynamic> queryParameters = {'movie_id': id};
    Uri uri = Uri.https(moviesBase, movieSuggestion, queryParameters);
    try {
      http.Response response = await http.get(uri);
      var json = jsonDecode(response.body);
      MovieSuggestionResponse movieSuggestionResponse =
      MovieSuggestionResponse.fromJson(json);
      if (movieSuggestionResponse.status == 'ok') {
        return Success(data: movieSuggestionResponse.data!.movies!);
      } else {
        return ServerError(
          code: movieSuggestionResponse.status!,
          message: movieSuggestionResponse.statusMessage!,
        );
      }
    } on Exception catch (e) {
      return GeneralException(exception: e);
    }
  }

  static Future<Result<RegisterResponse>> registerUser({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phoneNumber,
    required int avatarId,
    required BuildContext context,
  }) async {
    var body = jsonEncode(<String, dynamic>{
      "name": name,
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
      "phone": phoneNumber,
      "avaterId": avatarId,
    });

    Uri uri = Uri.https(authenticationBase, register);
    try {
      DialogUtils.showLoadingDialog(
        context,
        message: "please wait",
        dismissible: false,
      );
      http.Response response = await http.post(
        uri,
        body: body,
        headers: {"Content-Type": "application/json"},
      );
      var json = jsonDecode(response.body);
      RegisterResponse registerResponse = RegisterResponse.fromJson(json);
      DialogUtils.hideDialog(context);
      if (registerResponse.message == 'User created successfully') {
        DialogUtils.showMessageDialog(
          context,
          'Signedup Successfully',
          positiveTitle: 'login',
          negativeTitle: 'ok',
          positiveAction: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesManager.login,
                  (route) => false,
            );
          },
        );
        return Success(data: registerResponse);
      } else {
        DialogUtils.showMessageDialog(
          context,
          registerResponse.message.toString(),
          positiveTitle: 'ok',
        );
        return ServerError(
          code: registerResponse.statusCode.toString(),
          message: "servererror",
        );
      }
    } on Exception catch (e) {
      DialogUtils.hideDialog(context);
      DialogUtils.showMessageDialog(
        context,
        'Connection Error',
        positiveTitle: 'ok',
      );
      return GeneralException(exception: e);
    }
  }

  static Future<Result<LoginResponse>> loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    var body = jsonEncode(<String, dynamic>{
      "email": email,
      "password": password,
    });

    Uri uri = Uri.https(authenticationBase, login);
    try {
      DialogUtils.showLoadingDialog(
        context,
        message: "please wait",
        dismissible: false,
      );
      http.Response response = await http.post(
        uri,
        body: body,
        headers: {"Content-Type": "application/json"},
      );
      var json = jsonDecode(response.body);
      LoginResponse loginResponse = LoginResponse.fromJson(json);
      if (loginResponse.message == 'Success Login') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(
          'userCredentials',
          jsonEncode({'email': email, 'password': password}),
        );
        DialogUtils.hideDialog(context);
        LoginResponse.userToken = loginResponse.data;
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesManager.homeScreen,
              (_) => false,
        );
        return Success(data: loginResponse);
      } else {
        DialogUtils.hideDialog(context);
        DialogUtils.showMessageDialog(
          context,
          'Wrong Email or Password',
          positiveTitle: 'ok',
        );
        return ServerError(
          code: loginResponse.statusCode.toString(),
          message: "server error",
        );
      }
    } on Exception catch (e) {
      DialogUtils.hideDialog(context);
      DialogUtils.showMessageDialog(
        context,
        'Connection Error',
        positiveTitle: 'ok',
      );
      return GeneralException(exception: e);
    }
  }

  static Future<Result<ProfileResponse>> getUserProfile() async {
    Uri uri = Uri.https(authenticationBase, 'profile');
    Map<String, String> headers = {
      'Authorization': 'Bearer ${LoginResponse.userToken}',
    };
    try {
      http.Response response = await http.get(uri, headers: headers);
      var json = jsonDecode(response.body);
      ProfileResponse profileResponse = ProfileResponse.fromJson(json);
      if (profileResponse.message == 'Profile fetched successfully') {
        ProfileData.userProfile = profileResponse.data;
        return Success(data: profileResponse);
      } else {
        return ServerError(
          code: profileResponse.statusCode.toString(),
          message: profileResponse.message!,
        );
      }
    } on Exception catch (e) {
      return GeneralException(exception: e);
    }
  }

  static Future<Result<List<FavouriteMovie>>> getUserFavouritesList() async {
    Uri uri = Uri.https(authenticationBase, favourites);
    Map<String, String> headers = {
      'Authorization': 'Bearer ${LoginResponse.userToken}',
    };
    try {
      http.Response response = await http.get(uri, headers: headers);
      var json = jsonDecode(response.body);
      FavouriteMoviesResponse favResponse = FavouriteMoviesResponse.fromJson(
        json,
      );
      if (favResponse.message == 'favourites fetched successfully') {
        return Success(data: favResponse.data!);
      } else {
        return ServerError(
          code: favResponse.statusCode.toString(),
          message: favResponse.message!,
        );
      }
    } on Exception catch (e) {
      return GeneralException(exception: e);
    }
  }

  static Future<Result<CheckIsFavouriteResponse>> checkIsFav({
    required String id,
  }) async {
    Uri uri = Uri.https(authenticationBase, '$checkFavourite$id');
    Map<String, String> headers = {
      'Authorization': 'Bearer ${LoginResponse.userToken}',
    };
    try {
      http.Response response = await http.get(uri, headers: headers);
      var json = jsonDecode(response.body);
      CheckIsFavouriteResponse isFavouriteResponse =
      CheckIsFavouriteResponse.fromJson(json);
      if (isFavouriteResponse.message ==
          'Favourite status fetched successfully') {
        return Success(data: isFavouriteResponse);
      } else {
        return ServerError(
          code: isFavouriteResponse.statusCode.toString(),
          message: isFavouriteResponse.message!,
        );
      }
    } on Exception catch (e) {
      return GeneralException(exception: e);
    }
  }

  static Future<Result<GeneralResponse>> addToFavs({
    required String id,
    required String name,
    required String imageUrl,
    required String year,
    required double rating,
  }) async {
    Uri uri = Uri.https(authenticationBase, addToFavorites);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ${LoginResponse.userToken}',
    };
    var body = jsonEncode(<String, dynamic>{
      "movieId": id,
      "name": name,
      "rating": rating,
      "imageURL": imageUrl,
      "year": year,
    });
    try {
      http.Response response = await http.post(
        uri,
        headers: headers,
        body: body,
      );
      var json = jsonDecode(response.body);
      GeneralResponse addToFavouriteResponse = GeneralResponse.fromJson(json);
      if (addToFavouriteResponse.message == 'Added to favourite successfully') {
        return Success(data: addToFavouriteResponse);
      } else {
        return ServerError(
          code: addToFavouriteResponse.message!,
          message: addToFavouriteResponse.message!,
        );
      }
    } on Exception catch (e) {
      return GeneralException(exception: e);
    }
  }

  static Future<Result<GeneralResponse>> removeFromFavs({
    required String id,
  }) async {
    Uri uri = Uri.https(authenticationBase, '$removeFromFavourites$id');
    Map<String, String> headers = {
      'Authorization': 'Bearer ${LoginResponse.userToken}',
    };
    try {
      http.Response response = await http.delete(uri, headers: headers);
      var json = jsonDecode(response.body);
      GeneralResponse generalResponse = GeneralResponse.fromJson(json);
      if (generalResponse.message == 'Removed from favourite successfully') {
        return Success(data: generalResponse);
      } else {
        return ServerError(
          code: generalResponse.statusCode.toString(),
          message: generalResponse.message!,
        );
      }
    } on Exception catch (e) {
      return GeneralException(exception: e);
    }
  }

  static Future<Result<GeneralResponse>> deleteUser() async {
    Uri uri = Uri.https(authenticationBase, profile);
    Map<String, String> headers = {
      'Authorization': 'Bearer ${LoginResponse.userToken}',
    };
    try {
      http.Response response = await http.delete(uri, headers: headers);
      var json = jsonDecode(response.body);
      GeneralResponse generalResponse = GeneralResponse.fromJson(json);
      if (generalResponse.message == "Profile deleted successfully") {
        return Success(data: generalResponse);
      } else {
        return ServerError(
          code: generalResponse.statusCode.toString(),
          message: generalResponse.message!,
        );
      }
    } on Exception catch (e) {
      return GeneralException(exception: e);
    }
  }

  static Future<Result<GeneralResponse>> updateUser(
      {required String name, required String phone, required int avatarId}) async {
    Uri uri = Uri.https(authenticationBase, profile);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ${LoginResponse.userToken}',
    };
    var body = jsonEncode(<String, dynamic>{
      "name": name,
      "phone": phone,
      "avaterId": avatarId
    });
    try {
      http.Response response = await http.patch(
          uri, headers: headers, body: body);
      var json = jsonDecode(response.body);
      GeneralResponse generalResponse = GeneralResponse.fromJson(json);
      if (generalResponse.message == "Profile updated successfully") {
        return Success(data: generalResponse);
      } else {
        return ServerError(
          code: generalResponse.statusCode.toString(),
          message: generalResponse.message!,
        );
      }
    } on Exception catch (e) {
      return GeneralException(exception: e);
    }
  }
}
