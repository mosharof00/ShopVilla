// To parse this JSON data, do
//
//     final cartItemRemoveModel = cartItemRemoveModelFromJson(jsonString);

import 'dart:convert';

CartItemRemoveModel cartItemRemoveModelFromJson(String str) => CartItemRemoveModel.fromJson(json.decode(str));

String cartItemRemoveModelToJson(CartItemRemoveModel data) => json.encode(data.toJson());

class CartItemRemoveModel {
  String? title;
  dynamic data;

  CartItemRemoveModel({
    this.title,
    this.data,
  });

  CartItemRemoveModel copyWith({
    String? title,
    dynamic data,
  }) =>
      CartItemRemoveModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory CartItemRemoveModel.fromJson(Map<String, dynamic> json) => CartItemRemoveModel(
    title: json["title"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "data": data,
  };
}
