import 'dart:convert';

ShippingAddressDeleteModel shippingAddressDeleteModelFromJson(String str) => ShippingAddressDeleteModel.fromJson(json.decode(str));

String shippingAddressDeleteModelToJson(ShippingAddressDeleteModel data) => json.encode(data.toJson());

class ShippingAddressDeleteModel {
  String? message;

  ShippingAddressDeleteModel({
    this.message,
  });

  ShippingAddressDeleteModel copyWith({
    String? message,
  }) =>
      ShippingAddressDeleteModel(
        message: message ?? this.message,
      );

  factory ShippingAddressDeleteModel.fromJson(Map<String, dynamic> json) => ShippingAddressDeleteModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
