import 'movie_details_data.dart';

class MovieDetailsResponse {
  MovieDetailsResponse({this.status, this.statusMessage, this.data});

  MovieDetailsResponse.fromJson(dynamic json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'] != null
        ? MovieDetailsData.fromJson(json['data'])
        : null;
  }

  String? status;
  String? statusMessage;
  MovieDetailsData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['status_message'] = statusMessage;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}
