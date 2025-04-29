
import 'dart:convert';

QaGetModel qaGetModelFromJson(String str) => QaGetModel.fromJson(json.decode(str));

String qaGetModelToJson(QaGetModel data) => json.encode(data.toJson());

class QaGetModel {
  String? title;
  List<QusAnsGetList>? data;

  QaGetModel({
    this.title,
    this.data,
  });

  QaGetModel copyWith({
    String? title,
    List<QusAnsGetList>? data,
  }) =>
      QaGetModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory QaGetModel.fromJson(Map<String, dynamic> json) => QaGetModel(
    title: json["title"],
    data: json["data"] == null ? [] : List<QusAnsGetList>.from(json["data"]!.map((x) => QusAnsGetList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class QusAnsGetList {
  int? id;
  int? userId;
  String? adminId;
  String? productId;
  int? qnaId;
  String? type;
  String? from;
  String? question;
  dynamic answer;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<QusAnsGetList>? reply;
  User? user;
  Admin? admin;

  QusAnsGetList({
    this.id,
    this.userId,
    this.adminId,
    this.productId,
    this.qnaId,
    this.type,
    this.from,
    this.question,
    this.answer,
    this.createdAt,
    this.updatedAt,
    this.reply,
    this.user,
    this.admin,
  });

  QusAnsGetList copyWith({
    int? id,
    int? userId,
    String? adminId,
    String? productId,
    int? qnaId,
    String? type,
    String? from,
    String? question,
    dynamic answer,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<QusAnsGetList>? reply,
    User? user,
    Admin? admin,
  }) =>
      QusAnsGetList(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        adminId: adminId ?? this.adminId,
        productId: productId ?? this.productId,
        qnaId: qnaId ?? this.qnaId,
        type: type ?? this.type,
        from: from ?? this.from,
        question: question ?? this.question,
        answer: answer ?? this.answer,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        reply: reply ?? this.reply,
        user: user ?? this.user,
        admin: admin ?? this.admin,
      );

  factory QusAnsGetList.fromJson(Map<String, dynamic> json) => QusAnsGetList(
    id: json["id"],
    userId: json["user_id"],
    adminId: json["admin_id"],
    productId: json["product_id"],
    qnaId: json["qna_id"],
    type: json["type"],
    from: json["from"],
    question: json["question"],
    answer: json["answer"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    reply: json["reply"] == null ? [] : List<QusAnsGetList>.from(json["reply"]!.map((x) => QusAnsGetList.fromJson(x))),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    admin: json["admin"] == null ? null : Admin.fromJson(json["admin"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "admin_id": adminId,
    "product_id": productId,
    "qna_id": qnaId,
    "type": type,
    "from": from,
    "question": question,
    "answer": answer,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "reply": reply == null ? [] : List<dynamic>.from(reply!.map((x) => x.toJson())),
    "user": user?.toJson(),
    "admin": admin?.toJson(),
  };
}

class Admin {
  int? id;
  String? name;
  String? displayName;
  dynamic appToken;
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
    dynamic appToken,
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
    "email": email,
    "phone": phone,
    "image": image,
    "status": status,
    "role_id": roleId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class User {
  int? id;
  String? name;
  String? gender;
  String? birthday;
  dynamic country;
  dynamic phone;
  dynamic deviceToken;
  String? image;
  String? email;
  String? appToken;
  dynamic emailVerifiedAt;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.name,
    this.gender,
    this.birthday,
    this.country,
    this.phone,
    this.deviceToken,
    this.image,
    this.email,
    this.appToken,
    this.emailVerifiedAt,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  User copyWith({
    int? id,
    String? name,
    String? gender,
    String? birthday,
    dynamic country,
    dynamic phone,
    dynamic deviceToken,
    String? image,
    String? email,
    String? appToken,
    dynamic emailVerifiedAt,
    bool? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        gender: gender ?? this.gender,
        birthday: birthday ?? this.birthday,
        country: country ?? this.country,
        phone: phone ?? this.phone,
        deviceToken: deviceToken ?? this.deviceToken,
        image: image ?? this.image,
        email: email ?? this.email,
        appToken: appToken ?? this.appToken,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    gender: json["gender"],
    birthday: json["birthday"],
    country: json["country"],
    phone: json["phone"],
    deviceToken: json["device_token"],
    image: json["image"],
    email: json["email"],
    appToken: json["app_token"],
    emailVerifiedAt: json["email_verified_at"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "gender": gender,
    "birthday": birthday,
    "country": country,
    "phone": phone,
    "device_token": deviceToken,
    "image": image,
    "email": email,
    "app_token": appToken,
    "email_verified_at": emailVerifiedAt,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
