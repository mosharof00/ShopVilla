// To parse this JSON data, do
//
//     final addToWishlistModel = addToWishlistModelFromJson(jsonString);

import 'dart:convert';

AddToWishlistModel addToWishlistModelFromJson(String str) =>
    AddToWishlistModel.fromJson(json.decode(str));

String addToWishlistModelToJson(AddToWishlistModel data) =>
    json.encode(data.toJson());

class AddToWishlistModel {
  bool? status;
  String? message;
  dynamic data;

  AddToWishlistModel({
    this.status,
    this.message,
    this.data,
  });

  AddToWishlistModel copyWith({
    bool? status,
    String? message,
    dynamic data,
  }) =>
      AddToWishlistModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory AddToWishlistModel.fromJson(Map<String, dynamic> json) =>
      AddToWishlistModel(
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
