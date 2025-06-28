import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/data/models/Movies.dart';
import 'package:movies/data/models/MoviesResponse.dart';
import 'package:movies/data/result/result.dart';

class ApiServices {
  static const String base = 'yts.mx';
  static const String listMovies = '/api/v2/list_movies.json';

  static Future<Result<List<Movies>>> getMoviesList({
    int? page,
    String? sort,
    String? genre,
  }) async {
    Map<String, dynamic> queryParameters = {
      'limit': '10',
      'page': page.toString(),
      'sort_by': sort,
      'genre': genre,
    };
    Uri uri = Uri.https(base, listMovies, queryParameters);
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
}
