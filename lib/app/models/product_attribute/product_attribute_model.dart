// To parse this JSON data, do
//
//     final productAttributeModel = productAttributeModelFromJson(jsonString);

import 'dart:convert';

ProductAttributeModel productAttributeModelFromJson(String str) =>
    ProductAttributeModel.fromJson(json.decode(str));

String productAttributeModelToJson(ProductAttributeModel data) =>
    json.encode(data.toJson());

class ProductAttributeModel {
  String? title;
  Data? data;

  ProductAttributeModel({
    this.title,
    this.data,
  });

  ProductAttributeModel copyWith({
    String? title,
    Data? data,
  }) =>
      ProductAttributeModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory ProductAttributeModel.fromJson(Map<String, dynamic> json) =>
      ProductAttributeModel(
        title: json["title"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "data": data?.toJson(),
      };
}

class Data {
  List<AttributeName>? attributeName;
  List<Attribute>? attributes;

  Data({
    this.attributeName,
    this.attributes,
  });

  Data copyWith({
    List<AttributeName>? attributeName,
    List<Attribute>? attributes,
  }) =>
      Data(
        attributeName: attributeName ?? this.attributeName,
        attributes: attributes ?? this.attributes,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        attributeName: json["attributeName"] == null
            ? []
            : List<AttributeName>.from(
                json["attributeName"]!.map((x) => AttributeName.fromJson(x))),
        attributes: json["attributes"] == null
            ? []
            : List<Attribute>.from(
                json["attributes"]!.map((x) => Attribute.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "attributeName": attributeName == null
            ? []
            : List<dynamic>.from(attributeName!.map((x) => x.toJson())),
        "attributes": attributes == null
            ? []
            : List<dynamic>.from(attributes!.map((x) => x.toJson())),
      };
}

class AttributeName {
  int? id;
  String? name;
  int? status;
  dynamic createdAt;
  dynamic updatedAt;

  AttributeName({
    this.id,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  AttributeName copyWith({
    int? id,
    String? name,
    int? status,
    dynamic createdAt,
    dynamic updatedAt,
  }) =>
      AttributeName(
        id: id ?? this.id,
        name: name ?? this.name,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory AttributeName.fromJson(Map<String, dynamic> json) => AttributeName(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Attribute {
  int? id;
  String? name;
  String? value;
  String? colorCode;
  int? attributeNameId;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Attribute({
    this.id,
    this.name,
    this.value,
    this.colorCode,
    this.attributeNameId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Attribute copyWith({
    int? id,
    String? name,
    String? value,
    String? colorCode,
    int? attributeNameId,
    int? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Attribute(
        id: id ?? this.id,
        name: name ?? this.name,
        value: value ?? this.value,
        colorCode: colorCode ?? this.colorCode,
        attributeNameId: attributeNameId ?? this.attributeNameId,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        id: json["id"],
        name: json["name"],
        value: json["value"],
        colorCode: json["color_code"],
        attributeNameId: json["attribute_name_id"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "value": value,
        "color_code": colorCode,
        "attribute_name_id": attributeNameId,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
