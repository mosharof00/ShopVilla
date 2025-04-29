// To parse this JSON data, do
//
//     final logOutModel = logOutModelFromJson(jsonString);

import 'dart:convert';

LogOutModel logOutModelFromJson(String str) => LogOutModel.fromJson(json.decode(str));

String logOutModelToJson(LogOutModel data) => json.encode(data.toJson());

class LogOutModel {
  String? message;

  LogOutModel({
    this.message,
  });

  LogOutModel copyWith({
    String? message,
  }) =>
      LogOutModel(
        message: message ?? this.message,
      );

  factory LogOutModel.fromJson(Map<String, dynamic> json) => LogOutModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
