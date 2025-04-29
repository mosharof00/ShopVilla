// To parse this JSON data, do
//
//     final shippingAddressUpdateModel = shippingAddressUpdateModelFromJson(jsonString);

import 'dart:convert';

ShippingAddressUpdateModel shippingAddressUpdateModelFromJson(String str) => ShippingAddressUpdateModel.fromJson(json.decode(str));

String shippingAddressUpdateModelToJson(ShippingAddressUpdateModel data) => json.encode(data.toJson());

class ShippingAddressUpdateModel {
  bool? status;
  String? message;
  bool? data;

  ShippingAddressUpdateModel({
    this.status,
    this.message,
    this.data,
  });

  ShippingAddressUpdateModel copyWith({
    bool? status,
    String? message,
    bool? data,
  }) =>
      ShippingAddressUpdateModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ShippingAddressUpdateModel.fromJson(Map<String, dynamic> json) => ShippingAddressUpdateModel(
    status: json["status"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
  };
}
