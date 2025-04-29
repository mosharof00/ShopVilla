

class ApiEndpoint {
  ///  Base URL
   static const String domainUrl = 'https://shop_villa.arcadexit.com';
  // static const String domainUrl = 'https://devshop_villa.arcadexit.com';
  //  static const String domainUrl = 'http://192.168.68.101:8000';
  static const String baseUrl = '$domainUrl/api';

  ///  Auth
  static const String register = '$baseUrl/register'; // post
  static const String login = '$baseUrl/login'; // post
  static const String logout = '$baseUrl/dashboard/logout'; // post
  static const String sendOTP = '$baseUrl/forget-password/send-otp'; // post
  static const String verifyOTP = '$baseUrl/forget-password/otp-verify'; // post
  static const String resetPassword =
      '$baseUrl/forget-password/reset-password'; // post

  /// Admin Info
  static const String adminInfo = '$baseUrl/admin/list';
  ///  Category
  static const String categoryList = '$baseUrl/category/list'; // get
  static const String categoryStore = '$baseUrl/category/store'; // post
  static const String categoryUpdate8 = '$baseUrl/category/update/8'; // post
  ///  subcategory
  static const String subcategoryList = '$baseUrl/subcategory/list'; // get
  static const String subcategoryStore = '$baseUrl/subcategory/store'; // post
  static const String subcategoryUpdate4 =
      '$baseUrl/subcategory/update/4'; // post
  ///  childCategory
  static const String childCategoryList = '$baseUrl/childcategory/list'; // get
  static const String childCategoryStore =
      '$baseUrl/childcategory/store'; // post
  static const String childCategoryUpdate1 =
      '$baseUrl/childcategory/update/1'; // post
  ///  brand
  static const String brandList = '$baseUrl/brand/list'; // get
  static const String brandStore = '$baseUrl/brand/store'; // post
  static const String brandUpdate1 = '$baseUrl/brand/update/1'; // post
  /// Re-Order
  static const String reOrder = '$baseUrl/checkout/re-order'; //Post
  ///  product
  static const String productList = '$baseUrl/product/list'; // get
  static const String productDetails = '$baseUrl/product/details'; // get
  static const String checkoutOrder =
      '$baseUrl/$baseUrl/checkout/order'; // post
  static const String productStore = '$baseUrl/product/store'; // post
  static const String productVariationList =
      '$baseUrl/product/product/variation'; // get
  static const String sortFilterList = '$baseUrl/product/sort-type'; // get
  /// Product Attribute
  static const String productAttribute =
      '$baseUrl/product-attribute/list'; // get
  ///  Search
  static const String search = '$baseUrl/search'; // post
  ///  cart
  static const String cartList = '$baseUrl/cart/list'; // Get
  static const String cartAddToCart = '$baseUrl/cart/addtocart'; // Post
  static const String cartUpdate = '$baseUrl/cart/addtocart/update'; // Post
  static const String cartItemRemove = '$baseUrl/cart/remove/cart/item'; //Get
  ///  checkOut
  static const String checkList = '$baseUrl/checkout/list'; // Get
  /// Payment Type
  static const String paymentType = '$baseUrl/payment-type'; // Get
  /// Delivery Charge
  static const String deliveryCharge = '$baseUrl/delivary-charge'; // Get
  static const String deliveryList = '$baseUrl/delivary-city'; // Get
  static const String deliveryOptions = '$baseUrl/delivary-option'; // Get
  /// Order Place
  static const String orderList = '$baseUrl/checkout/order'; // Post
  static const String userOrderList = '$baseUrl/user/order/list'; // Post
  static const String userOrderCancel = '$baseUrl/user/order/cancel'; // Post
  ///  wishlist
  static const String wishlistList = '$baseUrl/wishlist/list'; // Get
  static const String wishlistAddWishlist =
      '$baseUrl/wishlist/add/wishlist'; // post
  static const String wishlistRemoveWishlist =
      '$baseUrl/wishlist/remove/wishlist'; // post
  static const String removeAllWishlist =
      '$baseUrl/wishlist/remove/all/wishlist'; // post
  /// Shipping Address
  static const String addressList = '$baseUrl/shipping-address/list'; //Get
  static const String addressAdd = '$baseUrl/shipping-address/store'; //Post
  static const String addressUpdate = '$baseUrl/shipping-address/update'; //Post
  static const String addressDelete =
      '$baseUrl/shipping-address/destroy'; //Post
  /// Courier
  static const String courierList = '$baseUrl/courier/list'; // Get
  /// Slider
  static const String slider = '$baseUrl/slider/list';

  /// Reviews
  static const String reviewList = '$baseUrl/review/list'; //Get
  static const String reviewAdd = '$baseUrl/review/store'; //Post Store
  static const String reviewUpdate = '$baseUrl/review/update/1'; //Post Update
  /// Currency
  static const String getCurrency = '$baseUrl/currency/list'; // Get
  /// Q & A
  static const String qaList = '$baseUrl/list';
  static const String qaUserQus = '$baseUrl/question';
  static const String qaUserAgainQus = '$baseUrl/question';

  /// Promos Coupon
  static const String couponList = '$baseUrl/coupon/list'; //Get
  /// Notification
  static const String notification = '$baseUrl/user-notification'; //Get
  static const String couponApply = '$baseUrl/coupon/apply'; //Post
  /// Profile
  static const String profileDetails = '$baseUrl/profile/details'; //Get
  static const String profileUpdate = '$baseUrl/profile/update'; //Post
  ///  logOut
  static const String dashboardLogout = '$baseUrl/dashboard/logout'; // post
  ///  user count
  static const String dashboardUserCount = '$baseUrl/dashboard/all-count';

  ///  newCollection
  static const String bazar365Api = '$baseUrl/dashboard/logout'; // get
  /// Alert
  static const String getAlert = '$baseUrl/alert'; // get
  ///  Collection
  static const String getCollections = '$baseUrl/product/collection'; // get
}
