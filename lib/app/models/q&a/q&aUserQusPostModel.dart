// To parse this JSON data, do
//
//     final qaUserPostModel = qaUserPostModelFromJson(jsonString);

import 'dart:convert';

QaUserPostModel qaUserPostModelFromJson(String str) => QaUserPostModel.fromJson(json.decode(str));

String qaUserPostModelToJson(QaUserPostModel data) => json.encode(data.toJson());

class QaUserPostModel {
  bool? status;
  String? message;
  UserQus? data;

  QaUserPostModel({
    this.status,
    this.message,
    this.data,
  });

  QaUserPostModel copyWith({
    bool? status,
    String? message,
    UserQus? data,
  }) =>
      QaUserPostModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory QaUserPostModel.fromJson(Map<String, dynamic> json) => QaUserPostModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : UserQus.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class UserQus {
  int? userId;
  String? adminId;
  String? productId;
  String? type;
  String? from;
  String? question;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  UserQus({
    this.userId,
    this.adminId,
    this.productId,
    this.type,
    this.from,
    this.question,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  UserQus copyWith({
    int? userId,
    String? adminId,
    String? productId,
    String? type,
    String? from,
    String? question,
    DateTime? updatedAt,
    DateTime? createdAt,
    int? id,
  }) =>
      UserQus(
        userId: userId ?? this.userId,
        adminId: adminId ?? this.adminId,
        productId: productId ?? this.productId,
        type: type ?? this.type,
        from: from ?? this.from,
        question: question ?? this.question,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
      );

  factory UserQus.fromJson(Map<String, dynamic> json) => UserQus(
    userId: json["user_id"],
    adminId: json["admin_id"],
    productId: json["product_id"],
    type: json["type"],
    from: json["from"],
    question: json["question"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "admin_id": adminId,
    "product_id": productId,
    "type": type,
    "from": from,
    "question": question,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}
