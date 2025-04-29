// To parse this JSON data, do
//
//     final alertModel = alertModelFromJson(jsonString);

import 'dart:convert';

AlertModel alertModelFromJson(String str) => AlertModel.fromJson(json.decode(str));

String alertModelToJson(AlertModel data) => json.encode(data.toJson());

class AlertModel {
  String? title;
  Alert? data;

  AlertModel({
    this.title,
    this.data,
  });

  AlertModel copyWith({
    String? title,
    Alert? data,
  }) =>
      AlertModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory AlertModel.fromJson(Map<String, dynamic> json) => AlertModel(
    title: json["title"],
    data: json["data"] == null ? null : Alert.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "data": data?.toJson(),
  };
}

class Alert {
  int? id;
  String? title;
  String? discount;
  String? type;
  String? image;
  dynamic expireTime;
  String? link;
  bool? active;
  DateTime? createdAt;
  DateTime? updatedAt;

  Alert({
    this.id,
    this.title,
    this.discount,
    this.type,
    this.image,
    this.expireTime,
    this.link,
    this.active,
    this.createdAt,
    this.updatedAt,
  });

  Alert copyWith({
    int? id,
    String? title,
    String? discount,
    String? type,
    String? image,
    dynamic expireTime,
    String? link,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Alert(
        id: id ?? this.id,
        title: title ?? this.title,
        discount: discount ?? this.discount,
        type: type ?? this.type,
        image: image ?? this.image,
        expireTime: expireTime ?? this.expireTime,
        link: link ?? this.link,
        active: active ?? this.active,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Alert.fromJson(Map<String, dynamic> json) => Alert(
    id: json["id"],
    title: json["title"],
    discount: json["discount"],
    type: json["type"],
    image: json["image"],
    expireTime: json["expire_time"],
    link: json["link"],
    active: json["active"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "discount": discount,
    "type": type,
    "image": image,
    "expire_time": expireTime,
    "link": link,
    "active": active,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
