// To parse this JSON data, do
//
//     final sliderModel = sliderModelFromJson(jsonString);

import 'dart:convert';

SliderModel sliderModelFromJson(String str) => SliderModel.fromJson(json.decode(str));

String sliderModelToJson(SliderModel data) => json.encode(data.toJson());

class SliderModel {
  String? title;
  List<Sliders>? data;

  SliderModel({
    this.title,
    this.data,
  });

  SliderModel copyWith({
    String? title,
    List<Sliders>? data,
  }) =>
      SliderModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
    title: json["title"],
    data: json["data"] == null ? [] : List<Sliders>.from(json["data"]!.map((x) => Sliders.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Sliders {
  int? id;
  String? subHeading;
  String? heading;
  String? desc;
  String? startingAmount;
  String? buttonText;
  String? buttonLink;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  Sliders({
    this.id,
    this.subHeading,
    this.heading,
    this.desc,
    this.startingAmount,
    this.buttonText,
    this.buttonLink,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  Sliders copyWith({
    int? id,
    String? subHeading,
    String? heading,
    String? desc,
    String? startingAmount,
    String? buttonText,
    String? buttonLink,
    String? image,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Sliders(
        id: id ?? this.id,
        subHeading: subHeading ?? this.subHeading,
        heading: heading ?? this.heading,
        desc: desc ?? this.desc,
        startingAmount: startingAmount ?? this.startingAmount,
        buttonText: buttonText ?? this.buttonText,
        buttonLink: buttonLink ?? this.buttonLink,
        image: image ?? this.image,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Sliders.fromJson(Map<String, dynamic> json) => Sliders(
    id: json["id"],
    subHeading: json["sub_heading"],
    heading: json["heading"],
    desc: json["desc"],
    startingAmount: json["starting_amount"],
    buttonText: json["button_text"],
    buttonLink: json["button_link"],
    image: json["image"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sub_heading": subHeading,
    "heading": heading,
    "desc": desc,
    "starting_amount": startingAmount,
    "button_text": buttonText,
    "button_link": buttonLink,
    "image": image,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
