// To parse this JSON data, do
//
//     final profieGetModel = profieGetModelFromJson(jsonString);

import 'dart:convert';

ProfileGetModel profieGetModelFromJson(String str) => ProfileGetModel.fromJson(json.decode(str));

String profieGetModelToJson(ProfileGetModel data) => json.encode(data.toJson());

class ProfileGetModel {
  String? title;
  ProfileDetails? data;

  ProfileGetModel({
    this.title,
    this.data,
  });

  ProfileGetModel copyWith({
    String? title,
    ProfileDetails? data,
  }) =>
      ProfileGetModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory ProfileGetModel.fromJson(Map<String, dynamic> json) => ProfileGetModel(
    title: json["title"],
    data: json["data"] == null ? null : ProfileDetails.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "data": data?.toJson(),
  };
}

class ProfileDetails {
  int? id;
  String? name;
  String? gender;
  DateTime? birthday;
  dynamic country;
  String? phone;
  dynamic deviceToken;
  String? image;
  String? email;
  dynamic emailVerifiedAt;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProfileDetails({
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

  ProfileDetails copyWith({
    int? id,
    String? name,
    String? gender,
    DateTime? birthday,
    dynamic country,
    String? phone,
    dynamic deviceToken,
    String? image,
    String? email,
    dynamic emailVerifiedAt,
    bool? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ProfileDetails(
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

  factory ProfileDetails.fromJson(Map<String, dynamic> json) => ProfileDetails(
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
