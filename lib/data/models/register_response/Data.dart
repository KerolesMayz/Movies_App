class RegisterData {
  RegisterData({
    this.email,
    this.password,
    this.name,
    this.phone,
    this.avaterId,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  RegisterData.fromJson(dynamic json) {
    email = json['email'];
    password = json['password'];
    name = json['name'];
    phone = json['phone'];
    avaterId = json['avaterId'];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }

  String? email;
  String? password;
  String? name;
  String? phone;
  num? avaterId;
  String? id;
  String? createdAt;
  String? updatedAt;
  num? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['password'] = password;
    map['name'] = name;
    map['phone'] = phone;
    map['avaterId'] = avaterId;
    map['_id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }
}
