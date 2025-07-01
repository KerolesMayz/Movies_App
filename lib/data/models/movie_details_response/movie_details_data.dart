import 'movie_details.dart';

class MovieDetailsData {
  MovieDetailsData({this.movie});

  MovieDetailsData.fromJson(dynamic json) {
    movie = json['movie'] != null ? MovieDetails.fromJson(json['movie']) : null;
  }

  MovieDetails? movie;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (movie != null) {
      map['movie'] = movie?.toJson();
    }
    return map;
  }
}
