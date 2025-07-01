class AddToFavouriteResponse {
  AddToFavouriteResponse({this.message, this.statusCode});

  AddToFavouriteResponse.fromJson(dynamic json) {
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
