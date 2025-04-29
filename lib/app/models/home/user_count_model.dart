// To parse this JSON data, do
//
//     final userCountModel = userCountModelFromJson(jsonString);

import 'dart:convert';

DashboardUserCountModel userCountModelFromJson(String str) =>
    DashboardUserCountModel.fromJson(json.decode(str));

String userCountModelToJson(DashboardUserCountModel data) =>
    json.encode(data.toJson());

class DashboardUserCountModel {
  String? title;
  UserCountData? data;
  String? message;

  DashboardUserCountModel({
    this.title,
    this.data,
    this.message,
  });

  DashboardUserCountModel copyWith({
    String? title,
    UserCountData? data,
    String? message,
  }) =>
      DashboardUserCountModel(
        title: title ?? this.title,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory DashboardUserCountModel.fromJson(Map<String, dynamic> json) =>
      DashboardUserCountModel(
        title: json["title"],
        data:
            json["data"] == null ? null : UserCountData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "data": data?.toJson(),
        "message": message,
      };
}

class UserCountData {
  int? totalActiveOrder;
  int? totalNotification;
  int? totalCart;
  int? totalWishlist;

  UserCountData({
    this.totalActiveOrder,
    this.totalNotification,
    this.totalCart,
    this.totalWishlist,
  });

  UserCountData copyWith({
    int? totalActiveOrder,
    int? totalNotification,
    int? totalCart,
    int? totalWishlist,
  }) =>
      UserCountData(
        totalActiveOrder: totalActiveOrder ?? this.totalActiveOrder,
        totalNotification: totalNotification ?? this.totalNotification,
        totalCart: totalCart ?? this.totalCart,
        totalWishlist: totalWishlist ?? this.totalWishlist,
      );

  factory UserCountData.fromJson(Map<String, dynamic> json) => UserCountData(
        totalActiveOrder: json["total_active_order"],
        totalNotification: json["total_notification"],
        totalCart: json["total_cart"],
        totalWishlist: json["total_wishlist"],
      );

  Map<String, dynamic> toJson() => {
        "total_active_order": totalActiveOrder,
        "total_notification": totalNotification,
        "total_cart": totalCart,
        "total_wishlist": totalWishlist,
      };
}
