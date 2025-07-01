import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/data/models/login_response/Login_response.dart';
import 'package:movies/data/models/register_response/Register_response.dart';
import 'package:movies/data/models/watch_list_response/favourite_movie.dart';
import 'package:movies/data/models/watch_list_response/favourite_movies_response.dart';
import 'package:movies/data/result/result.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/resources_manager/dialog_utils.dart';
import '../../core/routes_manager/routes_manager.dart';
import '../models/movies_response/movie.dart';
import '../models/movies_response/movies_response.dart';
import '../models/prfile_response/Profile_response.dart';
import '../models/prfile_response/profile_data.dart';

class ApiServices {
  static const String moviesBase = 'yts.mx';
  static const String listMovies = '/api/v2/list_movies.json';
  static const String authenticationBase = 'route-movie-apis.vercel.app';
  static const String register = 'auth/register';
  static const String login = 'auth/login';
  static const String favourites = 'favorites/all';
  static const String resetPassword = 'auth/reset-password';

  static Future<Result<List<Movie>>> getMoviesList({
    int? page,
    String? sort,
    String? genre,
  }) async
  {
    Map<String, dynamic> queryParameters = {
      'limit': '10',
      'page': page.toString(),
      'sort_by': sort,
      'genre': genre,
    };
    Uri uri = Uri.https(moviesBase, listMovies, queryParameters);
    try {
      http.Response response = await http.get(uri);
      var json = jsonDecode(response.body);
      MoviesResponse moviesResponse = MoviesResponse.fromJson(json);
      if (moviesResponse.status == 'ok') {
        return Success(data: moviesResponse.data!.movies!);
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

  static Future<Result<RegisterResponse>> registerUserApi({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phoneNumber,
    required int avatarId,
    required BuildContext context,
  }) async
  {
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

  static Future<Result<LoginResponse>> loginUserApi({
    required String email,
    required String password,
    required BuildContext context,
  }) async
  {
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
        await prefs.setString('userCredentials',
            jsonEncode({'email': email, 'password': password}));
        DialogUtils.hideDialog(context);
        LoginResponse.userToken = loginResponse.data;
        Navigator.pushNamedAndRemoveUntil(
            context, RoutesManager.homeScreen, (_) => false);
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
          json);
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

}
