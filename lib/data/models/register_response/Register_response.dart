class RegisterResponse {
  RegisterResponse({this.statusCode, this.message});

  RegisterResponse.fromJson(dynamic json) {
    message = json['message'];
    statusCode = json['statusCode'];
  }

  dynamic message;
  num? statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['statusCode'] = statusCode;
    return map;
  }
}
