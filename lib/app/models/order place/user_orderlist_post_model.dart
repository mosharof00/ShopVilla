// To parse this JSON data, do
//
//     final userOrderListGetModel = userOrderListGetModelFromJson(jsonString);

import 'dart:convert';

UserOrderListGetModel userOrderListGetModelFromJson(String str) => UserOrderListGetModel.fromJson(json.decode(str));

String userOrderListGetModelToJson(UserOrderListGetModel data) => json.encode(data.toJson());

class UserOrderListGetModel {
  String? title;
  Data? data;

  UserOrderListGetModel({
    this.title,
    this.data,
  });

  UserOrderListGetModel copyWith({
    String? title,
    Data? data,
  }) =>
      UserOrderListGetModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory UserOrderListGetModel.fromJson(Map<String, dynamic> json) => UserOrderListGetModel(
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
  List<MyOrder>? data;
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

  Data({
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

  Data copyWith({
    int? currentPage,
    List<MyOrder>? data,
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
      Data(
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<MyOrder>.from(json["data"]!.map((x) => MyOrder.fromJson(x))),
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

class MyOrder {
  int? id;
  String? invoiceId;
  int? webId;
  int? userId;
  dynamic note;
  dynamic courierId;
  dynamic cityId;
  dynamic zoneId;
  dynamic areaId;
  dynamic hubName;
  int? subTotal;
  int? shippingCharge;
  int? discount;
  int? total;
  int? vat;
  int? tax;
  dynamic coupon;
  int? paidAmount;
  String? dueAmount;
  dynamic advancePaymentAmount;
  String? advancePaymentStatus;
  DateTime? orderDate;
  dynamic confirmDate;
  dynamic shippingDate;
  dynamic deliveryDate;
  String? status;
  String? paymentStatus;
  int? adminId;
  dynamic sellerId;
  dynamic paymentId;
  String? paymentMethod;
  String? name;
  String? email;
  String? phone;
  String? address;
  dynamic country;
  String? city;
  String? district;
  dynamic state;
  dynamic zipCode;
  dynamic orderNote;
  dynamic amount;
  dynamic transactionId;
  dynamic currency;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Orderproduct>? orderproducts;
  dynamic couriers;
  User? user;

  MyOrder({
    this.id,
    this.invoiceId,
    this.webId,
    this.userId,
    this.note,
    this.courierId,
    this.cityId,
    this.zoneId,
    this.areaId,
    this.hubName,
    this.subTotal,
    this.shippingCharge,
    this.discount,
    this.total,
    this.vat,
    this.tax,
    this.coupon,
    this.paidAmount,
    this.dueAmount,
    this.advancePaymentAmount,
    this.advancePaymentStatus,
    this.orderDate,
    this.confirmDate,
    this.shippingDate,
    this.deliveryDate,
    this.status,
    this.paymentStatus,
    this.adminId,
    this.sellerId,
    this.paymentId,
    this.paymentMethod,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.country,
    this.city,
    this.district,
    this.state,
    this.zipCode,
    this.orderNote,
    this.amount,
    this.transactionId,
    this.currency,
    this.createdAt,
    this.updatedAt,
    this.orderproducts,
    this.couriers,
    this.user,
  });

  MyOrder copyWith({
    int? id,
    String? invoiceId,
    int? webId,
    int? userId,
    dynamic note,
    dynamic courierId,
    dynamic cityId,
    dynamic zoneId,
    dynamic areaId,
    dynamic hubName,
    int? subTotal,
    int? shippingCharge,
    int? discount,
    int? total,
    int? vat,
    int? tax,
    dynamic coupon,
    int? paidAmount,
    String? dueAmount,
    dynamic advancePaymentAmount,
    String? advancePaymentStatus,
    DateTime? orderDate,
    dynamic confirmDate,
    dynamic shippingDate,
    dynamic deliveryDate,
    String? status,
    String? paymentStatus,
    int? adminId,
    dynamic sellerId,
    dynamic paymentId,
    String? paymentMethod,
    String? name,
    String? email,
    String? phone,
    String? address,
    dynamic country,
    String? city,
    String? district,
    dynamic state,
    dynamic zipCode,
    dynamic orderNote,
    dynamic amount,
    dynamic transactionId,
    dynamic currency,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Orderproduct>? orderproducts,
    dynamic couriers,
    User? user,
  }) =>
      MyOrder(
        id: id ?? this.id,
        invoiceId: invoiceId ?? this.invoiceId,
        webId: webId ?? this.webId,
        userId: userId ?? this.userId,
        note: note ?? this.note,
        courierId: courierId ?? this.courierId,
        cityId: cityId ?? this.cityId,
        zoneId: zoneId ?? this.zoneId,
        areaId: areaId ?? this.areaId,
        hubName: hubName ?? this.hubName,
        subTotal: subTotal ?? this.subTotal,
        shippingCharge: shippingCharge ?? this.shippingCharge,
        discount: discount ?? this.discount,
        total: total ?? this.total,
        vat: vat ?? this.vat,
        tax: tax ?? this.tax,
        coupon: coupon ?? this.coupon,
        paidAmount: paidAmount ?? this.paidAmount,
        dueAmount: dueAmount ?? this.dueAmount,
        advancePaymentAmount: advancePaymentAmount ?? this.advancePaymentAmount,
        advancePaymentStatus: advancePaymentStatus ?? this.advancePaymentStatus,
        orderDate: orderDate ?? this.orderDate,
        confirmDate: confirmDate ?? this.confirmDate,
        shippingDate: shippingDate ?? this.shippingDate,
        deliveryDate: deliveryDate ?? this.deliveryDate,
        status: status ?? this.status,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        adminId: adminId ?? this.adminId,
        sellerId: sellerId ?? this.sellerId,
        paymentId: paymentId ?? this.paymentId,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        country: country ?? this.country,
        city: city ?? this.city,
        district: district ?? this.district,
        state: state ?? this.state,
        zipCode: zipCode ?? this.zipCode,
        orderNote: orderNote ?? this.orderNote,
        amount: amount ?? this.amount,
        transactionId: transactionId ?? this.transactionId,
        currency: currency ?? this.currency,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        orderproducts: orderproducts ?? this.orderproducts,
        couriers: couriers ?? this.couriers,
        user: user ?? this.user,
      );

  factory MyOrder.fromJson(Map<String, dynamic> json) => MyOrder(
    id: json["id"],
    invoiceId: json["invoiceID"],
    webId: json["web_id"],
    userId: json["user_id"],
    note: json["note"],
    courierId: json["courier_id"],
    cityId: json["city_id"],
    zoneId: json["zone_id"],
    areaId: json["area_id"],
    hubName: json["hub_name"],
    subTotal: json["subTotal"],
    shippingCharge: json["shippingCharge"],
    discount: json["discount"],
    total: json["total"],
    vat: json["vat"],
    tax: json["tax"],
    coupon: json["coupon"],
    paidAmount: json["paidAmount"],
    dueAmount: json["due_amount"],
    advancePaymentAmount: json["advance_payment_amount"],
    advancePaymentStatus: json["advance_payment_status"],
    orderDate: json["orderDate"] == null ? null : DateTime.parse(json["orderDate"]),
    confirmDate: json["confirmDate"],
    shippingDate: json["shippingDate"],
    deliveryDate: json["deliveryDate"],
    status: json["status"],
    paymentStatus: json["payment_status"],
    adminId: json["admin_id"],
    sellerId: json["seller_id"],
    paymentId: json["payment_id"],
    paymentMethod: json["payment_method"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    address: json["address"],
    country: json["country"],
    city: json["city"],
    district: json["district"],
    state: json["state"],
    zipCode: json["zip_code"],
    orderNote: json["order_note"],
    amount: json["amount"],
    transactionId: json["transaction_id"],
    currency: json["currency"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    orderproducts: json["orderproducts"] == null ? [] : List<Orderproduct>.from(json["orderproducts"]!.map((x) => Orderproduct.fromJson(x))),
    couriers: json["couriers"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "invoiceID": invoiceId,
    "web_id": webId,
    "user_id": userId,
    "note": note,
    "courier_id": courierId,
    "city_id": cityId,
    "zone_id": zoneId,
    "area_id": areaId,
    "hub_name": hubName,
    "subTotal": subTotal,
    "shippingCharge": shippingCharge,
    "discount": discount,
    "total": total,
    "vat": vat,
    "tax": tax,
    "coupon": coupon,
    "paidAmount": paidAmount,
    "due_amount": dueAmount,
    "advance_payment_amount": advancePaymentAmount,
    "advance_payment_status": advancePaymentStatus,
    "orderDate": orderDate?.toIso8601String(),
    "confirmDate": confirmDate,
    "shippingDate": shippingDate,
    "deliveryDate": deliveryDate,
    "status": status,
    "payment_status": paymentStatus,
    "admin_id": adminId,
    "seller_id": sellerId,
    "payment_id": paymentId,
    "payment_method": paymentMethod,
    "name": name,
    "email": email,
    "phone": phone,
    "address": address,
    "country": country,
    "city": city,
    "district": district,
    "state": state,
    "zip_code": zipCode,
    "order_note": orderNote,
    "amount": amount,
    "transaction_id": transactionId,
    "currency": currency,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "orderproducts": orderproducts == null ? [] : List<dynamic>.from(orderproducts!.map((x) => x.toJson())),
    "couriers": couriers,
    "user": user?.toJson(),
  };
}

class Orderproduct {
  int? id;
  int? orderId;
  int? productId;
  dynamic productSku;
  String? productName;
  String? color;
  String? size;
  int? sizeId;
  dynamic code;
  dynamic codeId;
  String? weight;
  dynamic weightId;
  String? productvariationId;
  int? price;
  int? qty;
  DateTime? createdAt;
  DateTime? updatedAt;
  Productvariation? productvariation;

  Orderproduct({
    this.id,
    this.orderId,
    this.productId,
    this.productSku,
    this.productName,
    this.color,
    this.size,
    this.sizeId,
    this.code,
    this.codeId,
    this.weight,
    this.weightId,
    this.productvariationId,
    this.price,
    this.qty,
    this.createdAt,
    this.updatedAt,
    this.productvariation,
  });

  Orderproduct copyWith({
    int? id,
    int? orderId,
    int? productId,
    dynamic productSku,
    String? productName,
    String? color,
    String? size,
    int? sizeId,
    dynamic code,
    dynamic codeId,
    String? weight,
    dynamic weightId,
    String? productvariationId,
    int? price,
    int? qty,
    DateTime? createdAt,
    DateTime? updatedAt,
    Productvariation? productvariation,
  }) =>
      Orderproduct(
        id: id ?? this.id,
        orderId: orderId ?? this.orderId,
        productId: productId ?? this.productId,
        productSku: productSku ?? this.productSku,
        productName: productName ?? this.productName,
        color: color ?? this.color,
        size: size ?? this.size,
        sizeId: sizeId ?? this.sizeId,
        code: code ?? this.code,
        codeId: codeId ?? this.codeId,
        weight: weight ?? this.weight,
        weightId: weightId ?? this.weightId,
        productvariationId: productvariationId ?? this.productvariationId,
        price: price ?? this.price,
        qty: qty ?? this.qty,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        productvariation: productvariation ?? this.productvariation,
      );

  factory Orderproduct.fromJson(Map<String, dynamic> json) => Orderproduct(
    id: json["id"],
    orderId: json["order_id"],
    productId: json["product_id"],
    productSku: json["productSku"],
    productName: json["productName"],
    color: json["color"],
    size: json["size"],
    sizeId: json["size_id"],
    code: json["code"],
    codeId: json["code_id"],
    weight: json["weight"],
    weightId: json["weight_id"],
    productvariationId: json["productvariation_id"],
    price: json["price"],
    qty: json["qty"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    productvariation: json["productvariation"] == null ? null : Productvariation.fromJson(json["productvariation"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "product_id": productId,
    "productSku": productSku,
    "productName": productName,
    "color": color,
    "size": size,
    "size_id": sizeId,
    "code": code,
    "code_id": codeId,
    "weight": weight,
    "weight_id": weightId,
    "productvariation_id": productvariationId,
    "price": price,
    "qty": qty,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "productvariation": productvariation?.toJson(),
  };
}

class Productvariation {
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
  });

  Productvariation copyWith({
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
  };
}

class User {
  int? id;
  String? name;
  dynamic gender;
  dynamic birthday;
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
    dynamic gender,
    dynamic birthday,
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