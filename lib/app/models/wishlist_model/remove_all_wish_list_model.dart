// To parse this JSON data, do
//
//     final removeAllWishListModel = removeAllWishListModelFromJson(jsonString);

import 'dart:convert';

RemoveAllWishListModel removeAllWishListModelFromJson(String str) => RemoveAllWishListModel.fromJson(json.decode(str));

String removeAllWishListModelToJson(RemoveAllWishListModel data) => json.encode(data.toJson());

class RemoveAllWishListModel {
  bool? status;
  String? message;
  dynamic data;

  RemoveAllWishListModel({
    this.status,
    this.message,
    this.data,
  });

  RemoveAllWishListModel copyWith({
    bool? status,
    String? message,
    dynamic data,
  }) =>
      RemoveAllWishListModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory RemoveAllWishListModel.fromJson(Map<String, dynamic> json) => RemoveAllWishListModel(
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
