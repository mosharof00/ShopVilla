// To parse this JSON data, do
//
//     final currencyModel = currencyModelFromJson(jsonString);

import 'dart:convert';

CurrencyModel currencyModelFromJson(String str) => CurrencyModel.fromJson(json.decode(str));

String currencyModelToJson(CurrencyModel data) => json.encode(data.toJson());

class CurrencyModel {
  String? title;
  Currency? data;

  CurrencyModel({
    this.title,
    this.data,
  });

  CurrencyModel copyWith({
    String? title,
    Currency? data,
  }) =>
      CurrencyModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory CurrencyModel.fromJson(Map<String, dynamic> json) => CurrencyModel(
    title: json["title"],
    data: json["data"] == null ? null : Currency.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "data": data?.toJson(),
  };
}

class Currency {
  int? id;
  int? adminId;
  String? country;
  String? name;
  String? code;
  String? symbol;
  String? symbolPosition;
  String? image;
  String? rate;
  int? dataDefault;
  int? status;
  dynamic createdAt;
  dynamic updatedAt;

  Currency({
    this.id,
    this.adminId,
    this.country,
    this.name,
    this.code,
    this.symbol,
    this.symbolPosition,
    this.image,
    this.rate,
    this.dataDefault,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Currency copyWith({
    int? id,
    int? adminId,
    String? country,
    String? name,
    String? code,
    String? symbol,
    String? symbolPosition,
    String? image,
    String? rate,
    int? dataDefault,
    int? status,
    dynamic createdAt,
    dynamic updatedAt,
  }) =>
      Currency(
        id: id ?? this.id,
        adminId: adminId ?? this.adminId,
        country: country ?? this.country,
        name: name ?? this.name,
        code: code ?? this.code,
        symbol: symbol ?? this.symbol,
        symbolPosition: symbolPosition ?? this.symbolPosition,
        image: image ?? this.image,
        rate: rate ?? this.rate,
        dataDefault: dataDefault ?? this.dataDefault,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
    id: json["id"],
    adminId: json["admin_id"],
    country: json["country"],
    name: json["name"],
    code: json["code"],
    symbol: json["symbol"],
    symbolPosition: json["symbol_position"],
    image: json["image"],
    rate: json["rate"],
    dataDefault: json["default"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "admin_id": adminId,
    "country": country,
    "name": name,
    "code": code,
    "symbol": symbol,
    "symbol_position": symbolPosition,
    "image": image,
    "rate": rate,
    "default": dataDefault,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
