class RemoveFromFavouriteResponse {
  RemoveFromFavouriteResponse({this.message, this.statusCode});

  RemoveFromFavouriteResponse.fromJson(dynamic json) {
    message = json['message'];
    statusCode = json['statusCode'];
  }

  String? message;
  num? statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['statusCode'] = statusCode;
    return map;
  }
}
