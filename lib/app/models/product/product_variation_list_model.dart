// To parse this JSON data, do
//
//     final productVariationListModel = productVariationListModelFromJson(jsonString);

import 'dart:convert';

ProductVariationListModel productVariationListModelFromJson(String str) =>
    ProductVariationListModel.fromJson(json.decode(str));

String productVariationListModelToJson(ProductVariationListModel data) =>
    json.encode(data.toJson());

class ProductVariationListModel {
  bool? status;
  String? message;
  List<ProductVariationListData>? data;

  ProductVariationListModel({
    this.status,
    this.message,
    this.data,
  });

  ProductVariationListModel copyWith({
    bool? status,
    String? message,
    List<ProductVariationListData>? data,
  }) =>
      ProductVariationListModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ProductVariationListModel.fromJson(Map<String, dynamic> json) =>
      ProductVariationListModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ProductVariationListData>.from(
                json["data"]!.map((x) => ProductVariationListData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ProductVariationListData {
  int? id;
  int? productId;
  String? image;
  int? colorId;
  String? color;
  String? colorCode;
  int? codeId;
  Code? code;
  Status? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProductVariationListData({
    this.id,
    this.productId,
    this.image,
    this.colorId,
    this.color,
    this.colorCode,
    this.codeId,
    this.code,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  ProductVariationListData copyWith({
    int? id,
    int? productId,
    String? image,
    int? colorId,
    String? color,
    String? colorCode,
    int? codeId,
    Code? code,
    Status? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ProductVariationListData(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        image: image ?? this.image,
        colorId: colorId ?? this.colorId,
        color: color ?? this.color,
        colorCode: colorCode ?? this.colorCode,
        codeId: codeId ?? this.codeId,
        code: code ?? this.code,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ProductVariationListData.fromJson(Map<String, dynamic> json) =>
      ProductVariationListData(
        id: json["id"],
        productId: json["product_id"],
        image: json["image"],
        colorId: json["color_id"],
        color: json["color"],
        colorCode: json["color_code"],
        codeId: json["code_id"],
        code: codeValues.map[json["code"]]!,
        status: statusValues.map[json["status"]]!,
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "image": image,
        "color_id": colorId,
        "color": color,
        "color_code": colorCode,
        "code_id": codeId,
        "code": codeValues.reverse[code],
        "status": statusValues.reverse[status],
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

enum Code { NO_SIZE }

final codeValues = EnumValues({"No Size": Code.NO_SIZE});

enum Status { ACTIVE }

final statusValues = EnumValues({"Active": Status.ACTIVE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
