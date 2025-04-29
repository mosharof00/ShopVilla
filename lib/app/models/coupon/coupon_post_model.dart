import 'dart:convert';

PromosPostModel promosPostModelFromJson(String str) => PromosPostModel.fromJson(json.decode(str));

String promosPostModelToJson(PromosPostModel data) => json.encode(data.toJson());

class PromosPostModel {
  bool? status;
  String? message;
  Promo? data;

  PromosPostModel({
    this.status,
    this.message,
    this.data,
  });

  PromosPostModel copyWith({
    bool? status,
    String? message,
    Promo? data,
  }) =>
      PromosPostModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory PromosPostModel.fromJson(Map<String, dynamic> json) => PromosPostModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Promo.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Promo {
  String? status;
  String? discount;
  String? total;

  Promo({
    this.status,
    this.discount,
    this.total,
  });

  Promo copyWith({
    String? status,
    String? discount,
    String? total,
  }) =>
      Promo(
        status: status ?? this.status,
        discount: discount ?? this.discount,
        total: total ?? this.total,
      );

  factory Promo.fromJson(Map<String, dynamic> json) => Promo(
    status: json["status"],
    discount: json["discount"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "discount": discount,
    "total": total,
  };
}
