// To parse this JSON data, do
//
//     final promosGetModel = promosGetModelFromJson(jsonString);

import 'dart:convert';

PromosGetModel promosGetModelFromJson(String str) => PromosGetModel.fromJson(json.decode(str));

String promosGetModelToJson(PromosGetModel data) => json.encode(data.toJson());

class PromosGetModel {
  String? title;
  List<Promos>? data;

  PromosGetModel({
    this.title,
    this.data,
  });

  PromosGetModel copyWith({
    String? title,
    List<Promos>? data,
  }) =>
      PromosGetModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory PromosGetModel.fromJson(Map<String, dynamic> json) => PromosGetModel(
    title: json["title"],
    data: json["data"] == null ? [] : List<Promos>.from(json["data"]!.map((x) => Promos.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Promos {
  int? id;
  String? code;
  String? type;
  String? amount;
  String? couponType;
  List<Category>? categories;
  DateTime? date;
  DateTime? validity;
  String? status;

  Promos({
    this.id,
    this.code,
    this.type,
    this.amount,
    this.couponType,
    this.categories,
    this.date,
    this.validity,
    this.status,
  });

  Promos copyWith({
    int? id,
    String? code,
    String? type,
    String? amount,
    String? couponType,
    List<Category>? categories,
    DateTime? date,
    DateTime? validity,
    String? status,
  }) =>
      Promos(
        id: id ?? this.id,
        code: code ?? this.code,
        type: type ?? this.type,
        amount: amount ?? this.amount,
        couponType: couponType ?? this.couponType,
        categories: categories ?? this.categories,
        date: date ?? this.date,
        validity: validity ?? this.validity,
        status: status ?? this.status,
      );

  factory Promos.fromJson(Map<String, dynamic> json) => Promos(
    id: json["id"],
    code: json["code"],
    type: json["type"],
    amount: json["amount"],
    couponType: json["coupon_type"],
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    validity: json["validity"] == null ? null : DateTime.parse(json["validity"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "type": type,
    "amount": amount,
    "coupon_type": couponType,
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "date": date?.toIso8601String(),
    "validity": validity?.toIso8601String(),
    "status": status,
  };
}

class Category {
  int? id;
  String? categoryName;
  String? slug;
  String? type;
  String? image;
  bool? status;
  String? categoryDesc;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? order;
  Pivot? pivot;

  Category({
    this.id,
    this.categoryName,
    this.slug,
    this.type,
    this.image,
    this.status,
    this.categoryDesc,
    this.createdAt,
    this.updatedAt,
    this.order,
    this.pivot,
  });

  Category copyWith({
    int? id,
    String? categoryName,
    String? slug,
    String? type,
    String? image,
    bool? status,
    String? categoryDesc,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? order,
    Pivot? pivot,
  }) =>
      Category(
        id: id ?? this.id,
        categoryName: categoryName ?? this.categoryName,
        slug: slug ?? this.slug,
        type: type ?? this.type,
        image: image ?? this.image,
        status: status ?? this.status,
        categoryDesc: categoryDesc ?? this.categoryDesc,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        order: order ?? this.order,
        pivot: pivot ?? this.pivot,
      );

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    categoryName: json["category_name"],
    slug: json["slug"],
    type: json["type"],
    image: json["image"],
    status: json["status"],
    categoryDesc: json["category_desc"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    order: json["order"],
    pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name": categoryName,
    "slug": slug,
    "type": type,
    "image": image,
    "status": status,
    "category_desc": categoryDesc,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "order": order,
    "pivot": pivot?.toJson(),
  };
}

class Pivot {
  int? couponId;
  int? categoryId;

  Pivot({
    this.couponId,
    this.categoryId,
  });

  Pivot copyWith({
    int? couponId,
    int? categoryId,
  }) =>
      Pivot(
        couponId: couponId ?? this.couponId,
        categoryId: categoryId ?? this.categoryId,
      );

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    couponId: json["coupon_id"],
    categoryId: json["category_id"],
  );

  Map<String, dynamic> toJson() => {
    "coupon_id": couponId,
    "category_id": categoryId,
  };
}
