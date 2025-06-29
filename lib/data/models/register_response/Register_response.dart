import 'Data.dart';

class RegisterResponse {
  RegisterResponse({this.data, this.statusCode, this.message});

  RegisterResponse.fromJson(dynamic json) {
    message = json['message'];
    statusCode = json['statusCode'];
    data = json['data'] != null ? RegisterData.fromJson(json['data']) : null;
  }

  RegisterData? data;
  dynamic message;
  num? statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['statusCode'] = statusCode;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}
