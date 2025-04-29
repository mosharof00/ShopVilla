// To parse this JSON data, do
//
//     final brandModel = brandModelFromJson(jsonString);

import 'dart:convert';

BrandModel brandModelFromJson(String str) => BrandModel.fromJson(json.decode(str));

String brandModelToJson(BrandModel data) => json.encode(data.toJson());

class BrandModel {
  String? title;
  Brands? data;

  BrandModel({
    this.title,
    this.data,
  });

  BrandModel copyWith({
    String? title,
    Brands? data,
  }) =>
      BrandModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
    title: json["title"],
    data: json["data"] == null ? null : Brands.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "data": data?.toJson(),
  };
}

class Brands {
  int? currentPage;
  List<Brand>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Brands({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  Brands copyWith({
    int? currentPage,
    List<Brand>? data,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    List<Link>? links,
    dynamic nextPageUrl,
    String? path,
    int? perPage,
    dynamic prevPageUrl,
    int? to,
    int? total,
  }) =>
      Brands(
        currentPage: currentPage ?? this.currentPage,
        data: data ?? this.data,
        firstPageUrl: firstPageUrl ?? this.firstPageUrl,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        lastPageUrl: lastPageUrl ?? this.lastPageUrl,
        links: links ?? this.links,
        nextPageUrl: nextPageUrl ?? this.nextPageUrl,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        prevPageUrl: prevPageUrl ?? this.prevPageUrl,
        to: to ?? this.to,
        total: total ?? this.total,
      );

  factory Brands.fromJson(Map<String, dynamic> json) => Brands(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<Brand>.from(json["data"]!.map((x) => Brand.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Brand {
  int? id;
  String? name;
  String? slug;
  String? image;
  String? desc;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Brand({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.desc,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Brand copyWith({
    int? id,
    String? name,
    String? slug,
    String? image,
    String? desc,
    bool? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Brand(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        image: image ?? this.image,
        desc: desc ?? this.desc,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    image: json["image"],
    desc: json["desc"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "image": image,
    "desc": desc,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  Link copyWith({
    String? url,
    String? label,
    bool? active,
  }) =>
      Link(
        url: url ?? this.url,
        label: label ?? this.label,
        active: active ?? this.active,
      );

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
