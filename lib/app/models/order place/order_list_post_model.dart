// To parse this JSON data, do
//
//     final orderListPostModel = orderListPostModelFromJson(jsonString);

import 'dart:convert';

OrderListPostModel orderListPostModelFromJson(String str) => OrderListPostModel.fromJson(json.decode(str));

String orderListPostModelToJson(OrderListPostModel data) => json.encode(data.toJson());

class OrderListPostModel {
  bool? status;
  String? message;
  ConfirmOrder? data;

  OrderListPostModel({
    this.status,
    this.message,
    this.data,
  });

  OrderListPostModel copyWith({
    bool? status,
    String? message,
    ConfirmOrder? data,
  }) =>
      OrderListPostModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory OrderListPostModel.fromJson(Map<String, dynamic> json) => OrderListPostModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : ConfirmOrder.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class ConfirmOrder {
  String? status;
  String? logo;
  String? redirectUrl;

  ConfirmOrder({
    this.status,
    this.logo,
    this.redirectUrl,
  });

  ConfirmOrder copyWith({
    String? status,
    String? logo,
    String? redirectUrl,
  }) =>
      ConfirmOrder(
        status: status ?? this.status,
        logo: logo ?? this.logo,
        redirectUrl: redirectUrl ?? this.redirectUrl,
      );

  factory ConfirmOrder.fromJson(Map<String, dynamic> json) => ConfirmOrder(
    status: json["status"],
    logo: json["logo"],
    redirectUrl: json["redirect_url"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "logo": logo,
    "redirect_url": redirectUrl,
  };
}
