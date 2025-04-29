import 'dart:convert';

class PaymentModel {
  bool? status;
  String? message;
  Data? data;

  PaymentModel({
    this.status,
    this.message,
    this.data,
  });

  PaymentModel copyWith({
    bool? status,
    String? message,
    Data? data,
  }) =>
      PaymentModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory PaymentModel.fromRawJson(String str) => PaymentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  List<PaymentType>? type;
  String? advancePaymentStatus;
  String? advancePayment;
  String? advancePaymentType;
  String? advancePaymentTitle;

  Data({
    this.type,
    this.advancePaymentStatus,
    this.advancePayment,
    this.advancePaymentType,
    this.advancePaymentTitle,
  });

  Data copyWith({
    List<PaymentType>? type,
    String? advancePaymentStatus,
    String? advancePayment,
    String? advancePaymentType,
    String? advancePaymentTitle,
  }) =>
      Data(
        type: type ?? this.type,
        advancePaymentStatus: advancePaymentStatus ?? this.advancePaymentStatus,
        advancePayment: advancePayment ?? this.advancePayment,
        advancePaymentType: advancePaymentType ?? this.advancePaymentType,
        advancePaymentTitle: advancePaymentTitle ?? this.advancePaymentTitle,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    type: json["type"] == null ? [] : List<PaymentType>.from(json["type"]!.map((x) => PaymentType.fromJson(x))),
    advancePaymentStatus: json["advance_payment_status"],
    advancePayment: json["advance_payment"],
    advancePaymentType: json["advance_payment_type"],
    advancePaymentTitle: json["advance_payment_title"],
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? [] : List<dynamic>.from(type!.map((x) => x.toJson())),
    "advance_payment_status": advancePaymentStatus,
    "advance_payment": advancePayment,
    "advance_payment_type": advancePaymentType,
    "advance_payment_title": advancePaymentTitle,
  };
}

class PaymentType {
  String? gateway;
  String? image;
  bool? active;
  String? status;
  String? value;

  PaymentType({
    this.gateway,
    this.image,
    this.active,
    this.status,
    this.value,
  });

  PaymentType copyWith({
    String? gateway,
    String? image,
    bool? active,
    String? status,
    String? value,
  }) =>
      PaymentType(
        gateway: gateway ?? this.gateway,
        image: image ?? this.image,
        active: active ?? this.active,
        status: status ?? this.status,
        value: value ?? this.value,
      );

  factory PaymentType.fromRawJson(String str) => PaymentType.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentType.fromJson(Map<String, dynamic> json) => PaymentType(
    gateway: json["gateway"],
    image: json["image"],
    active: json["active"],
    status: json["status"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "gateway": gateway,
    "image": image,
    "active": active,
    "status": status,
    "value": value,
  };
}
