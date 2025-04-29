// To parse this JSON data, do
//
//     final removeToWishlistModel = removeToWishlistModelFromJson(jsonString);

import 'dart:convert';

RemoveToWishlistModel removeToWishlistModelFromJson(String str) => RemoveToWishlistModel.fromJson(json.decode(str));

String removeToWishlistModelToJson(RemoveToWishlistModel data) => json.encode(data.toJson());

class RemoveToWishlistModel {
  bool? status;
  String? message;
  dynamic data;

  RemoveToWishlistModel({
    this.status,
    this.message,
    this.data,
  });

  RemoveToWishlistModel copyWith({
    bool? status,
    String? message,
    dynamic data,
  }) =>
      RemoveToWishlistModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory RemoveToWishlistModel.fromJson(Map<String, dynamic> json) => RemoveToWishlistModel(
    status: json["status"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
  };
}
