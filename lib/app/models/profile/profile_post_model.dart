// To parse this JSON data, do
//
//     final profiePostModel = profiePostModelFromJson(jsonString);

import 'dart:convert';

ProfilePostModel profiePostModelFromJson(String str) => ProfilePostModel.fromJson(json.decode(str));

String profiePostModelToJson(ProfilePostModel data) => json.encode(data.toJson());

class ProfilePostModel {
  bool? status;
  String? message;
  ProfileUpdate? data;

  ProfilePostModel({
    this.status,
    this.message,
    this.data,
  });

  ProfilePostModel copyWith({
    bool? status,
    String? message,
    ProfileUpdate? data,
  }) =>
      ProfilePostModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ProfilePostModel.fromJson(Map<String, dynamic> json) => ProfilePostModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : ProfileUpdate.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class ProfileUpdate {
  int? id;
  String? name;
  String? gender;
  DateTime? birthday;
  String? country;
  String? phone;
  dynamic deviceToken;
  String? image;
  String? email;
  dynamic emailVerifiedAt;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProfileUpdate({
    this.id,
    this.name,
    this.gender,
    this.birthday,
    this.country,
    this.phone,
    this.deviceToken,
    this.image,
    this.email,
    this.emailVerifiedAt,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  ProfileUpdate copyWith({
    int? id,
    String? name,
    String? gender,
    DateTime? birthday,
    String? country,
    String? phone,
    dynamic deviceToken,
    String? image,
    String? email,
    dynamic emailVerifiedAt,
    bool? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ProfileUpdate(
        id: id ?? this.id,
        name: name ?? this.name,
        gender: gender ?? this.gender,
        birthday: birthday ?? this.birthday,
        country: country ?? this.country,
        phone: phone ?? this.phone,
        deviceToken: deviceToken ?? this.deviceToken,
        image: image ?? this.image,
        email: email ?? this.email,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ProfileUpdate.fromJson(Map<String, dynamic> json) => ProfileUpdate(
    id: json["id"],
    name: json["name"],
    gender: json["gender"],
    birthday: json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
    country: json["country"],
    phone: json["phone"],
    deviceToken: json["device_token"],
    image: json["image"],
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
    "birthday": "${birthday!.year.toString().padLeft(4, '0')}-${birthday!.month.toString().padLeft(2, '0')}-${birthday!.day.toString().padLeft(2, '0')}",
    "country": country,
    "phone": phone,
    "device_token": deviceToken,
    "image": image,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
