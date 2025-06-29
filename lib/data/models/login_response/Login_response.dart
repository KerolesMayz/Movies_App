class LoginResponse {
  LoginResponse({this.statusCode, this.message, this.data});

  LoginResponse.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'];
    statusCode = json['statusCode'];
  }

  dynamic message;
  String? data;
  num? statusCode;
  static String? userToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['data'] = data;
    map['statusCode'] = statusCode;
    return map;
  }
}
