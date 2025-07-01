import 'movies_data.dart';

class MoviesResponse {
  MoviesResponse({this.status, this.statusMessage, this.data});

  MoviesResponse.fromJson(dynamic json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? MoviesData.fromJson(json['data']) : null;
  }

  String? status;
  String? statusMessage;
  MoviesData? data;

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
