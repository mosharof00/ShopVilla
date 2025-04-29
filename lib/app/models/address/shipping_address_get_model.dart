// To parse this JSON data, do
//
//     final shippingAddressGetModel = shippingAddressGetModelFromJson(jsonString);

import 'dart:convert';

ShippingAddressGetModel shippingAddressGetModelFromJson(String str) => ShippingAddressGetModel.fromJson(json.decode(str));

String shippingAddressGetModelToJson(ShippingAddressGetModel data) => json.encode(data.toJson());

class ShippingAddressGetModel {
  bool? status;
  String? message;
  List<Address>? data;

  ShippingAddressGetModel({
    this.status,
    this.message,
    this.data,
  });

  ShippingAddressGetModel copyWith({
    bool? status,
    String? message,
    List<Address>? data,
  }) =>
      ShippingAddressGetModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ShippingAddressGetModel.fromJson(Map<String, dynamic> json) => ShippingAddressGetModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Address>.from(json["data"]!.map((x) => Address.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Address {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? selectedArea;
  String? address;
  String? city;
  String? district;
  String? deliveryCharge;
  dynamic label;
  DateTime? createdAt;
  DateTime? updatedAt;

  Address({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.selectedArea,
    this.address,
    this.city,
    this.district,
    this.deliveryCharge,
    this.label,
    this.createdAt,
    this.updatedAt,
  });

  Address copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? selectedArea,
    String? address,
    String? city,
    String? district,
    String? deliveryCharge,
    dynamic label,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Address(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        selectedArea: selectedArea ?? this.selectedArea,
        address: address ?? this.address,
        city: city ?? this.city,
        district: district ?? this.district,
        deliveryCharge: deliveryCharge ?? this.deliveryCharge,
        label: label ?? this.label,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    selectedArea: json["selected_area"],
    address: json["address"],
    city: json["city"],
    district: json["district"],
    deliveryCharge: json["delivery_charge"],
    label: json["label"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "selected_area": selectedArea,
    "address": address,
    "city": city,
    "district": district,
    "delivery_charge": deliveryCharge,
    "label": label,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
