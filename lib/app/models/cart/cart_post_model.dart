// To parse this JSON data, do
//
//     final cartPostModel = cartPostModelFromJson(jsonString);

import 'dart:convert';

CartPostModel cartPostModelFromJson(String str) => CartPostModel.fromJson(json.decode(str));

String cartPostModelToJson(CartPostModel data) => json.encode(data.toJson());

class CartPostModel {
  String? title;
  Data? data;

  CartPostModel({
    this.title,
    this.data,
  });

  CartPostModel copyWith({
    String? title,
    Data? data,
  }) =>
      CartPostModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory CartPostModel.fromJson(Map<String, dynamic> json) => CartPostModel(
    title: json["title"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "data": data?.toJson(),
  };
}

class Data {
  int? userId;
  int? productId;
  int? qty;
  int? colorId;
  String? color;
  String? size;
  int? sizeId;
  String? weight;
  dynamic weightId;
  String? price;
  String? total;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Data({
    this.userId,
    this.productId,
    this.qty,
    this.colorId,
    this.color,
    this.size,
    this.sizeId,
    this.weight,
    this.weightId,
    this.price,
    this.total,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  Data copyWith({
    int? userId,
    int? productId,
    int? qty,
    int? colorId,
    String? color,
    String? size,
    int? sizeId,
    String? weight,
    dynamic weightId,
    String? price,
    String? total,
    DateTime? updatedAt,
    DateTime? createdAt,
    int? id,
  }) =>
      Data(
        userId: userId ?? this.userId,
        productId: productId ?? this.productId,
        qty: qty ?? this.qty,
        colorId: colorId ?? this.colorId,
        color: color ?? this.color,
        size: size ?? this.size,
        sizeId: sizeId ?? this.sizeId,
        weight: weight ?? this.weight,
        weightId: weightId ?? this.weightId,
        price: price ?? this.price,
        total: total ?? this.total,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    productId: json["product_id"],
    qty: json["qty"],
    colorId: json["color_id"],
    color: json["color"],
    size: json["size"],
    sizeId: json["size_id"],
    weight: json["weight"],
    weightId: json["weight_id"],
    price: json["price"],
    total: json["total"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "product_id": productId,
    "qty": qty,
    "color_id": colorId,
    "color": color,
    "size": size,
    "size_id": sizeId,
    "weight": weight,
    "weight_id": weightId,
    "price": price,
    "total": total,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}
