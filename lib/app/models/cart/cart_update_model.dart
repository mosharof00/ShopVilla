import 'dart:convert';

CartUpdateModel cartUpdateModelFromJson(String str) => CartUpdateModel.fromJson(json.decode(str));

String cartUpdateModelToJson(CartUpdateModel data) => json.encode(data.toJson());

class CartUpdateModel {
  String? title;
  Data? data;

  CartUpdateModel({
    this.title,
    this.data,
  });

  CartUpdateModel copyWith({
    String? title,
    Data? data,
  }) =>
      CartUpdateModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory CartUpdateModel.fromJson(Map<String, dynamic> json) => CartUpdateModel(
    title: json["title"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  int? userId;
  int? productId;
  int? qty;
  String? color;
  int? colorId;
  String? size;
  int? sizeId;
  String? weight;
  dynamic weightId;
  String? price;
  String? total;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.userId,
    this.productId,
    this.qty,
    this.color,
    this.colorId,
    this.size,
    this.sizeId,
    this.weight,
    this.weightId,
    this.price,
    this.total,
    this.createdAt,
    this.updatedAt,
  });

  Data copyWith({
    int? id,
    int? userId,
    int? productId,
    int? qty,
    String? color,
    int? colorId,
    String? size,
    int? sizeId,
    String? weight,
    dynamic weightId,
    String? price,
    String? total,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Data(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        productId: productId ?? this.productId,
        qty: qty ?? this.qty,
        color: color ?? this.color,
        colorId: colorId ?? this.colorId,
        size: size ?? this.size,
        sizeId: sizeId ?? this.sizeId,
        weight: weight ?? this.weight,
        weightId: weightId ?? this.weightId,
        price: price ?? this.price,
        total: total ?? this.total,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    userId: json["user_id"],
    productId: json["product_id"],
    qty: json["qty"],
    color: json["color"],
    colorId: json["color_id"],
    size: json["size"],
    sizeId: json["size_id"],
    weight: json["weight"],
    weightId: json["weight_id"],
    price: json["price"],
    total: json["total"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "product_id": productId,
    "qty": qty,
    "color": color,
    "color_id": colorId,
    "size": size,
    "size_id": sizeId,
    "weight": weight,
    "weight_id": weightId,
    "price": price,
    "total": total,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
