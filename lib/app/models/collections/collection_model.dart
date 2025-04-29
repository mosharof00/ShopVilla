// To parse this JSON data, do
//
//     final collectionModel = collectionModelFromJson(jsonString);

import 'dart:convert';

CollectionModel collectionModelFromJson(String str) =>
    CollectionModel.fromJson(json.decode(str));

String collectionModelToJson(CollectionModel data) =>
    json.encode(data.toJson());

class CollectionModel {
  String? title;
  List<CollectionData>? data;

  CollectionModel({
    this.title,
    this.data,
  });

  CollectionModel copyWith({
    String? title,
    List<CollectionData>? data,
  }) =>
      CollectionModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory CollectionModel.fromJson(Map<String, dynamic> json) =>
      CollectionModel(
        title: json["title"],
        data: json["data"] == null
            ? []
            : List<CollectionData>.from(json["data"]!.map((x) => CollectionData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CollectionData {
  int? id;
  String? title;
  String? subTitle;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  CollectionData({
    this.id,
    this.title,
    this.subTitle,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  CollectionData copyWith({
    int? id,
    String? title,
    String? subTitle,
    String? image,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      CollectionData(
        id: id ?? this.id,
        title: title ?? this.title,
        subTitle: subTitle ?? this.subTitle,
        image: image ?? this.image,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory CollectionData.fromJson(Map<String, dynamic> json) => CollectionData(
        id: json["id"],
        title: json["title"],
        subTitle: json["sub_title"],
        image: json["image"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "sub_title": subTitle,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
