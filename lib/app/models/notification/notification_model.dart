import 'dart:convert';

class NotificationModel {
  String? title;
  List<NotificationData>? data;

  NotificationModel({
    this.title,
    this.data,
  });

  NotificationModel copyWith({
    String? title,
    List<NotificationData>? data,
  }) =>
      NotificationModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory NotificationModel.fromRawJson(String str) => NotificationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    title: json["title"],
    data: json["data"] == null ? [] : List<NotificationData>.from(json["data"]!.map((x) => NotificationData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class NotificationData {
  int? id;
  int? userId;
  String? title;
  String? description;
  String? image;
  String? link;
  String? url;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? type;
  String? invoice;

  NotificationData({
    this.id,
    this.userId,
    this.title,
    this.description,
    this.image,
    this.link,
    this.url,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.invoice,
  });

  NotificationData copyWith({
    int? id,
    int? userId,
    String? title,
    String? description,
    String? image,
    String? link,
    String? url,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? type,
    String? invoice,
  }) =>
      NotificationData(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        description: description ?? this.description,
        image: image ?? this.image,
        link: link ?? this.link,
        url: url ?? this.url,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        type: type ?? this.type,
        invoice: invoice ?? this.invoice,
      );

  factory NotificationData.fromRawJson(String str) => NotificationData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
    id: json["id"],
    userId: json["user_id"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    link: json["link"],
    url: json["url"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    type: json["type"],
    invoice: json["invoice"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "title": title,
    "description": description,
    "image": image,
    "link": link,
    "url": url,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "type": type,
    "invoice": invoice,
  };
}