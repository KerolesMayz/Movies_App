import 'profile_data.dart';

class ProfileResponse {
  ProfileResponse({this.message, this.data, this.statusCode});

  ProfileResponse.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
  }

  dynamic message;
  ProfileData? data;
  num? statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['statusCode'] = statusCode;
    return map;
  }
}
