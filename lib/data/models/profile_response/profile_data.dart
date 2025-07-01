class ProfileData {
  ProfileData({this.id, this.name, this.phone, this.avaterId});

  ProfileData.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    phone = json['phone'];
    avaterId = json['avaterId'];
  }

  String? id;
  String? name;
  String? phone;
  num? avaterId;
  static ProfileData? userProfile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['phone'] = phone;
    map['avaterId'] = avaterId;
    return map;
  }
}
