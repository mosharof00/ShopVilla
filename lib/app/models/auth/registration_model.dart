// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  bool? status;
  List<String>? message;
  Data? data;

  RegisterModel({
    this.status,
    this.message,
    this.data,
  });

  RegisterModel copyWith({
    bool? status,
    List<String>? message,
    Data? data,
  }) =>
      RegisterModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
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
  String? email;
  String? gender;
  String? birthday;
  String? phone;
  bool? status;

  User({
    this.id,
    this.name,
    this.email,
    this.gender,
    this.birthday,
    this.phone,
    this.status,
  });

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? gender,
    String? birthday,
    String? phone,
    bool? status,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        gender: gender ?? this.gender,
        birthday: birthday ?? this.birthday,
        phone: phone ?? this.phone,
        status: status ?? this.status,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    gender: json["gender"],
    birthday: json["birthday"],
    phone: json["phone"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "gender": gender,
    "birthday": birthday,
    "phone": phone,
    "status": status,
  };
}
