// To parse this JSON data, do
//
//     final courierGetModel = courierGetModelFromJson(jsonString);

import 'dart:convert';

CourierGetModel courierGetModelFromJson(String str) =>
    CourierGetModel.fromJson(json.decode(str));

String courierGetModelToJson(CourierGetModel data) =>
    json.encode(data.toJson());

class CourierGetModel {
  String? title;
  List<CourierData>? data;

  CourierGetModel({
    this.title,
    this.data,
  });

  CourierGetModel copyWith({
    String? title,
    List<CourierData>? data,
  }) =>
      CourierGetModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory CourierGetModel.fromJson(Map<String, dynamic> json) =>
      CourierGetModel(
        title: json["title"],
        data: json["data"] == null
            ? []
            : List<CourierData>.from(
                json["data"]!.map((x) => CourierData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CourierData {
  int? id;
  String? courierName;
  String? charge;
  String? available;
  String? image;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  CourierData({
    this.id,
    this.courierName,
    this.charge,
    this.available,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  CourierData copyWith({
    int? id,
    String? courierName,
    String? charge,
    String? available,
    String? image,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      CourierData(
        id: id ?? this.id,
        courierName: courierName ?? this.courierName,
        charge: charge ?? this.charge,
        available: available ?? this.available,
        image: image ?? this.image,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory CourierData.fromJson(Map<String, dynamic> json) => CourierData(
        id: json["id"],
        courierName: json["courierName"],
        charge: json["charge"],
        available: json["available"],
        image: json["image"],
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
        "courierName": courierName,
        "charge": charge,
        "available": available,
        "image": image,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
