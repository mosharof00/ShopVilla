// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  String? title;
  List<CategoryData>? data;

  CategoryModel({
    this.title,
    this.data,
  });

  CategoryModel copyWith({
    String? title,
    List<CategoryData>? data,
  }) =>
      CategoryModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    title: json["title"],
    data: json["data"] == null ? [] : List<CategoryData>.from(json["data"]!.map((x) => CategoryData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CategoryData {
  int? id;
  String? categoryName;
  String? slug;
  String? type;
  String? image;
  bool? status;
  String? categoryDesc;
  DateTime? createdAt;
  DateTime? updatedAt;

  CategoryData({
    this.id,
    this.categoryName,
    this.slug,
    this.type,
    this.image,
    this.status,
    this.categoryDesc,
    this.createdAt,
    this.updatedAt,
  });

  CategoryData copyWith({
    int? id,
    String? categoryName,
    String? slug,
    String? type,
    String? image,
    bool? status,
    String? categoryDesc,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      CategoryData(
        id: id ?? this.id,
        categoryName: categoryName ?? this.categoryName,
        slug: slug ?? this.slug,
        type: type ?? this.type,
        image: image ?? this.image,
        status: status ?? this.status,
        categoryDesc: categoryDesc ?? this.categoryDesc,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
    id: json["id"],
    categoryName: json["category_name"],
    slug: json["slug"],
    type: json["type"],
    image: json["image"],
    status: json["status"],
    categoryDesc: json["category_desc"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
  };
}

// enum Type {
//   NOT_SPECIAL,
//   SPECIAL
// }
//
// final typeValues = EnumValues({
//   "not_special": Type.NOT_SPECIAL,
//   "special": Type.SPECIAL
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
