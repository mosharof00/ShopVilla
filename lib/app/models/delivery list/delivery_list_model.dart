import 'dart:convert';

class DeliveryListModel {
  String? title;
  List<DeliveryList>? data;

  DeliveryListModel({
    this.title,
    this.data,
  });

  DeliveryListModel copyWith({
    String? title,
    List<DeliveryList>? data,
  }) =>
      DeliveryListModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory DeliveryListModel.fromRawJson(String str) => DeliveryListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeliveryListModel.fromJson(Map<String, dynamic> json) => DeliveryListModel(
    title: json["title"],
    data: json["data"] == null ? [] : List<DeliveryList>.from(json["data"]!.map((x) => DeliveryList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DeliveryList {
  int? id;
  String? city;
  String? amount;
  DateTime? createdAt;
  DateTime? updatedAt;

  DeliveryList({
    this.id,
    this.city,
    this.amount,
    this.createdAt,
    this.updatedAt,
  });

  DeliveryList copyWith({
    int? id,
    String? city,
    String? amount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      DeliveryList(
        id: id ?? this.id,
        city: city ?? this.city,
        amount: amount ?? this.amount,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory DeliveryList.fromRawJson(String str) => DeliveryList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeliveryList.fromJson(Map<String, dynamic> json) => DeliveryList(
    id: json["id"],
    city: json["city"],
    amount: json["amount"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "city": city,
    "amount": amount,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
