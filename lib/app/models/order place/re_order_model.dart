// To parse this JSON data, do
//
//     final reOrderModel = reOrderModelFromJson(jsonString);

import 'dart:convert';

ReOrderModel reOrderModelFromJson(String str) => ReOrderModel.fromJson(json.decode(str));

String reOrderModelToJson(ReOrderModel data) => json.encode(data.toJson());

class ReOrderModel {
  bool? status;
  dynamic message;
  ReOrder? data;

  ReOrderModel({
    this.status,
    this.message,
    this.data,
  });

  ReOrderModel copyWith({
    bool? status,
    dynamic message,
    ReOrder? data,
  }) =>
      ReOrderModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ReOrderModel.fromJson(Map<String, dynamic> json) => ReOrderModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : ReOrder.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class ReOrder {
  String? redirectUrl;

  ReOrder({
    this.redirectUrl,
  });

  ReOrder copyWith({
    String? redirectUrl,
  }) =>
      ReOrder(
        redirectUrl: redirectUrl ?? this.redirectUrl,
      );

  factory ReOrder.fromJson(Map<String, dynamic> json) => ReOrder(
    redirectUrl: json["redirect_url"],
  );

  Map<String, dynamic> toJson() => {
    "redirect_url": redirectUrl,
  };
}
