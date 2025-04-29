// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool? status;
  List<String>? message;
  Data? data;

  LoginModel({
    this.status,
    this.message,
    this.data,
  });

  LoginModel copyWith({
    bool? status,
    List<String>? message,
    Data? data,
  }) =>
      LoginModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json["status"],
    message: json["message"] == null ? [] : List<String>.from(json["message"]!.map((x) => x)),
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message == null ? [] : List<dynamic>.from(message!.map((x) => x)),
    "data": data?.toJson(),
  };
}

class Data {
  String? token;
  User? user;

  Data({
    this.token,
    this.user,
  });

  Data copyWith({
    String? token,
    User? user,
  }) =>
      Data(
        token: token ?? this.token,
        user: user ?? this.user,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "user": user?.toJson(),
  };
}

class User {
  int? id;
  String? name;
  dynamic gender;
  dynamic birthday;
  dynamic phone;
  String? email;
  dynamic emailVerifiedAt;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.name,
    this.gender,
    this.birthday,
    this.phone,
    this.email,
    this.emailVerifiedAt,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  User copyWith({
    int? id,
    String? name,
    dynamic gender,
    dynamic birthday,
    dynamic phone,
    String? email,
    dynamic emailVerifiedAt,
    bool? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        gender: gender ?? this.gender,
        birthday: birthday ?? this.birthday,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    gender: json["gender"],
    birthday: json["birthday"],
    phone: json["phone"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "gender": gender,
    "birthday": birthday,
    "phone": phone,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
