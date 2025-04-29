// To parse this JSON data, do
//
//     final cartGetModel = cartGetModelFromJson(jsonString);

import 'dart:convert';

CartGetModel cartGetModelFromJson(String str) => CartGetModel.fromJson(json.decode(str));

String cartGetModelToJson(CartGetModel data) => json.encode(data.toJson());

class CartGetModel {
  String? title;
  Carts? data;

  CartGetModel({
    this.title,
    this.data,
  });

  CartGetModel copyWith({
    String? title,
    Carts? data,
  }) =>
      CartGetModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory CartGetModel.fromJson(Map<String, dynamic> json) => CartGetModel(
    title: json["title"],
    data: json["data"] == null ? null : Carts.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "data": data?.toJson(),
  };
}

class Carts {
  List<Cart>? carts;
  String? total;
  String? subTotal;

  Carts({
    this.carts,
    this.total,
    this.subTotal,
  });

  Carts copyWith({
    List<Cart>? carts,
    String? total,
    String? subTotal,
  }) =>
      Carts(
        carts: carts ?? this.carts,
        total: total ?? this.total,
        subTotal: subTotal ?? this.subTotal,
      );

  factory Carts.fromJson(Map<String, dynamic> json) => Carts(
    carts: json["carts"] == null ? [] : List<Cart>.from(json["carts"]!.map((x) => Cart.fromJson(x))),
    total: json["total"],
    subTotal: json["subTotal"],
  );

  Map<String, dynamic> toJson() => {
    "carts": carts == null ? [] : List<dynamic>.from(carts!.map((x) => x.toJson())),
    "total": total,
    "subTotal": subTotal,
  };
}

class Cart {
  int? productId;
  String? productName;
  String? productSize;
  String? productColor;
  int? qty;
  String? total;
  String? image;

  Cart({
    this.productId,
    this.productName,
    this.productSize,
    this.productColor,
    this.qty,
    this.total,
    this.image,
  });

  Cart copyWith({
    int? productId,
    String? productName,
    String? productSize,
    String? productColor,
    int? qty,
    String? total,
    String? image,
  }) =>
      Cart(
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        productSize: productSize ?? this.productSize,
        productColor: productColor ?? this.productColor,
        qty: qty ?? this.qty,
        total: total ?? this.total,
        image: image ?? this.image,
      );

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    productId: json["product_id"],
    productName: json["product_name"],
    productSize: json["product_size"],
    productColor: json["product_color"],
    qty: json["qty"],
    total: json["total"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "product_name": productName,
    "product_size": productSize,
    "product_color": productColor,
    "qty": qty,
    "total": total,
    "image": image,
  };
}
