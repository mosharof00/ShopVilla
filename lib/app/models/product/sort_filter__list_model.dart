// To parse this JSON data, do
//
//     final sort = sortFromJson(jsonString);

import 'dart:convert';

SortFilterListModel sortFromJson(String str) =>
    SortFilterListModel.fromJson(json.decode(str));

String sortToJson(SortFilterListModel data) => json.encode(data.toJson());

class SortFilterListModel {
  bool? status;
  String? message;
  Data? data;

  SortFilterListModel({
    this.status,
    this.message,
    this.data,
  });

  factory SortFilterListModel.fromJson(Map<String, dynamic> json) =>
      SortFilterListModel(
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
  List<FilterType>? type;
  List<Sort>? sort;

  Data({
    this.type,
    this.sort,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        type: json["type"] == null
            ? []
            : List<FilterType>.from(
                json["type"]!.map((x) => FilterType.fromJson(x))),
        sort: json["sort"] == null
            ? []
            : List<Sort>.from(json["sort"]!.map((x) => Sort.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type == null
            ? []
            : List<dynamic>.from(type!.map((x) => x.toJson())),
        "sort": sort == null
            ? []
            : List<dynamic>.from(sort!.map((x) => x.toJson())),
      };
}

class FilterType {
  String? status;
  String? value;

  FilterType({
    this.status,
    this.value,
  });

  factory FilterType.fromJson(Map<String, dynamic> json) => FilterType(
        status: json["status"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "value": value,
      };
}

class Sort {
  String? status;
  String? value;

  Sort({
    this.status,
    this.value,
  });

  factory Sort.fromJson(Map<String, dynamic> json) => Sort(
        status: json["status"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "value": value,
      };
}
