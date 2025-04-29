// To parse this JSON data, do
//
//     final forgotPasswordModel = forgotPasswordModelFromJson(jsonString);

import 'dart:convert';

ForgotPasswordModel forgotPasswordModelFromJson(String str) =>
    ForgotPasswordModel.fromJson(json.decode(str));

String forgotPasswordModelToJson(ForgotPasswordModel data) =>
    json.encode(data.toJson());

class ForgotPasswordModel {
  bool? status;
  List<String>? message;
  ForgotPasswordData? data;

  ForgotPasswordModel({
    this.status,
    this.message,
    this.data,
  });

  ForgotPasswordModel copyWith({
    bool? status,
    List<String>? message,
    ForgotPasswordData? data,
  }) =>
      ForgotPasswordModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordModel(
        status: json["status"],
        message: json["message"] == null
            ? []
            : List<String>.from(json["message"]!.map((x) => x)),
        data: json["data"] == null
            ? null
            : ForgotPasswordData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message":
            message == null ? [] : List<dynamic>.from(message!.map((x) => x)),
        "data": data?.toJson(),
      };
}

class ForgotPasswordData {
  int? userId;
  String? token;
  int? code;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  ForgotPasswordData({
    this.userId,
    this.token,
    this.code,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  ForgotPasswordData copyWith({
    int? userId,
    String? token,
    int? code,
    DateTime? updatedAt,
    DateTime? createdAt,
    int? id,
  }) =>
      ForgotPasswordData(
        userId: userId ?? this.userId,
        token: token ?? this.token,
        code: code ?? this.code,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
      );

  factory ForgotPasswordData.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordData(
        userId: json["user_id"],
        token: json["token"],
        code: json["code"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "token": token,
        "code": code,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
