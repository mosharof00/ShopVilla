// To parse this JSON data, do
//
//     final productDetailsModel = productDetailsModelFromJson(jsonString);

import 'dart:convert';

ProductDetailsModel productDetailsModelFromJson(String str) => ProductDetailsModel.fromJson(json.decode(str));

String productDetailsModelToJson(ProductDetailsModel data) => json.encode(data.toJson());

class ProductDetailsModel {
  String? title;
  ProductDetailsData? data;

  ProductDetailsModel({
    this.title,
    this.data,
  });

  ProductDetailsModel copyWith({
    String? title,
    ProductDetailsData? data,
  }) =>
      ProductDetailsModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) => ProductDetailsModel(
    title: json["title"],
    data: json["data"] == null ? null : ProductDetailsData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "data": data?.toJson(),
  };
}

class ProductDetailsData {
  int? id;
  String? productName;
  String? slug;
  String? productSku;
  int? categoryId;
  int? subCategoryId;
  dynamic childCategoryId;
  int? brandId;
  String? productDescription;
  String? gander;
  String? youtubeEmbadecode;
  String? shippingType;
  int? shippigCost;
  String? shippingRtnPolicy;
  DateTime? offerStart;
  DateTime? offerEnd;
  int? discountPercent;
  String? multipleQty;
  String? metaName;
  String? metaTitle;
  String? metaImage;
  String? metaKeywords;
  String? metaDescription;
  int? totalStock;
  int? available;
  int? sold;
  String? status;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Productvariation>? productvariations;
  List<DataSize>? sizes;
  List<dynamic>? weights;
  bool? isWishlisted;

  ProductDetailsData({
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
    this.sold,
    this.status,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.productvariations,
    this.sizes,
    this.weights,
    this.isWishlisted,
  });

  ProductDetailsData copyWith({
    int? id,
    String? productName,
    String? slug,
    String? productSku,
    int? categoryId,
    int? subCategoryId,
    dynamic childCategoryId,
    int? brandId,
    String? productDescription,
    String? gander,
    String? youtubeEmbadecode,
    String? shippingType,
    int? shippigCost,
    String? shippingRtnPolicy,
    DateTime? offerStart,
    DateTime? offerEnd,
    int? discountPercent,
    String? multipleQty,
    String? metaName,
    String? metaTitle,
    String? metaImage,
    String? metaKeywords,
    String? metaDescription,
    int? totalStock,
    int? available,
    int? sold,
    String? status,
    String? type,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Productvariation>? productvariations,
    List<DataSize>? sizes,
    List<dynamic>? weights,
    bool? isWishlisted,
  }) =>
      ProductDetailsData(
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
        sold: sold ?? this.sold,
        status: status ?? this.status,
        type: type ?? this.type,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        productvariations: productvariations ?? this.productvariations,
        sizes: sizes ?? this.sizes,
        weights: weights ?? this.weights,
        isWishlisted: isWishlisted ?? this.isWishlisted,
      );

  factory ProductDetailsData.fromJson(Map<String, dynamic> json) => ProductDetailsData(
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
    offerStart: json["offer_start"] == null ? null : DateTime.parse(json["offer_start"]),
    offerEnd: json["offer_end"] == null ? null : DateTime.parse(json["offer_end"]),
    discountPercent: json["discount_percent"],
    multipleQty: json["multiple_qty"],
    metaName: json["meta_name"],
    metaTitle: json["meta_title"],
    metaImage: json["meta_image"],
    metaKeywords: json["meta_keywords"],
    metaDescription: json["meta_description"],
    totalStock: json["total_stock"],
    available: json["available"],
    sold: json["sold"],
    status: json["status"],
    type: json["type"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    productvariations: json["productvariations"] == null ? [] : List<Productvariation>.from(json["productvariations"]!.map((x) => Productvariation.fromJson(x))),
    sizes: json["sizes"] == null ? [] : List<DataSize>.from(json["sizes"]!.map((x) => DataSize.fromJson(x))),
    weights: json["weights"] == null ? [] : List<dynamic>.from(json["weights"]!.map((x) => x)),
    isWishlisted: json["is_wishlisted"],
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
    "offer_start": offerStart?.toIso8601String(),
    "offer_end": offerEnd?.toIso8601String(),
    "discount_percent": discountPercent,
    "multiple_qty": multipleQty,
    "meta_name": metaName,
    "meta_title": metaTitle,
    "meta_image": metaImage,
    "meta_keywords": metaKeywords,
    "meta_description": metaDescription,
    "total_stock": totalStock,
    "available": available,
    "sold": sold,
    "status": status,
    "type": type,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "productvariations": productvariations == null ? [] : List<dynamic>.from(productvariations!.map((x) => x.toJson())),
    "sizes": sizes == null ? [] : List<dynamic>.from(sizes!.map((x) => x.toJson())),
    "weights": weights == null ? [] : List<dynamic>.from(weights!.map((x) => x)),
    "is_wishlisted": isWishlisted,
  };
}

class Productvariation {
  int? id;
  int? productId;
  String? image;
  int? colorId;
  String? color;
  String? colorCode;
  int? codeId;
  String? code;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<MullipleImage>? mullipleImages;
  List<ProductvariationSize>? sizes;

  Productvariation({
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
    this.mullipleImages,
    this.sizes,
  });

  Productvariation copyWith({
    int? id,
    int? productId,
    String? image,
    int? colorId,
    String? color,
    String? colorCode,
    int? codeId,
    String? code,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<MullipleImage>? mullipleImages,
    List<ProductvariationSize>? sizes,
  }) =>
      Productvariation(
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
        mullipleImages: mullipleImages ?? this.mullipleImages,
        sizes: sizes ?? this.sizes,
      );

  factory Productvariation.fromJson(Map<String, dynamic> json) => Productvariation(
    id: json["id"],
    productId: json["product_id"],
    image: json["image"],
    colorId: json["color_id"],
    color: json["color"],
    colorCode: json["color_code"],
    codeId: json["code_id"],
    code: json["code"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    mullipleImages: json["mulliple_images"] == null ? [] : List<MullipleImage>.from(json["mulliple_images"]!.map((x) => MullipleImage.fromJson(x))),
    sizes: json["sizes"] == null ? [] : List<ProductvariationSize>.from(json["sizes"]!.map((x) => ProductvariationSize.fromJson(x))),
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
    "mulliple_images": mullipleImages == null ? [] : List<dynamic>.from(mullipleImages!.map((x) => x.toJson())),
    "sizes": sizes == null ? [] : List<dynamic>.from(sizes!.map((x) => x.toJson())),
  };
}
class MullipleImage {
  int? id;
  String? productVariationId;
  String? imagePath;

  MullipleImage({
    this.id,
    this.productVariationId,
    this.imagePath,
  });

  MullipleImage copyWith({
    int? id,
    String? productVariationId,
    String? imagePath,
  }) =>
      MullipleImage(
        id: id ?? this.id,
        productVariationId: productVariationId ?? this.productVariationId,
        imagePath: imagePath ?? this.imagePath,
      );

  factory MullipleImage.fromJson(Map<String, dynamic> json) => MullipleImage(
    id: json["id"],
    productVariationId: json["product_variation_id"],
    imagePath: json["image_path"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_variation_id": productVariationId,
    "image_path": imagePath,
  };
}

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

  factory ProductvariationSize.fromJson(Map<String, dynamic> json) => ProductvariationSize(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}

class DataSize {
  int? id;
  int? productId;
  int? varientId;
  int? sizeId;
  String? size;
  int? regularPrice;
  int? salePrice;
  int? discount;
  int? totalStock;
  int? stock;
  int? sold;
  DateTime? createdAt;
  DateTime? updatedAt;

  DataSize({
    this.id,
    this.productId,
    this.varientId,
    this.sizeId,
    this.size,
    this.regularPrice,
    this.salePrice,
    this.discount,
    this.totalStock,
    this.stock,
    this.sold,
    this.createdAt,
    this.updatedAt,
  });

  DataSize copyWith({
    int? id,
    int? productId,
    int? varientId,
    int? sizeId,
    String? size,
    int? regularPrice,
    int? salePrice,
    int? discount,
    int? totalStock,
    int? stock,
    int? sold,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      DataSize(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        varientId: varientId ?? this.varientId,
        sizeId: sizeId ?? this.sizeId,
        size: size ?? this.size,
        regularPrice: regularPrice ?? this.regularPrice,
        salePrice: salePrice ?? this.salePrice,
        discount: discount ?? this.discount,
        totalStock: totalStock ?? this.totalStock,
        stock: stock ?? this.stock,
        sold: sold ?? this.sold,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory DataSize.fromJson(Map<String, dynamic> json) => DataSize(
    id: json["id"],
    productId: json["product_id"],
    varientId: json["varient_id"],
    sizeId: json["size_id"],
    size: json["size"],
    regularPrice: json["RegularPrice"],
    salePrice: json["SalePrice"],
    discount: json["Discount"],
    totalStock: json["total_stock"],
    stock: json["stock"],
    sold: json["sold"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
    "total_stock": totalStock,
    "stock": stock,
    "sold": sold,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
