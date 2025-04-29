import 'dart:convert';

class DeliveryOptionsModel {
  String? title;
  DeliveryOptions? data;

  DeliveryOptionsModel({
    this.title,
    this.data,
  });

  DeliveryOptionsModel copyWith({
    String? title,
    DeliveryOptions? data,
  }) =>
      DeliveryOptionsModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory DeliveryOptionsModel.fromRawJson(String str) => DeliveryOptionsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeliveryOptionsModel.fromJson(Map<String, dynamic> json) => DeliveryOptionsModel(
    title: json["title"],
    data: json["data"] == null ? null : DeliveryOptions.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "data": data?.toJson(),
  };
}

class DeliveryOptions {
  int? id;
  String? normalDeliveryFee;
  String? normalDeliveryDuration;
  String? normalDeliveryStatus;
  String? expressDeliveryFee;
  String? expressDeliveryDuration;
  String? expressDeliveryStatus;
  String? pickUpOurPlaceFee;
  String? pickUpOurPlaceDuration;
  String? pickUpOurPlaceStatus;
  String? freeShippingFee;
  String? freeShippingStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  DeliveryOptions({
    this.id,
    this.normalDeliveryFee,
    this.normalDeliveryDuration,
    this.normalDeliveryStatus,
    this.expressDeliveryFee,
    this.expressDeliveryDuration,
    this.expressDeliveryStatus,
    this.pickUpOurPlaceFee,
    this.pickUpOurPlaceDuration,
    this.pickUpOurPlaceStatus,
    this.freeShippingFee,
    this.freeShippingStatus,
    this.createdAt,
    this.updatedAt,
  });

  DeliveryOptions copyWith({
    int? id,
    String? normalDeliveryFee,
    String? normalDeliveryDuration,
    String? normalDeliveryStatus,
    String? expressDeliveryFee,
    String? expressDeliveryDuration,
    String? expressDeliveryStatus,
    String? pickUpOurPlaceFee,
    String? pickUpOurPlaceDuration,
    String? pickUpOurPlaceStatus,
    String? freeShippingFee,
    String? freeShippingStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      DeliveryOptions(
        id: id ?? this.id,
        normalDeliveryFee: normalDeliveryFee ?? this.normalDeliveryFee,
        normalDeliveryDuration: normalDeliveryDuration ?? this.normalDeliveryDuration,
        normalDeliveryStatus: normalDeliveryStatus ?? this.normalDeliveryStatus,
        expressDeliveryFee: expressDeliveryFee ?? this.expressDeliveryFee,
        expressDeliveryDuration: expressDeliveryDuration ?? this.expressDeliveryDuration,
        expressDeliveryStatus: expressDeliveryStatus ?? this.expressDeliveryStatus,
        pickUpOurPlaceFee: pickUpOurPlaceFee ?? this.pickUpOurPlaceFee,
        pickUpOurPlaceDuration: pickUpOurPlaceDuration ?? this.pickUpOurPlaceDuration,
        pickUpOurPlaceStatus: pickUpOurPlaceStatus ?? this.pickUpOurPlaceStatus,
        freeShippingFee: freeShippingFee ?? this.freeShippingFee,
        freeShippingStatus: freeShippingStatus ?? this.freeShippingStatus,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory DeliveryOptions.fromRawJson(String str) => DeliveryOptions.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeliveryOptions.fromJson(Map<String, dynamic> json) => DeliveryOptions(
    id: json["id"],
    normalDeliveryFee: json["normal_delivery_fee"],
    normalDeliveryDuration: json["normal_delivery_duration"],
    normalDeliveryStatus: json["normal_delivery_status"],
    expressDeliveryFee: json["express_delivery_fee"],
    expressDeliveryDuration: json["express_delivery_duration"],
    expressDeliveryStatus: json["express_delivery_status"],
    pickUpOurPlaceFee: json["pick_up_our_place_fee"],
    pickUpOurPlaceDuration: json["pick_up_our_place_duration"],
    pickUpOurPlaceStatus: json["pick_up_our_place_status"],
    freeShippingFee: json["free_shipping_fee"],
    freeShippingStatus: json["free_shipping_status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "normal_delivery_fee": normalDeliveryFee,
    "normal_delivery_duration": normalDeliveryDuration,
    "normal_delivery_status": normalDeliveryStatus,
    "express_delivery_fee": expressDeliveryFee,
    "express_delivery_duration": expressDeliveryDuration,
    "express_delivery_status": expressDeliveryStatus,
    "pick_up_our_place_fee": pickUpOurPlaceFee,
    "pick_up_our_place_duration": pickUpOurPlaceDuration,
    "pick_up_our_place_status": pickUpOurPlaceStatus,
    "free_shipping_fee": freeShippingFee,
    "free_shipping_status": freeShippingStatus,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
