// To parse this JSON data, do
//
//     final adminInfo = adminInfoFromJson(jsonString);

import 'dart:convert';

AdminInfo adminInfoFromJson(String str) => AdminInfo.fromJson(json.decode(str));

String adminInfoToJson(AdminInfo data) => json.encode(data.toJson());

class AdminInfo {
  String? title;
  List<Admin>? data;

  AdminInfo({
    this.title,
    this.data,
  });

  AdminInfo copyWith({
    String? title,
    List<Admin>? data,
  }) =>
      AdminInfo(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory AdminInfo.fromJson(Map<String, dynamic> json) => AdminInfo(
    title: json["title"],
    data: json["data"] == null ? [] : List<Admin>.from(json["data"]!.map((x) => Admin.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Admin {
  int? id;
  String? name;
  String? displayName;
  String? appToken;
  String? uniqueId;
  String? email;
  String? phone;
  String? image;
  int? status;
  int? roleId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Admin({
    this.id,
    this.name,
    this.displayName,
    this.appToken,
    this.uniqueId,
    this.email,
    this.phone,
    this.image,
    this.status,
    this.roleId,
    this.createdAt,
    this.updatedAt,
  });

  Admin copyWith({
    int? id,
    String? name,
    String? displayName,
    String? appToken,
    String? uniqueId,
    String? email,
    String? phone,
    String? image,
    int? status,
    int? roleId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Admin(
        id: id ?? this.id,
        name: name ?? this.name,
        displayName: displayName ?? this.displayName,
        appToken: appToken ?? this.appToken,
        uniqueId: uniqueId ?? this.uniqueId,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        image: image ?? this.image,
        status: status ?? this.status,
        roleId: roleId ?? this.roleId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
    id: json["id"],
    name: json["name"],
    displayName: json["display_name"],
    appToken: json["app_token"],
    uniqueId: json["unique_id"],
    email: json["email"],
    phone: json["phone"],
    image: json["image"],
    status: json["status"],
    roleId: json["role_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "display_name": displayName,
    "app_token": appToken,
    "unique_id": uniqueId,
    "email": email,
    "phone": phone,
    "image": image,
    "status": status,
    "role_id": roleId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
