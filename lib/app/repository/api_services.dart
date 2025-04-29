import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_villa/app/models/Delivery%20Charge/checklist_get_model.dart';
import 'package:shop_villa/app/models/Reviews/review_get_model.dart';
import 'package:shop_villa/app/models/address/shipping_address_delete.dart';
import 'package:shop_villa/app/models/address/shipping_address_get_model.dart';
import 'package:shop_villa/app/models/address/shipping_address_post_model.dart';
import 'package:shop_villa/app/models/address/shipping_address_update.dart';
import 'package:shop_villa/app/models/admin/admin_info.dart';
import 'package:shop_villa/app/models/auth/log_out_model.dart';
import 'package:shop_villa/app/models/auth/registration_model.dart';
import 'package:shop_villa/app/models/cart/cart_update_model.dart';
import 'package:shop_villa/app/models/delivery%20list/delivery_list_model.dart';
import 'package:shop_villa/app/models/delivery_options/get_delivery_options.dart';
import 'package:shop_villa/app/models/notification/notification_model.dart';
import 'package:shop_villa/app/models/courier/courier_get_model.dart';
import 'package:shop_villa/app/models/order%20place/order_list_post_model.dart';
import 'package:shop_villa/app/models/order%20place/user_orderlist_cancel_model.dart';
import 'package:shop_villa/app/models/order%20place/user_orderlist_post_model.dart';
import 'package:shop_villa/app/models/q&a/q&aGetModel.dart';
import 'package:shop_villa/app/models/q&a/q&aUserQusPostModel.dart';
import 'package:shop_villa/app/models/sub_category/sub_category_model.dart';
import 'package:shop_villa/app/models/wishlist_model/remove_all_wish_list_model.dart';
import 'package:shop_villa/app/models/wishlist_model/remove_to_wishlist_model.dart';
import 'package:shop_villa/app/repository/api_endpoint.dart';
import 'package:shop_villa/helper/helper_utils.dart';
import '../../helper/log_printer.dart';
import '../models/Reviews/review_add_model.dart';
import '../models/alert/alert_model.dart';
import '../models/brands/brand_model.dart';
import '../models/cart/cart_get_model.dart';
import '../models/cart/cart_item_remove_get_model.dart';
import '../models/cart/cart_post_model.dart';
import '../models/category/category_model.dart';
import '../models/auth/login_model.dart';
import '../models/collections/collection_model.dart';
import '../models/coupon/coupon_get_model.dart';
import '../models/coupon/coupon_post_model.dart';
import '../models/currency/currency.dart';
import '../models/forgot_password/forgot_password_model.dart';
import '../models/home/user_count_model.dart';
import '../models/order place/re_order_model.dart';
import '../models/payment_method/payment_method.dart';
import '../models/product/porduct_model_api.dart';
import '../models/product/product_variation_list_model.dart';
import '../models/product/sort_filter__list_model.dart';
import '../models/product_attribute/product_attribute_model.dart';
import '../models/product_details/product_details_model.dart';
import '../models/profile/profile_get_model.dart';
import '../models/profile/profile_post_model.dart';
import '../models/wishlist_model/add_to_wishlist_model.dart';
import '../models/slider/slider_model.dart';
import 'authInterceptor.dart';
import '../models/wishlist_model/wish_list_model.dart';

// const String baseUrl =
//     'https://raw.githubusercontent.com/RzTutul/ApiResponse/main/data';
// const String kBaseUrl = 'https://api.escuelajs.co/api/v1/products';

abstract class IApiService {
  // Future<List<ProductModel>> getProducts();
  // Future<ProductModel> getProductsDetails(String id);

  ///               Auth              ///
  /// Registration:
  Future<RegisterModel> registerUser(
      String name, String email, String password);

  /// Login:
  Future<LoginModel> loginUser(String email, String password);

  /// LogOut:
  Future<LogOutModel> logOutUser();

  /// ForgotPassword
  /// Send OTP
  Future<ForgotPasswordModel> sendOTP({required String email});

  /// Reset Password
  Future<ForgotPasswordModel> resetPassword(
      {required String token,
      required String newPassword,
      required String confirmNewPassword});

  /// Brands
  Future<BrandModel> getBrands(); //Get

  /// Category
  Future<CategoryModel> getCategory();

  /// SubCategory   ///
  Future<SubCategoryModel> getSubCategory({required int categoryId});

  /// Admin Info
  Future<AdminInfo> getAdminInfo(); //Get

  /// Product Attribute
  Future<ProductAttributeModel> getProductAttribute();

  /// Product
  Future<ProductModelApi> getProduct({
    String? sort,
    String? filterType,
    int? filterSizeID,
    int? filterColorID,
    int? categoryId,
    int? subCategoryId,
    int? collectionId,
    int? brandId,
    int? page,
  });

  /// Search
  Future<ProductModelApi> getSearch({
    required String text,
    String? sort,
    int? filterColorID,
    int? filterSizeID,
    int? page,
  });

  /// Product Details
  Future<ProductDetailsModel> getProductDetails(int id);

  ///  SortFilter List
  Future<SortFilterListModel> sortFilterList();

  ///  Product Variation List
  Future<ProductVariationListModel> productVariationList();

  /// Cart
  Future<CartGetModel> getCart(); //Get
  Future<CartPostModel> postCart(
      int productID, int varientID, int qty, int sizeID); //Post Add-to-Cart
  Future<CartItemRemoveModel> removeCart(int id); //Get Remove Cart
  Future<CartUpdateModel> updateCart(
      int productID, int qty, int varientID, int sizeID); //Post Update Cart

  /// Wishlist
  Future<WishListModel> getWishlist();
  Future<AddToWishlistModel> addToWishlist(
      int productId, int productVariationId, int productSizeId);
  Future<RemoveToWishlistModel> removeToWishlist(int productId);
  Future<RemoveAllWishListModel> removeAllWishList();

  /// Delivery Charge
  Future<DeliveryChargeModel> deliveryCharge(); // Get

  /// Delivery List
  Future<DeliveryListModel> getDeliveryList(); // Get

  /// Delivery Options
  Future<DeliveryOptionsModel> getDeliveryOptions();

  /// Payment Type
  Future<PaymentModel> getPaymentType(); //Get

  /// Order Place
  //Post
  Future<OrderListPostModel> orderList(
      String shippingAddressId, String paymentType, String isAdvancePayment, String deliveryCharge);
  Future<UserOrderListGetModel> userOrderList({int? page}); //Get
  Future<UserOrderListGetModel> userActiveOrderList({int? page});
  Future<UserOrderListCancelModel> userOrderCancel(String invoiceID);
  Future<ReOrderModel> reOrder(String invoiceID, String paymentMethod);

  /// Review
  Future<ReviewGetModel> getReview(String productID); //Post
  Future<ReviewAddModel> addReview(
      int productID, String text, double rating, String file); // Post

  /// Currency
  Future<CurrencyModel> getCurrency(); //Get

  /// Q & A
  Future<QaGetModel> qaList();
  Future<QaUserPostModel> qaUserQus(
      String userID, String productID, String qus);

  /// Shipping Address
  Future<ShippingAddressGetModel> getShippingAddress(); //Get
  Future<ShippingAddressPostModel> addShippingAddress(
    String name,
    String email,
    String phone,
    String area,
    String city,
    String district,
    String address,
    String deliveryCharge,
    String label,
  ); //Post
  ///  Update Shipping Address
  Future<ShippingAddressUpdateModel> updateShippingAddress(
      String name,
      String email,
      String phone,
      String city,
      String district,
      String area,
      String address,
      String label,
      String deliveryCharge,
      int addressID); //Post
  Future<ShippingAddressDeleteModel> deleteShippingAddress(
      int addressID); //Post
  /// Courier
  Future<CourierGetModel> courierList(); //Get

  /// Slider
  Future<SliderModel> getSlider(); //Get

  /// Promos Cuopon
  Future<PromosGetModel> getPromos();
  Future<PromosPostModel> applyPromos(String code);

  ///  Notification
  Future<NotificationModel> getNotification();

  /// Profile
  Future<ProfileGetModel> profileDetails(); // Get
  Future<ProfilePostModel> profileUpdates(
    String name,
    String email,
    String birthday,
    String gender,
    String phone,
    String country,
    String file,
  ); //Post

  ///  Collection
  Future<CollectionModel> getCollections();

  ///  Alert
  Future<AlertModel> getAlert();

  ///  Dashboard User count
  Future<DashboardUserCountModel> getDashboardUserCount();
}

class ApiServices implements IApiService {
  // final token = HiveService.getToken();
  final Dio _dio;
  ApiServices()
      : _dio = Dio(BaseOptions(
          validateStatus: (statusCode) {
            if (statusCode == null) {
              return false;
            }
            if (statusCode == 422 || statusCode == 400) {
              // your http status code
              return true;
            } else {
              return statusCode >= 200 && statusCode < 300;
            }
          },
        )) {
    _dio.interceptors.add(AuthInterceptor());
  }

  ///           Auth            ///
  ///  Registration:
  @override
  Future<RegisterModel> registerUser(
      String name, String email, String password) async {
    final Map<String, dynamic> data = {
      'name': name,
      'email': email,
      'password': password,
      'app_token': HelperUtils.firebaseToken.toString(),
    };
    return _handleRequest<RegisterModel>(
        () => _dio.post(ApiEndpoint.register, queryParameters: data),
        (dynamic data) => RegisterModel.fromJson(data),
        'Registration');
  }

  ///  Login:
  @override
  Future<LoginModel> loginUser(String email, String password) async {
    final Map<String, dynamic> data = {
      'email': email,
      'password': password,
      'app_token': HelperUtils.firebaseToken.toString(),
    };
    return _handleRequest<LoginModel>(
        () => _dio.post(ApiEndpoint.login, queryParameters: data),
        (dynamic data) => LoginModel.fromJson(data),
        'Login');
  }

  ///  LogOut:
  @override
  Future<LogOutModel> logOutUser() async {
    return _handleRequest<LogOutModel>(() => _dio.post(ApiEndpoint.logout),
        (dynamic data) => LogOutModel.fromJson(data), 'LogOut');
  }

  ///           Forgot Password
  ///  send OTP
  @override
  Future<ForgotPasswordModel> sendOTP({required String email}) async {
    final Map<dynamic, dynamic> data = {
      'email': email,
    };
    return _handleRequest<ForgotPasswordModel>(
        () => _dio.post(ApiEndpoint.sendOTP, data: data),
        (dynamic data) => ForgotPasswordModel.fromJson(data),
        'Send OTP');
  }

  ///  Reset Password
  @override
  Future<ForgotPasswordModel> resetPassword(
      {required String token,
      required String newPassword,
      required String confirmNewPassword}) async {
    final Map<String, dynamic> data = {
      'token': token,
      'password': newPassword,
      'password_confirmation': confirmNewPassword,
    };
    return _handleRequest<ForgotPasswordModel>(
        () => _dio.post(ApiEndpoint.resetPassword, queryParameters: data),
        (dynamic data) => ForgotPasswordModel.fromJson(data),
        'Reset Password');
  }

  /// Brands
  @override
  Future<BrandModel> getBrands() async {
    return _handleRequest<BrandModel>(() => _dio.get(ApiEndpoint.brandList),
        (dynamic data) => BrandModel.fromJson(data), 'Brand List');
  }

  ///  Category
  @override
  Future<CategoryModel> getCategory() async => _handleRequest<CategoryModel>(
      () => _dio.get(ApiEndpoint.categoryList),
      (dynamic data) => CategoryModel.fromJson(data),
      'Category');

  ///  SubCategory
  @override
  Future<SubCategoryModel> getSubCategory({required int categoryId}) async {
    return _handleRequest<SubCategoryModel>(
        () => _dio.get(
              '${ApiEndpoint.subcategoryList}/$categoryId',
              // queryParameters: data
            ),
        (dynamic data) => SubCategoryModel.fromJson(data),
        'SubCategory');
  }

  ///  ProductAttribute
  @override
  Future<ProductAttributeModel> getProductAttribute() async {
    return _handleRequest<ProductAttributeModel>(
        () => _dio.get(ApiEndpoint.productAttribute),
        (dynamic data) => ProductAttributeModel.fromJson(data),
        "Product Attribute");
  }

  /// Admin Info
  @override
  Future<AdminInfo> getAdminInfo() async {
    return _handleRequest<AdminInfo>(() => _dio.get(ApiEndpoint.adminInfo),
        (dynamic data) => AdminInfo.fromJson(data), 'Admin Info');
  }

  ///  Product
  @override
  Future<ProductModelApi> getProduct({
    String? sort,
    String? filterType,
    int? filterSizeID,
    int? filterColorID,
    int? categoryId,
    int? subCategoryId,
    int? collectionId,
    int? brandId,
    int? page,
  }) async {
    final Map<String, dynamic> data = {
      'sort': sort,
      'filter_type': filterType,
      'filter_size': filterSizeID,
      'filter_color': filterColorID,
      'category_id': categoryId,
      'sub_category_id': subCategoryId,
      'collection_id': collectionId,
      'brand_id': brandId,
      'page': page,
    };
    data.removeWhere((key, value) => value == null);
    return _handleRequest<ProductModelApi>(
        () => _dio.post(ApiEndpoint.productList, queryParameters: data),
        (dynamic data) => ProductModelApi.fromJson(data),
        'Product List');
  }

  /// Product Details
  @override
  Future<ProductDetailsModel> getProductDetails(int id) async {
    final Map<String, int> data = {
      'product_id': id,
    };
    return _handleRequest<ProductDetailsModel>(
        () => _dio.post(ApiEndpoint.productDetails, queryParameters: data),
        (dynamic data) => ProductDetailsModel.fromJson(data),
        'Product Details');
  }

  ///  SortFilter List
  @override
  Future<SortFilterListModel> sortFilterList() async {
    return _handleRequest<SortFilterListModel>(
        () => _dio.get(ApiEndpoint.sortFilterList),
        (dynamic data) => SortFilterListModel.fromJson(data),
        'Sort Filter List');
  }

  ///  Product Variation List
  @override
  Future<ProductVariationListModel> productVariationList() async {
    return _handleRequest<ProductVariationListModel>(
        () => _dio.get(ApiEndpoint.productVariationList),
        (dynamic data) => ProductVariationListModel.fromJson(data),
        'Product Variation List');
  }

  ///  Search
  @override
  Future<ProductModelApi> getSearch({
    required String text,
    String? sort,
    int? filterColorID,
    int? filterSizeID,
    int? page,
  }) async {
    final Map<String, dynamic> data = {
      'product_search': text,
      'sort': sort,
      'filter_color': filterColorID,
      'filter_size': filterSizeID,
      'page': page,
    };
    return _handleRequest<ProductModelApi>(
        () => _dio.post(ApiEndpoint.search, queryParameters: data),
        (dynamic data) => ProductModelApi.fromJson(data),
        'Search');
  }

  /// Cart
  /// Get Cart List
  @override
  Future<CartGetModel> getCart() async {
    return _handleRequest<CartGetModel>(() => _dio.get(ApiEndpoint.cartList),
        (dynamic data) => CartGetModel.fromJson(data), 'Cart get method');
  }

  ///  Add To Cart
  @override
  Future<CartPostModel> postCart(
      int productID, int varientID, int qty, int sizeID) async {
    final Map<String, int> data = {
      'product_id': productID.toInt(),
      'varient_id': varientID.toInt(),
      'qty': qty.toInt(),
      'size_id': sizeID.toInt()
    };
    return _handleRequest<CartPostModel>(
        () => _dio.post(ApiEndpoint.cartAddToCart, data: data),
        (dynamic data) => CartPostModel.fromJson(data),
        'Cart Post method');
  }

  /// Update Cart
  @override
  Future<CartUpdateModel> updateCart(
      int productID, int qty, int varientID, int sizeID) async {
    final Map<String, dynamic> data = {
      'product_id': productID,
      'qty': qty,
      'varient_id': varientID,
      'size_id': sizeID,
    };
    return _handleRequest<CartUpdateModel>(
        () => _dio.post(ApiEndpoint.cartUpdate, queryParameters: data),
        (dynamic data) => CartUpdateModel.fromJson(data),
        'Cart Update');
  }

  /// Remove To Cart
  @override
  Future<CartItemRemoveModel> removeCart(int id) {
    return _handleRequest<CartItemRemoveModel>(
        () => _dio.get('${ApiEndpoint.cartItemRemove}/$id'),
        (dynamic data) => CartItemRemoveModel.fromJson(data),
        'Cart Remove Item');
  }

  /// Delivery List
  @override
  Future<DeliveryListModel> getDeliveryList() async {
    return _handleRequest<DeliveryListModel>(
        () => _dio.get(ApiEndpoint.deliveryList),
        (dynamic data) => DeliveryListModel.fromJson(data),
        'Delivery List');
  }

  /// Delivery Options
  @override
  Future<DeliveryOptionsModel> getDeliveryOptions() async {
    return _handleRequest<DeliveryOptionsModel>(
      () => _dio.get(ApiEndpoint.deliveryOptions),
      (dynamic data) => DeliveryOptionsModel.fromJson(data),
      'Delivery Options',
    );
  }

  /// Payment Type
  @override
  Future<PaymentModel> getPaymentType() async {
    return _handleRequest<PaymentModel>(() => _dio.get(ApiEndpoint.paymentType),
        (dynamic data) => PaymentModel.fromJson(data), 'Payment Type');
  }

  /// Delivery Charge
  @override
  Future<DeliveryChargeModel> deliveryCharge() async {
    return _handleRequest<DeliveryChargeModel>(
        () => _dio.get(ApiEndpoint.deliveryCharge),
        (dynamic data) => DeliveryChargeModel.fromJson(data),
        'Delivery Charge');
  }

  /// Order List
  //Post
  @override
  Future<OrderListPostModel> orderList(String shippingAddressId,
      String paymentType, String isAdvancePayment, String deliveryCharge) async {
    var data = FormData.fromMap({
      'shipping_address_id': shippingAddressId.toString(),
      'payment_type': paymentType,
      'advance_payment': isAdvancePayment,
      'delivery_charge' : deliveryCharge,
    });

    return _handleRequest<OrderListPostModel>(
        () => _dio.post(ApiEndpoint.orderList, data: data),
        (dynamic data) => OrderListPostModel.fromJson(data),
        "Order List");
  }

  /// Re-Order
  @override
  Future<ReOrderModel> reOrder(
    String invoiceID,
    String paymentMethod,
  ) async {
    final Map<String, dynamic> data = ({
      'invoiceID': invoiceID,
      'paymentMethod': paymentMethod,
    });
    return _handleRequest<ReOrderModel>(
        () => _dio.post(ApiEndpoint.reOrder, queryParameters: data),
        (dynamic data) => ReOrderModel.fromJson(data),
        'Re-Order Model');
  }

  /// User order Post
  @override
  Future<UserOrderListGetModel> userOrderList({int? page}) async {
    final Map<String, dynamic> data = {
      'page': page,
    };
    return _handleRequest<UserOrderListGetModel>(
        () => _dio.post(ApiEndpoint.userOrderList, queryParameters: data),
        (dynamic data) => UserOrderListGetModel.fromJson(data),
        "User Order List");
  }

  /// User active order Post
  @override
  Future<UserOrderListGetModel> userActiveOrderList({int? page}) async {
    final Map<String, dynamic> data = {
      'status': 'Active',
      'page': page,
    };
    return _handleRequest<UserOrderListGetModel>(
        () => _dio.post(ApiEndpoint.userOrderList, queryParameters: data),
        (dynamic data) => UserOrderListGetModel.fromJson(data),
        "User Active Order List");
  }

  // user order cancel
  @override
  Future<UserOrderListCancelModel> userOrderCancel(String invoiceID) async {
    var data = FormData.fromMap({
      'invoiceID': invoiceID,
    });
    return _handleRequest<UserOrderListCancelModel>(
        () => _dio.post(ApiEndpoint.userOrderCancel, data: data),
        (dynamic data) => UserOrderListCancelModel.fromJson(data),
        "User Order Cancel");
  }

  /// WishList
  /// Get WishList
  @override
  Future<WishListModel> getWishlist() async {
    return _handleRequest<WishListModel>(
        () => _dio.get(ApiEndpoint.wishlistList),
        (dynamic data) => WishListModel.fromJson(data),
        'Get WishList');
  }

  ///   add to wishlist
  @override
  Future<AddToWishlistModel> addToWishlist(
      int productId, int productVariationId, int productSizeId) async {
    final Map<String, int> data = {
      'product_id': productId.toInt(),
      'productvariation_id': productVariationId.toInt(),
      'size_id': productSizeId.toInt(),
    };
    return _handleRequest<AddToWishlistModel>(
        () => _dio.post(ApiEndpoint.wishlistAddWishlist, data: data),
        (dynamic data) => AddToWishlistModel.fromJson(data),
        'Add to wishlist Post method');
  }

  ///   remove to wishlist
  @override
  Future<RemoveToWishlistModel> removeToWishlist(int productId) async {
    final Map<String, int> data = {
      'product_id': productId.toInt(),
    };
    return _handleRequest<RemoveToWishlistModel>(
        () => _dio.post(ApiEndpoint.wishlistRemoveWishlist, data: data),
        (dynamic data) => RemoveToWishlistModel.fromJson(data),
        'Remove to wishlist Post method');
  }

  ///    Remove All From WishList
  @override
  Future<RemoveAllWishListModel> removeAllWishList() async {
    return _handleRequest<RemoveAllWishListModel>(
        () => _dio.post(ApiEndpoint.removeAllWishlist),
        (dynamic data) => RemoveAllWishListModel.fromJson(data),
        "Remove All From WishList");
  }

  /// Review
  //Get
  @override
  Future<ReviewGetModel> getReview(String productID) async {
    var data = FormData.fromMap({'product_id': productID});
    return _handleRequest<ReviewGetModel>(
        () => _dio.post(ApiEndpoint.reviewList, data: data),
        (dynamic data) => ReviewGetModel.fromJson(data),
        'Review List'); // Post
  }

  // Post
  @override
  Future<ReviewAddModel> addReview(
      int productID, String text, double rating, String? file) async {
    // Make the file nullable
    var data = FormData.fromMap({
      'product_id': productID,
      'text': text,
      'rating': rating.toString(),
    });
    if (file != null && !file.contains("public/images/")) {
      data.files.add(MapEntry(
        'image',
        await MultipartFile.fromFile(file, filename: file),
      ));
    }
    return _handleRequest<ReviewAddModel>(
      () => _dio.post(ApiEndpoint.reviewAdd, data: data),
      (dynamic data) => ReviewAddModel.fromJson(data),
      'Review Add',
    );
  }

  /// Currency
  @override
  Future<CurrencyModel> getCurrency() async {
    return _handleRequest<CurrencyModel>(
        () => _dio.get(ApiEndpoint.getCurrency),
        (dynamic data) => CurrencyModel.fromJson(data),
        'Currency');
  }

  /// Q & A
  @override
  Future<QaGetModel> qaList() async {
    return _handleRequest<QaGetModel>(() => _dio.get(ApiEndpoint.qaList),
        (dynamic data) => QaGetModel.fromJson(data), 'Q&A List');
  }

  @override
  Future<QaUserPostModel> qaUserQus(
      String userID, String productID, String qus) async {
    var data = FormData.fromMap(
        {'user_id': userID, 'product_id': productID, 'question': qus});
    return _handleRequest<QaUserPostModel>(
        () => _dio.post(ApiEndpoint.qaUserQus, data: data),
        (dynamic data) => QaUserPostModel.fromJson(data),
        'Q&A Question');
  } // Post

  /// Shipping Address
  //Get
  @override
  Future<ShippingAddressGetModel> getShippingAddress() async {
    return _handleRequest<ShippingAddressGetModel>(
        () => _dio.get(ApiEndpoint.addressList),
        (dynamic data) => ShippingAddressGetModel.fromJson(data),
        'Shipping Address List');
  }

  //Post
  @override
  Future<ShippingAddressPostModel> addShippingAddress(
    String name,
    String email,
    String phone,
    String city,
    String district,
    String area,
    String address,
    String deliveryCharge,
    String label,
  ) async {
    final Map<String, String> data = {
      'label': label,
      'name': name,
      'phone': phone,
      'email': email,
      'city': city,
      'district': district,
      'selected_area': area,
      'delivery_charge': deliveryCharge,
      'address': address,
    };
    return _handleRequest<ShippingAddressPostModel>(
        () => _dio.post(ApiEndpoint.addressAdd, data: data),
        (dynamic data) => ShippingAddressPostModel.fromJson(data),
        'Add Shipping Address');
  }

  /// Post Update
  @override
  Future<ShippingAddressUpdateModel> updateShippingAddress(
    String label,
    String name,
    String phone,
    String email,
    String city,
    String district,
    String area,
    String address,
    String deliveryCharge,
    int addressID,
  ) async {
    final Map<String, dynamic> data = {
      'label': label,
      'name': name,
      'phone': phone,
      'email': email,
      'city': city,
      'district': district,
      'selected_area': area,
      'address': address,
      'delivery_charge': deliveryCharge,
      'shipping_address_id': addressID,
    };
    return _handleRequest<ShippingAddressUpdateModel>(
        () => _dio.post(ApiEndpoint.addressUpdate, data: data),
        (dynamic data) => ShippingAddressUpdateModel.fromJson(data),
        'Update Shipping Address');
  }

  // Post Delete
  @override
  Future<ShippingAddressDeleteModel> deleteShippingAddress(
      int addressID) async {
    final data = FormData.fromMap({
      'shipping_address_id': addressID,
    });
    return _handleRequest<ShippingAddressDeleteModel>(
        () => _dio.post(ApiEndpoint.addressDelete, data: data),
        (dynamic data) => ShippingAddressDeleteModel.fromJson(data),
        'Delete Shipping Address');
  }

  /// Courier
  // Get courierList
  @override
  Future<CourierGetModel> courierList() async {
    return _handleRequest<CourierGetModel>(
        () => _dio.get(ApiEndpoint.courierList),
        (dynamic data) => CourierGetModel.fromJson(data),
        'Courier Get');
  }

  /// Slider
  @override
  Future<SliderModel> getSlider() {
    return _handleRequest<SliderModel>(() => _dio.get(ApiEndpoint.slider),
        (dynamic data) => SliderModel.fromJson(data), 'Slider');
  }

  /// Promos Coupon
  @override
  Future<PromosGetModel> getPromos() async {
    return _handleRequest<PromosGetModel>(
        () => _dio.get(ApiEndpoint.couponList),
        (dynamic data) => PromosGetModel.fromJson(data),
        'Promos');
  }

  /// Notification
  @override
  Future<NotificationModel> getNotification() async {
    return _handleRequest<NotificationModel>(
        () => _dio.get(ApiEndpoint.notification),
        (dynamic data) => NotificationModel.fromJson(data),
        'Notification');
  }

  // Post
  @override
  Future<PromosPostModel> applyPromos(String code) async {
    final Map<String, dynamic> data = {
      'coupon_code': code,
    };
    return _handleRequest<PromosPostModel>(
        () => _dio.post(ApiEndpoint.couponApply, data: data),
        (dynamic data) => PromosPostModel.fromJson(data),
        'Promos Apply');
  }

  /// Profile
  /// Get
  @override
  Future<ProfileGetModel> profileDetails() async {
    return _handleRequest<ProfileGetModel>(
        () => _dio.get(ApiEndpoint.profileDetails),
        (dynamic data) => ProfileGetModel.fromJson(data),
        'Profile Details');
  }

  /// Update
  @override
  Future<ProfilePostModel> profileUpdates(
    String name,
    String email,
    String birthday,
    String gender,
    String phone,
    String country,
    String? file, // Make file nullable
  ) async {
    var data = FormData.fromMap({
      'name': name,
      'email': email,
      'birthday': birthday,
      'gender': gender,
      'phone': phone,
      'country': country,
    });

    if (file != null && !file.contains("public/images/")) {
      data.files.add(
        MapEntry(
          'image',
          await MultipartFile.fromFile(file, filename: file),
        ),
      );
    }

    return _handleRequest<ProfilePostModel>(
      () => _dio.post(ApiEndpoint.profileUpdate, data: data),
      (dynamic data) => ProfilePostModel.fromJson(data),
      'Profile Update',
    );
  }

  /// Alert
  @override
  Future<AlertModel> getAlert() async {
    return _handleRequest<AlertModel>(() => _dio.get(ApiEndpoint.getAlert),
        (dynamic data) => AlertModel.fromJson(data), 'Alert Api');
  }

  ///  Collections
  @override
  Future<CollectionModel> getCollections() async {
    return _handleRequest<CollectionModel>(
        () => _dio.get(ApiEndpoint.getCollections),
        (dynamic data) => CollectionModel.fromJson(data),
        'Collection Api');
  }

  ///  Dashboard user count
  @override
  Future<DashboardUserCountModel> getDashboardUserCount() async {
    return _handleRequest<DashboardUserCountModel>(
        () => _dio.get(ApiEndpoint.dashboardUserCount),
        (dynamic data) => DashboardUserCountModel.fromJson(data),
        'Dashboard user count Api');
  }
}

//Handle API request and response with error handling
Future<T> _handleRequest<T>(Future<Response<dynamic>> Function() request,
    T Function(dynamic) mapper, String apiName) async {
  try {
    final response = await request();
    // Log.i('Print Status Code');
    // Log.i(response.statusCode);
    // Log.i(response.data);
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 422) {
      debugPrint('Api Name: $apiName');
      return mapper(response.data);
    } else {
      Log.i('Api Exception Error ${response.toString()}');
      throw ApiException('Failed to load data: ${response.statusCode}',
          statusCode: response.statusCode!);
    }
  } catch (e) {
    Log.i('Error $apiName : ${e.toString()}');
    throw ApiException('Failed to load data: $e', statusCode: 500);
  }
}

// Custom exception class for API errors
class ApiException implements Exception {
  final String message;
  final int statusCode;

  ApiException(this.message, {this.statusCode = 500});
}
