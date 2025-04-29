// To parse this JSON data, do
//
//     final wishListModel = wishListModelFromJson(jsonString);

import 'dart:convert';

WishListModel wishListModelFromJson(String str) =>
    WishListModel.fromJson(json.decode(str));

String wishListModelToJson(WishListModel data) => json.encode(data.toJson());

class WishListModel {
  String? title;
  List<WishListData>? data;

  WishListModel({
    this.title,
    this.data,
  });

  WishListModel copyWith({
    String? title,
    List<WishListData>? data,
  }) =>
      WishListModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory WishListModel.fromJson(Map<String, dynamic> json) => WishListModel(
        title: json["title"],
        data: json["data"] == null
            ? []
            : List<WishListData>.from(
                json["data"]!.map((x) => WishListData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class WishListData {
  int? userId;
  int? productId;
  String? productName;
  int? regularPrice;
  int? salePrice;
  String? image;
  double? rating;

  WishListData({
    this.userId,
    this.productId,
    this.productName,
    this.regularPrice,
    this.salePrice,
    this.image,
    this.rating,
  });

  WishListData copyWith({
    int? userId,
    int? productId,
    String? productName,
    int? regularPrice,
    int? salePrice,
    String? image,
    double? rating,
  }) =>
      WishListData(
        userId: userId ?? this.userId,
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        regularPrice: regularPrice ?? this.regularPrice,
        salePrice: salePrice ?? this.salePrice,
        image: image ?? this.image,
        rating: rating ?? this.rating,
      );

  factory WishListData.fromJson(Map<String, dynamic> json) => WishListData(
        userId: json["user_id"],
        productId: json["product_id"],
        productName: json["product_name"],
        regularPrice: json["regular_price"],
        salePrice: json["sale_price"],
        image: json["image"],
        rating: json["rating"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "product_id": productId,
        "product_name": productName,
        "regular_price": regularPrice,
        "sale_price": salePrice,
        "image": image,
        "rating": rating,
      };
}
