// To parse this JSON data, do
//
//     final productModelApi = productModelApiFromJson(jsonString);

import 'dart:convert';

ProductModelApi productModelApiFromJson(String str) =>
    ProductModelApi.fromJson(json.decode(str));

String productModelApiToJson(ProductModelApi data) =>
    json.encode(data.toJson());

class ProductModelApi {
  String? title;
  Data? data;

  ProductModelApi({
    this.title,
    this.data,
  });

  ProductModelApi copyWith({
    String? title,
    Data? data,
  }) =>
      ProductModelApi(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory ProductModelApi.fromJson(Map<String, dynamic> json) =>
      ProductModelApi(
        title: json["title"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "data": data?.toJson(),
      };
}

class Data {
  int? currentPage;
  List<ProductData>? data;
  int? perPage;
  int? total;
  int? lastPage;
  String? nextPageUrl;
  dynamic prevPageUrl;

  Data({
    this.currentPage,
    this.data,
    this.perPage,
    this.total,
    this.lastPage,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  Data copyWith({
    int? currentPage,
    List<ProductData>? data,
    int? perPage,
    int? total,
    int? lastPage,
    String? nextPageUrl,
    dynamic prevPageUrl,
  }) =>
      Data(
        currentPage: currentPage ?? this.currentPage,
        data: data ?? this.data,
        perPage: perPage ?? this.perPage,
        total: total ?? this.total,
        lastPage: lastPage ?? this.lastPage,
        nextPageUrl: nextPageUrl ?? this.nextPageUrl,
        prevPageUrl: prevPageUrl ?? this.prevPageUrl,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<ProductData>.from(
                json["data"]!.map((x) => ProductData.fromJson(x))),
        perPage: json["per_page"],
        total: json["total"],
        lastPage: json["last_page"],
        nextPageUrl: json["next_page_url"],
        prevPageUrl: json["prev_page_url"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "per_page": perPage,
        "total": total,
        "last_page": lastPage,
        "next_page_url": nextPageUrl,
        "prev_page_url": prevPageUrl,
      };
}

class ProductData {
  int? id;
  String? productName;
  String? slug;
  String? productSku;
  int? categoryId;
  int? subCategoryId;
  int? childCategoryId;
  int? brandId;
  String? productDescription;
  String? gander;
  dynamic youtubeEmbadecode;
  dynamic shippingType;
  dynamic shippigCost;
  dynamic shippingRtnPolicy;
  dynamic offerStart;
  dynamic offerEnd;
  int? discountPercent;
  dynamic multipleQty;
  dynamic metaName;
  dynamic metaTitle;
  dynamic metaImage;
  dynamic metaKeywords;
  dynamic metaDescription;
  int? totalStock;
  int? available;
  dynamic supplierId;
  int? sold;
  String? status;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  double? reviewsAvgRating;
  List<ProductVariationData>? productvariations;
  List<SizeData>? sizes;
  List<dynamic>? weights;

  ProductData({
    this.id,
    this.productName,
    this.slug,
    this.productSku,
    this.categoryId,
    this.subCategoryId,
    this.childCategoryId,
    this.brandId,
    this.productDescription,
    this.gander,
    this.youtubeEmbadecode,
    this.shippingType,
    this.shippigCost,
    this.shippingRtnPolicy,
    this.offerStart,
    this.offerEnd,
    this.discountPercent,
    this.multipleQty,
    this.metaName,
    this.metaTitle,
    this.metaImage,
    this.metaKeywords,
    this.metaDescription,
    this.totalStock,
    this.available,
    this.supplierId,
    this.sold,
    this.status,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.reviewsAvgRating,
    this.productvariations,
    this.sizes,
    this.weights,
  });

  ProductData copyWith({
    int? id,
    String? productName,
    String? slug,
    String? productSku,
    int? categoryId,
    int? subCategoryId,
    int? childCategoryId,
    int? brandId,
    String? productDescription,
    String? gander,
    dynamic youtubeEmbadecode,
    dynamic shippingType,
    dynamic shippigCost,
    dynamic shippingRtnPolicy,
    dynamic offerStart,
    dynamic offerEnd,
    int? discountPercent,
    dynamic multipleQty,
    dynamic metaName,
    dynamic metaTitle,
    dynamic metaImage,
    dynamic metaKeywords,
    dynamic metaDescription,
    int? totalStock,
    int? available,
    dynamic supplierId,
    int? sold,
    String? status,
    String? type,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? reviewsAvgRating,
    List<ProductVariationData>? productvariations,
    List<SizeData>? sizes,
    List<dynamic>? weights,
  }) =>
      ProductData(
        id: id ?? this.id,
        productName: productName ?? this.productName,
        slug: slug ?? this.slug,
        productSku: productSku ?? this.productSku,
        categoryId: categoryId ?? this.categoryId,
        subCategoryId: subCategoryId ?? this.subCategoryId,
        childCategoryId: childCategoryId ?? this.childCategoryId,
        brandId: brandId ?? this.brandId,
        productDescription: productDescription ?? this.productDescription,
        gander: gander ?? this.gander,
        youtubeEmbadecode: youtubeEmbadecode ?? this.youtubeEmbadecode,
        shippingType: shippingType ?? this.shippingType,
        shippigCost: shippigCost ?? this.shippigCost,
        shippingRtnPolicy: shippingRtnPolicy ?? this.shippingRtnPolicy,
        offerStart: offerStart ?? this.offerStart,
        offerEnd: offerEnd ?? this.offerEnd,
        discountPercent: discountPercent ?? this.discountPercent,
        multipleQty: multipleQty ?? this.multipleQty,
        metaName: metaName ?? this.metaName,
        metaTitle: metaTitle ?? this.metaTitle,
        metaImage: metaImage ?? this.metaImage,
        metaKeywords: metaKeywords ?? this.metaKeywords,
        metaDescription: metaDescription ?? this.metaDescription,
        totalStock: totalStock ?? this.totalStock,
        available: available ?? this.available,
        supplierId: supplierId ?? this.supplierId,
        sold: sold ?? this.sold,
        status: status ?? this.status,
        type: type ?? this.type,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        reviewsAvgRating: reviewsAvgRating ?? this.reviewsAvgRating,
        productvariations: productvariations ?? this.productvariations,
        sizes: sizes ?? this.sizes,
        weights: weights ?? this.weights,
      );

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        id: json["id"],
        productName: json["product_name"],
        slug: json["slug"],
        productSku: json["product_sku"],
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
        childCategoryId: json["child_category_id"],
        brandId: json["brand_id"],
        productDescription: json["product_description"],
        gander: json["gander"],
        youtubeEmbadecode: json["youtube_embadecode"],
        shippingType: json["shipping_type"],
        shippigCost: json["shippig_cost"],
        shippingRtnPolicy: json["shipping_rtn_policy"],
        offerStart: json["offer_start"],
        offerEnd: json["offer_end"],
        discountPercent: json["discount_percent"],
        multipleQty: json["multiple_qty"],
        metaName: json["meta_name"],
        metaTitle: json["meta_title"],
        metaImage: json["meta_image"],
        metaKeywords: json["meta_keywords"],
        metaDescription: json["meta_description"],
        totalStock: json["total_stock"],
        available: json["available"],
        supplierId: json["supplier_id"],
        sold: json["sold"],
        status: json["status"],
        type: json["type"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        reviewsAvgRating: json["reviews_avg_rating"]?.toDouble(),
        productvariations: json["productvariations"] == null
            ? []
            : List<ProductVariationData>.from(json["productvariations"]!
                .map((x) => ProductVariationData.fromJson(x))),
        sizes: json["sizes"] == null
            ? []
            : List<SizeData>.from(
                json["sizes"]!.map((x) => SizeData.fromJson(x))),
        weights: json["weights"] == null
            ? []
            : List<dynamic>.from(json["weights"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "slug": slug,
        "product_sku": productSku,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "child_category_id": childCategoryId,
        "brand_id": brandId,
        "product_description": productDescription,
        "gander": gander,
        "youtube_embadecode": youtubeEmbadecode,
        "shipping_type": shippingType,
        "shippig_cost": shippigCost,
        "shipping_rtn_policy": shippingRtnPolicy,
        "offer_start": offerStart,
        "offer_end": offerEnd,
        "discount_percent": discountPercent,
        "multiple_qty": multipleQty,
        "meta_name": metaName,
        "meta_title": metaTitle,
        "meta_image": metaImage,
        "meta_keywords": metaKeywords,
        "meta_description": metaDescription,
        "total_stock": totalStock,
        "available": available,
        "supplier_id": supplierId,
        "sold": sold,
        "status": status,
        "type": type,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "reviews_avg_rating": reviewsAvgRating,
        "productvariations": productvariations == null
            ? []
            : List<dynamic>.from(productvariations!.map((x) => x.toJson())),
        "sizes": sizes == null
            ? []
            : List<dynamic>.from(sizes!.map((x) => x.toJson())),
        "weights":
            weights == null ? [] : List<dynamic>.from(weights!.map((x) => x)),
      };
}

class ProductVariationData {
  int? id;
  int? productId;
  String? image;
  int? colorId;
  String? color;
  String? colorCode;
  dynamic codeId;
  dynamic code;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<ProductvariationSize>? sizes;

  ProductVariationData({
    this.id,
    this.productId,
    this.image,
    this.colorId,
    this.color,
    this.colorCode,
    this.codeId,
    this.code,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.sizes,
  });

  ProductVariationData copyWith({
    int? id,
    int? productId,
    String? image,
    int? colorId,
    String? color,
    String? colorCode,
    dynamic codeId,
    dynamic code,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<ProductvariationSize>? sizes,
  }) =>
      ProductVariationData(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        image: image ?? this.image,
        colorId: colorId ?? this.colorId,
        color: color ?? this.color,
        colorCode: colorCode ?? this.colorCode,
        codeId: codeId ?? this.codeId,
        code: code ?? this.code,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        sizes: sizes ?? this.sizes,
      );

  factory ProductVariationData.fromJson(Map<String, dynamic> json) =>
      ProductVariationData(
        id: json["id"],
        productId: json["product_id"],
        image: json["image"],
        colorId: json["color_id"],
        color: json["color"],
        colorCode: json["color_code"],
        codeId: json["code_id"],
        code: json["code"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        sizes: json["sizes"] == null
            ? []
            : List<ProductvariationSize>.from(
                json["sizes"]!.map((x) => ProductvariationSize.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "image": image,
        "color_id": colorId,
        "color": color,
        "color_code": colorCode,
        "code_id": codeId,
        "code": code,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "sizes": sizes == null
            ? []
            : List<dynamic>.from(sizes!.map((x) => x.toJson())),
      };
}

enum Code { NO_SIZE }

final codeValues = EnumValues({"No Size": Code.NO_SIZE});

class ProductvariationSize {
  int? id;

  ProductvariationSize({
    this.id,
  });

  ProductvariationSize copyWith({
    int? id,
  }) =>
      ProductvariationSize(
        id: id ?? this.id,
      );

  factory ProductvariationSize.fromJson(Map<String, dynamic> json) =>
      ProductvariationSize(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

enum Status { ACTIVE }

final statusValues = EnumValues({"Active": Status.ACTIVE});

class SizeData {
  int? id;
  int? productId;
  int? varientId;
  int? sizeId;
  String? size;
  int? regularPrice;
  int? salePrice;
  int? discount;
  int? buyPrice;
  int? totalStock;
  int? stock;
  int? sold;
  DateTime? createdAt;
  DateTime? updatedAt;

  SizeData({
    this.id,
    this.productId,
    this.varientId,
    this.sizeId,
    this.size,
    this.regularPrice,
    this.salePrice,
    this.discount,
    this.buyPrice,
    this.totalStock,
    this.stock,
    this.sold,
    this.createdAt,
    this.updatedAt,
  });

  SizeData copyWith({
    int? id,
    int? productId,
    int? varientId,
    int? sizeId,
    String? size,
    int? regularPrice,
    int? salePrice,
    int? discount,
    int? buyPrice,
    int? totalStock,
    int? stock,
    int? sold,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      SizeData(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        varientId: varientId ?? this.varientId,
        sizeId: sizeId ?? this.sizeId,
        size: size ?? this.size,
        regularPrice: regularPrice ?? this.regularPrice,
        salePrice: salePrice ?? this.salePrice,
        discount: discount ?? this.discount,
        buyPrice: buyPrice ?? this.buyPrice,
        totalStock: totalStock ?? this.totalStock,
        stock: stock ?? this.stock,
        sold: sold ?? this.sold,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory SizeData.fromJson(Map<String, dynamic> json) => SizeData(
        id: json["id"],
        productId: json["product_id"],
        varientId: json["varient_id"],
        sizeId: json["size_id"],
        size: json["size"],
        regularPrice: json["RegularPrice"],
        salePrice: json["SalePrice"],
        discount: json["Discount"],
        buyPrice: json["buy_price"],
        totalStock: json["total_stock"],
        stock: json["stock"],
        sold: json["sold"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "varient_id": varientId,
        "size_id": sizeId,
        "size": size,
        "RegularPrice": regularPrice,
        "SalePrice": salePrice,
        "Discount": discount,
        "buy_price": buyPrice,
        "total_stock": totalStock,
        "stock": stock,
        "sold": sold,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

///   Old Product model     ///

// // To parse this JSON data, do
// //
// //     final productModelApi = productModelApiFromJson(jsonString);
//
// import 'dart:convert';
//
// ProductModelApi productModelApiFromJson(String str) =>
//     ProductModelApi.fromJson(json.decode(str));
//
// String productModelApiToJson(ProductModelApi data) =>
//     json.encode(data.toJson());
//
// class ProductModelApi {
//   String? title;
//   Data? data;
//
//   ProductModelApi({
//     this.title,
//     this.data,
//   });
//
//   ProductModelApi copyWith({
//     String? title,
//     Data? data,
//   }) =>
//       ProductModelApi(
//         title: title ?? this.title,
//         data: data ?? this.data,
//       );
//
//   factory ProductModelApi.fromJson(Map<String, dynamic> json) =>
//       ProductModelApi(
//         title: json["title"],
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "title": title,
//         "data": data?.toJson(),
//       };
// }
//
// class Data {
//   int? currentPage;
//   List<ProductData>? data;
//   String? firstPageUrl;
//   int? from;
//   int? lastPage;
//   String? lastPageUrl;
//   List<Link>? links;
//   String? nextPageUrl;
//   String? path;
//   int? perPage;
//   dynamic prevPageUrl;
//   int? to;
//   int? total;
//
//   Data({
//     this.currentPage,
//     this.data,
//     this.firstPageUrl,
//     this.from,
//     this.lastPage,
//     this.lastPageUrl,
//     this.links,
//     this.nextPageUrl,
//     this.path,
//     this.perPage,
//     this.prevPageUrl,
//     this.to,
//     this.total,
//   });
//
//   Data copyWith({
//     int? currentPage,
//     List<ProductData>? data,
//     String? firstPageUrl,
//     int? from,
//     int? lastPage,
//     String? lastPageUrl,
//     List<Link>? links,
//     String? nextPageUrl,
//     String? path,
//     int? perPage,
//     dynamic prevPageUrl,
//     int? to,
//     int? total,
//   }) =>
//       Data(
//         currentPage: currentPage ?? this.currentPage,
//         data: data ?? this.data,
//         firstPageUrl: firstPageUrl ?? this.firstPageUrl,
//         from: from ?? this.from,
//         lastPage: lastPage ?? this.lastPage,
//         lastPageUrl: lastPageUrl ?? this.lastPageUrl,
//         links: links ?? this.links,
//         nextPageUrl: nextPageUrl ?? this.nextPageUrl,
//         path: path ?? this.path,
//         perPage: perPage ?? this.perPage,
//         prevPageUrl: prevPageUrl ?? this.prevPageUrl,
//         to: to ?? this.to,
//         total: total ?? this.total,
//       );
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         currentPage: json["current_page"],
//         data: json["data"] == null
//             ? []
//             : List<ProductData>.from(
//                 json["data"]!.map((x) => ProductData.fromJson(x))),
//         firstPageUrl: json["first_page_url"],
//         from: json["from"],
//         lastPage: json["last_page"],
//         lastPageUrl: json["last_page_url"],
//         links: json["links"] == null
//             ? []
//             : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
//         nextPageUrl: json["next_page_url"],
//         path: json["path"],
//         perPage: json["per_page"],
//         prevPageUrl: json["prev_page_url"],
//         to: json["to"],
//         total: json["total"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "current_page": currentPage,
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//         "first_page_url": firstPageUrl,
//         "from": from,
//         "last_page": lastPage,
//         "last_page_url": lastPageUrl,
//         "links": links == null
//             ? []
//             : List<dynamic>.from(links!.map((x) => x.toJson())),
//         "next_page_url": nextPageUrl,
//         "path": path,
//         "per_page": perPage,
//         "prev_page_url": prevPageUrl,
//         "to": to,
//         "total": total,
//       };
// }
//
// class ProductData {
//   int? id;
//   String? productName;
//   String? slug;
//   String? productSku;
//   int? categoryId;
//   int? subCategoryId;
//   dynamic childCategoryId;
//   int? brandId;
//   String? productDescription;
//   String? gander;
//   dynamic youtubeEmbadecode;
//   dynamic shippingType;
//   dynamic shippigCost;
//   dynamic shippingRtnPolicy;
//   dynamic offerStart;
//   dynamic offerEnd;
//   int? discountPercent;
//   dynamic multipleQty;
//   dynamic metaName;
//   dynamic metaTitle;
//   dynamic metaImage;
//   dynamic metaKeywords;
//   dynamic metaDescription;
//   int? totalStock;
//   int? available;
//   int? sold;
//   String? status;
//   String? type;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   double? rating;
//   List<ProductVariationData>? productvariations;
//   List<SizeData>? sizes;
//   List<Weight>? weights;
//
//   ProductData({
//     this.id,
//     this.productName,
//     this.slug,
//     this.productSku,
//     this.categoryId,
//     this.subCategoryId,
//     this.childCategoryId,
//     this.brandId,
//     this.productDescription,
//     this.gander,
//     this.youtubeEmbadecode,
//     this.shippingType,
//     this.shippigCost,
//     this.shippingRtnPolicy,
//     this.offerStart,
//     this.offerEnd,
//     this.discountPercent,
//     this.multipleQty,
//     this.metaName,
//     this.metaTitle,
//     this.metaImage,
//     this.metaKeywords,
//     this.metaDescription,
//     this.totalStock,
//     this.available,
//     this.sold,
//     this.status,
//     this.type,
//     this.createdAt,
//     this.updatedAt,
//     this.rating,
//     this.productvariations,
//     this.sizes,
//     this.weights,
//   });
//
//   ProductData copyWith({
//     int? id,
//     String? productName,
//     String? slug,
//     String? productSku,
//     int? categoryId,
//     int? subCategoryId,
//     dynamic childCategoryId,
//     int? brandId,
//     String? productDescription,
//     String? gander,
//     dynamic youtubeEmbadecode,
//     dynamic shippingType,
//     dynamic shippigCost,
//     dynamic shippingRtnPolicy,
//     dynamic offerStart,
//     dynamic offerEnd,
//     int? discountPercent,
//     dynamic multipleQty,
//     dynamic metaName,
//     dynamic metaTitle,
//     dynamic metaImage,
//     dynamic metaKeywords,
//     dynamic metaDescription,
//     int? totalStock,
//     int? available,
//     int? sold,
//     String? status,
//     String? type,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//     double? rating,
//     List<ProductVariationData>? productvariations,
//     List<SizeData>? sizes,
//     List<Weight>? weights,
//   }) =>
//       ProductData(
//         id: id ?? this.id,
//         productName: productName ?? this.productName,
//         slug: slug ?? this.slug,
//         productSku: productSku ?? this.productSku,
//         categoryId: categoryId ?? this.categoryId,
//         subCategoryId: subCategoryId ?? this.subCategoryId,
//         childCategoryId: childCategoryId ?? this.childCategoryId,
//         brandId: brandId ?? this.brandId,
//         productDescription: productDescription ?? this.productDescription,
//         gander: gander ?? this.gander,
//         youtubeEmbadecode: youtubeEmbadecode ?? this.youtubeEmbadecode,
//         shippingType: shippingType ?? this.shippingType,
//         shippigCost: shippigCost ?? this.shippigCost,
//         shippingRtnPolicy: shippingRtnPolicy ?? this.shippingRtnPolicy,
//         offerStart: offerStart ?? this.offerStart,
//         offerEnd: offerEnd ?? this.offerEnd,
//         discountPercent: discountPercent ?? this.discountPercent,
//         multipleQty: multipleQty ?? this.multipleQty,
//         metaName: metaName ?? this.metaName,
//         metaTitle: metaTitle ?? this.metaTitle,
//         metaImage: metaImage ?? this.metaImage,
//         metaKeywords: metaKeywords ?? this.metaKeywords,
//         metaDescription: metaDescription ?? this.metaDescription,
//         totalStock: totalStock ?? this.totalStock,
//         available: available ?? this.available,
//         sold: sold ?? this.sold,
//         status: status ?? this.status,
//         type: type ?? this.type,
//         createdAt: createdAt ?? this.createdAt,
//         updatedAt: updatedAt ?? this.updatedAt,
//         rating: rating ?? this.rating,
//         productvariations: productvariations ?? this.productvariations,
//         sizes: sizes ?? this.sizes,
//         weights: weights ?? this.weights,
//       );
//
//   factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
//         id: json["id"],
//         productName: json["product_name"],
//         slug: json["slug"],
//         productSku: json["product_sku"],
//         categoryId: json["category_id"],
//         subCategoryId: json["sub_category_id"],
//         childCategoryId: json["child_category_id"],
//         brandId: json["brand_id"],
//         productDescription: json["product_description"],
//         gander: json["gander"],
//         youtubeEmbadecode: json["youtube_embadecode"],
//         shippingType: json["shipping_type"],
//         shippigCost: json["shippig_cost"],
//         shippingRtnPolicy: json["shipping_rtn_policy"],
//         offerStart: json["offer_start"],
//         offerEnd: json["offer_end"],
//         discountPercent: json["discount_percent"],
//         multipleQty: json["multiple_qty"],
//         metaName: json["meta_name"],
//         metaTitle: json["meta_title"],
//         metaImage: json["meta_image"],
//         metaKeywords: json["meta_keywords"],
//         metaDescription: json["meta_description"],
//         totalStock: json["total_stock"],
//         available: json["available"],
//         sold: json["sold"],
//         status: json["status"],
//         type: json["type"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         rating: json["rating"]?.toDouble(),
//         productvariations: json["productvariations"] == null
//             ? []
//             : List<ProductVariationData>.from(json["productvariations"]!
//                 .map((x) => ProductVariationData.fromJson(x))),
//         sizes: json["sizes"] == null
//             ? []
//             : List<SizeData>.from(
//                 json["sizes"]!.map((x) => SizeData.fromJson(x))),
//         weights: json["weights"] == null
//             ? []
//             : List<Weight>.from(
//                 json["weights"]!.map((x) => Weight.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "product_name": productName,
//         "slug": slug,
//         "product_sku": productSku,
//         "category_id": categoryId,
//         "sub_category_id": subCategoryId,
//         "child_category_id": childCategoryId,
//         "brand_id": brandId,
//         "product_description": productDescription,
//         "gander": gander,
//         "youtube_embadecode": youtubeEmbadecode,
//         "shipping_type": shippingType,
//         "shippig_cost": shippigCost,
//         "shipping_rtn_policy": shippingRtnPolicy,
//         "offer_start": offerStart,
//         "offer_end": offerEnd,
//         "discount_percent": discountPercent,
//         "multiple_qty": multipleQty,
//         "meta_name": metaName,
//         "meta_title": metaTitle,
//         "meta_image": metaImage,
//         "meta_keywords": metaKeywords,
//         "meta_description": metaDescription,
//         "total_stock": totalStock,
//         "available": available,
//         "sold": sold,
//         "status": status,
//         "type": type,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "rating": rating,
//         "productvariations": productvariations == null
//             ? []
//             : List<dynamic>.from(productvariations!.map((x) => x.toJson())),
//         "sizes": sizes == null
//             ? []
//             : List<dynamic>.from(sizes!.map((x) => x.toJson())),
//         "weights": weights == null
//             ? []
//             : List<dynamic>.from(weights!.map((x) => x.toJson())),
//       };
// }
//
// class ProductVariationData {
//   int? id;
//   int? productId;
//   String? image;
//   int? colorId;
//   String? color;
//   String? colorCode;
//   dynamic codeId;
//   dynamic code;
//   String? status;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   List<ProductvariationSize>? sizes;
//
//   ProductVariationData({
//     this.id,
//     this.productId,
//     this.image,
//     this.colorId,
//     this.color,
//     this.colorCode,
//     this.codeId,
//     this.code,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.sizes,
//   });
//
//   ProductVariationData copyWith({
//     int? id,
//     int? productId,
//     String? image,
//     int? colorId,
//     String? color,
//     String? colorCode,
//     dynamic codeId,
//     dynamic code,
//     String? status,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//     List<ProductvariationSize>? sizes,
//   }) =>
//       ProductVariationData(
//         id: id ?? this.id,
//         productId: productId ?? this.productId,
//         image: image ?? this.image,
//         colorId: colorId ?? this.colorId,
//         color: color ?? this.color,
//         colorCode: colorCode ?? this.colorCode,
//         codeId: codeId ?? this.codeId,
//         code: code ?? this.code,
//         status: status ?? this.status,
//         createdAt: createdAt ?? this.createdAt,
//         updatedAt: updatedAt ?? this.updatedAt,
//         sizes: sizes ?? this.sizes,
//       );
//
//   factory ProductVariationData.fromJson(Map<String, dynamic> json) =>
//       ProductVariationData(
//         id: json["id"],
//         productId: json["product_id"],
//         image: json["image"],
//         colorId: json["color_id"],
//         color: json["color"],
//         colorCode: json["color_code"],
//         codeId: json["code_id"],
//         code: json["code"],
//         status: json["status"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         sizes: json["sizes"] == null
//             ? []
//             : List<ProductvariationSize>.from(
//                 json["sizes"]!.map((x) => ProductvariationSize.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "product_id": productId,
//         "image": image,
//         "color_id": colorId,
//         "color": color,
//         "color_code": colorCode,
//         "code_id": codeId,
//         "code": code,
//         "status": status,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "sizes": sizes == null
//             ? []
//             : List<dynamic>.from(sizes!.map((x) => x.toJson())),
//       };
// }
//
// class ProductvariationSize {
//   int? id;
//
//   ProductvariationSize({
//     this.id,
//   });
//
//   ProductvariationSize copyWith({
//     int? id,
//   }) =>
//       ProductvariationSize(
//         id: id ?? this.id,
//       );
//
//   factory ProductvariationSize.fromJson(Map<String, dynamic> json) =>
//       ProductvariationSize(
//         id: json["id"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//       };
// }
//
// class SizeData {
//   int? id;
//   int? productId;
//   int? varientId;
//   int? sizeId;
//   String? size;
//   int? regularPrice;
//   int? salePrice;
//   int? discount;
//   int? buyPrice;
//   int? totalStock;
//   int? stock;
//   int? sold;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   SizeData({
//     this.id,
//     this.productId,
//     this.varientId,
//     this.sizeId,
//     this.size,
//     this.regularPrice,
//     this.salePrice,
//     this.discount,
//     this.buyPrice,
//     this.totalStock,
//     this.stock,
//     this.sold,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   SizeData copyWith({
//     int? id,
//     int? productId,
//     int? varientId,
//     int? sizeId,
//     String? size,
//     int? regularPrice,
//     int? salePrice,
//     int? discount,
//     int? buyPrice,
//     int? totalStock,
//     int? stock,
//     int? sold,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//   }) =>
//       SizeData(
//         id: id ?? this.id,
//         productId: productId ?? this.productId,
//         varientId: varientId ?? this.varientId,
//         sizeId: sizeId ?? this.sizeId,
//         size: size ?? this.size,
//         regularPrice: regularPrice ?? this.regularPrice,
//         salePrice: salePrice ?? this.salePrice,
//         discount: discount ?? this.discount,
//         buyPrice: buyPrice ?? this.buyPrice,
//         totalStock: totalStock ?? this.totalStock,
//         stock: stock ?? this.stock,
//         sold: sold ?? this.sold,
//         createdAt: createdAt ?? this.createdAt,
//         updatedAt: updatedAt ?? this.updatedAt,
//       );
//
//   factory SizeData.fromJson(Map<String, dynamic> json) => SizeData(
//         id: json["id"],
//         productId: json["product_id"],
//         varientId: json["varient_id"],
//         sizeId: json["size_id"],
//         size: json["size"],
//         regularPrice: json["RegularPrice"],
//         salePrice: json["SalePrice"],
//         discount: json["Discount"],
//         buyPrice: json["buy_price"],
//         totalStock: json["total_stock"],
//         stock: json["stock"],
//         sold: json["sold"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "product_id": productId,
//         "varient_id": varientId,
//         "size_id": sizeId,
//         "size": size,
//         "RegularPrice": regularPrice,
//         "SalePrice": salePrice,
//         "Discount": discount,
//         "buy_price": buyPrice,
//         "total_stock": totalStock,
//         "stock": stock,
//         "sold": sold,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//       };
// }
//
// class Weight {
//   int? id;
//   int? productId;
//   int? varientId;
//   int? weightId;
//   String? weight;
//   String? regularPrice;
//   String? salePrice;
//   String? discount;
//   int? totalStock;
//   int? stock;
//   int? sold;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   Weight({
//     this.id,
//     this.productId,
//     this.varientId,
//     this.weightId,
//     this.weight,
//     this.regularPrice,
//     this.salePrice,
//     this.discount,
//     this.totalStock,
//     this.stock,
//     this.sold,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   Weight copyWith({
//     int? id,
//     int? productId,
//     int? varientId,
//     int? weightId,
//     String? weight,
//     String? regularPrice,
//     String? salePrice,
//     String? discount,
//     int? totalStock,
//     int? stock,
//     int? sold,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//   }) =>
//       Weight(
//         id: id ?? this.id,
//         productId: productId ?? this.productId,
//         varientId: varientId ?? this.varientId,
//         weightId: weightId ?? this.weightId,
//         weight: weight ?? this.weight,
//         regularPrice: regularPrice ?? this.regularPrice,
//         salePrice: salePrice ?? this.salePrice,
//         discount: discount ?? this.discount,
//         totalStock: totalStock ?? this.totalStock,
//         stock: stock ?? this.stock,
//         sold: sold ?? this.sold,
//         createdAt: createdAt ?? this.createdAt,
//         updatedAt: updatedAt ?? this.updatedAt,
//       );
//
//   factory Weight.fromJson(Map<String, dynamic> json) => Weight(
//         id: json["id"],
//         productId: json["product_id"],
//         varientId: json["varient_id"],
//         weightId: json["weight_id"],
//         weight: json["weight"],
//         regularPrice: json["RegularPrice"],
//         salePrice: json["SalePrice"],
//         discount: json["Discount"],
//         totalStock: json["total_stock"],
//         stock: json["stock"],
//         sold: json["sold"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "product_id": productId,
//         "varient_id": varientId,
//         "weight_id": weightId,
//         "weight": weight,
//         "RegularPrice": regularPrice,
//         "SalePrice": salePrice,
//         "Discount": discount,
//         "total_stock": totalStock,
//         "stock": stock,
//         "sold": sold,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//       };
// }
//
// class Link {
//   String? url;
//   String? label;
//   bool? active;
//
//   Link({
//     this.url,
//     this.label,
//     this.active,
//   });
//
//   Link copyWith({
//     String? url,
//     String? label,
//     bool? active,
//   }) =>
//       Link(
//         url: url ?? this.url,
//         label: label ?? this.label,
//         active: active ?? this.active,
//       );
//
//   factory Link.fromJson(Map<String, dynamic> json) => Link(
//         url: json["url"],
//         label: json["label"],
//         active: json["active"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "url": url,
//         "label": label,
//         "active": active,
//       };
// }
