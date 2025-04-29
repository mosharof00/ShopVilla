// To parse this JSON data, do
//
//     final reviewAddModel = reviewAddModelFromJson(jsonString);

import 'dart:convert';

ReviewAddModel reviewAddModelFromJson(String str) => ReviewAddModel.fromJson(json.decode(str));

String reviewAddModelToJson(ReviewAddModel data) => json.encode(data.toJson());

class ReviewAddModel {
  bool? status;
  String? message;
  AddReviews? data;

  ReviewAddModel({
    this.status,
    this.message,
    this.data,
  });

  ReviewAddModel copyWith({
    bool? status,
    String? message,
    AddReviews? data,
  }) =>
      ReviewAddModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ReviewAddModel.fromJson(Map<String, dynamic> json) => ReviewAddModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : AddReviews.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class AddReviews {
  int? productId;
  String? text;
  double? rating;
  int? userId;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  String? image;

  AddReviews({
    this.productId,
    this.text,
    this.rating,
    this.userId,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.image,
  });

  AddReviews copyWith({
    int? productId,
    String? text,
    double? rating,
    int? userId,
    DateTime? updatedAt,
    DateTime? createdAt,
    int? id,
    String? image,
  }) =>
      AddReviews(
        productId: productId ?? this.productId,
        text: text ?? this.text,
        rating: rating ?? this.rating,
        userId: userId ?? this.userId,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        image: image ?? this.image,
      );

  factory AddReviews.fromJson(Map<String, dynamic> json) => AddReviews(
    productId: json["product_id"],
    text: json["text"],
    rating: json["rating"]?.toDouble(),
    userId: json["user_id"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "text": text,
    "rating": rating,
    "user_id": userId,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
    "image": image,
  };
}
