// To parse this JSON data, do
//
//     final shippingAddressPostModel = shippingAddressPostModelFromJson(jsonString);

import 'dart:convert';

ShippingAddressPostModel shippingAddressPostModelFromJson(String str) => ShippingAddressPostModel.fromJson(json.decode(str));

String shippingAddressPostModelToJson(ShippingAddressPostModel data) => json.encode(data.toJson());

class ShippingAddressPostModel {
  bool? status;
  String? message;
  Data? data;

  ShippingAddressPostModel({
    this.status,
    this.message,
    this.data,
  });

  ShippingAddressPostModel copyWith({
    bool? status,
    String? message,
    Data? data,
  }) =>
      ShippingAddressPostModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ShippingAddressPostModel.fromJson(Map<String, dynamic> json) => ShippingAddressPostModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  String? name;
  String? email;
  String? phone;
  String? selectedArea;
  String? address;
  String? district;
  String? city;
  String? deliveryCharge;
  String? label;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Data({
    this.name,
    this.email,
    this.phone,
    this.selectedArea,
    this.address,
    this.district,
    this.city,
    this.deliveryCharge,
    this.label,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  Data copyWith({
    String? name,
    String? email,
    String? phone,
    String? selectedArea,
    String? address,
    String? district,
    String? city,
    String? deliveryCharge,
    String? label,
    DateTime? updatedAt,
    DateTime? createdAt,
    int? id,
  }) =>
      Data(
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        selectedArea: selectedArea ?? this.selectedArea,
        address: address ?? this.address,
        district: district ?? this.district,
        city: city ?? this.city,
        deliveryCharge: deliveryCharge ?? this.deliveryCharge,
        label: label ?? this.label,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    selectedArea: json["selected_area"],
    address: json["address"],
    district: json["district"],
    city: json["city"],
    deliveryCharge: json["delivery_charge"],
    label: json["label"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phone": phone,
    "selected_area": selectedArea,
    "address": address,
    "district": district,
    "city": city,
    "delivery_charge": deliveryCharge,
    "label": label,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}
