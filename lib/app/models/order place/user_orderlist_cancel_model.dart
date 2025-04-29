// To parse this JSON data, do
//
//     final userOrderListCancelModel = userOrderListCancelModelFromJson(jsonString);

import 'dart:convert';

UserOrderListCancelModel userOrderListCancelModelFromJson(String str) => UserOrderListCancelModel.fromJson(json.decode(str));

String userOrderListCancelModelToJson(UserOrderListCancelModel data) => json.encode(data.toJson());

class UserOrderListCancelModel {
  bool? status;
  dynamic message;

  UserOrderListCancelModel({
    this.status,
    this.message,
  });

  UserOrderListCancelModel copyWith({
    bool? status,
    dynamic message,
  }) =>
      UserOrderListCancelModel(
        status: status ?? this.status,
        message: message ?? this.message,
      );

  factory UserOrderListCancelModel.fromJson(Map<String, dynamic> json) => UserOrderListCancelModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
