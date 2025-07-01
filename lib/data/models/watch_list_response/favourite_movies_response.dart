import 'favourite_movie.dart';

class FavouriteMoviesResponse {
  FavouriteMoviesResponse({this.message, this.data, this.statusCode});

  FavouriteMoviesResponse.fromJson(dynamic json) {
    message = json['message'];
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(FavouriteMovie.fromJson(v));
      });
    }
  }

  String? message;
  List<FavouriteMovie>? data;
  num? statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['statusCode'] = statusCode;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
