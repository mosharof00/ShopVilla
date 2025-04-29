// To parse this JSON data, do
//
//     final reviewGetModel = reviewGetModelFromJson(jsonString);

import 'dart:convert';

ReviewGetModel reviewGetModelFromJson(String str) => ReviewGetModel.fromJson(json.decode(str));

String reviewGetModelToJson(ReviewGetModel data) => json.encode(data.toJson());

class ReviewGetModel {
  String? title;
  List<GetReviews>? data;

  ReviewGetModel({
    this.title,
    this.data,
  });

  ReviewGetModel copyWith({
    String? title,
    List<GetReviews>? data,
  }) =>
      ReviewGetModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory ReviewGetModel.fromJson(Map<String, dynamic> json) => ReviewGetModel(
    title: json["title"],
    data: json["data"] == null ? [] : List<GetReviews>.from(json["data"]!.map((x) => GetReviews.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class GetReviews {
  int? productId;
  String? productName;
  String? userName;
  String? text;
  double? rating;
  String? userImage;
  String? image;
  User? user;

  GetReviews({
    this.productId,
    this.productName,
    this.userName,
    this.text,
    this.rating,
    this.userImage,
    this.image,
    this.user,
  });

  GetReviews copyWith({
    int? productId,
    String? productName,
    String? userName,
    String? text,
    double? rating,
    String? userImage,
    String? image,
    User? user,
  }) =>
      GetReviews(
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        userName: userName ?? this.userName,
        text: text ?? this.text,
        rating: rating ?? this.rating,
        userImage: userImage ?? this.userImage,
        image: image ?? this.image,
        user: user ?? this.user,
      );

  factory GetReviews.fromJson(Map<String, dynamic> json) => GetReviews(
    productId: json["product_id"],
    productName: json["product_name"],
    userName: json["user_name"],
    text: json["text"],
    rating: json["rating"]?.toDouble(),
    userImage: json["user_image"],
    image: json["image"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "product_name": productName,
    "user_name": userName,
    "text": text,
    "rating": rating,
    "user_image": userImage,
    "image": image,
    "user": user?.toJson(),
  };
}

class User {
  int? id;
  String? name;
  dynamic gender;
  dynamic birthday;
  dynamic country;
  dynamic phone;
  dynamic deviceToken;
  String? image;
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

  User copyWith({
    int? id,
    String? name,
    dynamic gender,
    dynamic birthday,
    dynamic country,
    dynamic phone,
    dynamic deviceToken,
    String? image,
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

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    gender: json["gender"],
    birthday: json["birthday"],
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
    "birthday": birthday,
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
