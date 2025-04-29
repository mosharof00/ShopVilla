// To parse this JSON data, do
//
//     final subCategoryModel = subCategoryModelFromJson(jsonString);

import 'dart:convert';

SubCategoryModel subCategoryModelFromJson(String str) =>
    SubCategoryModel.fromJson(json.decode(str));

String subCategoryModelToJson(SubCategoryModel data) =>
    json.encode(data.toJson());

class SubCategoryModel {
  String? title;
  List<SubCategory>? data;

  SubCategoryModel({
    this.title,
    this.data,
  });

  SubCategoryModel copyWith({
    String? title,
    List<SubCategory>? data,
  }) =>
      SubCategoryModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
      SubCategoryModel(
        title: json["title"],
        data: json["data"] == null
            ? []
            : List<SubCategory>.from(
                json["data"]!.map((x) => SubCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SubCategory {
  int? id;
  int? categoryId;
  String? name;
  String? slug;
  String? image;
  dynamic createdAt;
  dynamic updatedAt;

  SubCategory({
    this.id,
    this.categoryId,
    this.name,
    this.slug,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  SubCategory copyWith({
    int? id,
    int? categoryId,
    String? name,
    String? slug,
    String? image,
    dynamic createdAt,
    dynamic updatedAt,
  }) =>
      SubCategory(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        image: image ?? this.image,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["id"],
        categoryId: json["category_id"],
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "name": name,
        "slug": slug,
        "image": image,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
