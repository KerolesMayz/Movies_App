class CheckIsFavouriteResponse {
  CheckIsFavouriteResponse({this.message, this.isFavourite});

  CheckIsFavouriteResponse.fromJson(dynamic json) {
    message = json['message'];
    isFavourite = json['data'];
    statusCode = json['statusCode'];
  }

  String? message;
  bool? isFavourite;
  num? statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['data'] = isFavourite;
    map['statusCode'] = statusCode;
    return map;
  }
}
