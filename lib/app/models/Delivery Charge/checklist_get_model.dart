import 'dart:convert';

class DeliveryChargeModel {
  String? title;
  DeliveryCharge? data;

  DeliveryChargeModel({
    this.title,
    this.data,
  });

  DeliveryChargeModel copyWith({
    String? title,
    DeliveryCharge? data,
  }) =>
      DeliveryChargeModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory DeliveryChargeModel.fromRawJson(String str) => DeliveryChargeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeliveryChargeModel.fromJson(Map<String, dynamic> json) => DeliveryChargeModel(
    title: json["title"],
    data: json["data"] == null ? null : DeliveryCharge.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "data": data?.toJson(),
  };
}

class DeliveryCharge {
  String? shippingCharge;
  String? deliveryChargeType;

  DeliveryCharge({
    this.shippingCharge,
    this.deliveryChargeType,
  });

  DeliveryCharge copyWith({
    String? shippingCharge,
    String? deliveryChargeType,
  }) =>
      DeliveryCharge(
        shippingCharge: shippingCharge ?? this.shippingCharge,
        deliveryChargeType: deliveryChargeType ?? this.deliveryChargeType,
      );

  factory DeliveryCharge.fromRawJson(String str) => DeliveryCharge.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeliveryCharge.fromJson(Map<String, dynamic> json) => DeliveryCharge(
    shippingCharge: json["shippingCharge"],
    deliveryChargeType: json["delivery_charge_type"],
  );

  Map<String, dynamic> toJson() => {
    "shippingCharge": shippingCharge,
    "delivery_charge_type": deliveryChargeType,
  };
}
