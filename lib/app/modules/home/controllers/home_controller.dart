import 'dart:async';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shop_villa/app/models/product/sort_filter__list_model.dart';
import 'package:shop_villa/app/modules/mainpage/controllers/mainpage_controller.dart';
import 'package:shop_villa/app/routes/app_pages.dart';
import 'package:shop_villa/app/services/local_store_config.dart';
import 'package:shop_villa/global/global_snackbar.dart';
import 'package:shop_villa/helper/helper_utils.dart';
import 'package:shop_villa/helper/log_printer.dart';
import '../../../../helper/exception_handle.dart';
import '../../../models/alert/alert_model.dart';
import '../../../models/brands/brand_model.dart';
import '../../../models/category/category_model.dart';
import '../../../models/collections/collection_model.dart';
import '../../../models/currency/currency.dart';
import '../../../repository/api_services.dart';

class HomeController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  CarouselSliderController carouselController1 = CarouselSliderController();
  CarouselSliderController carouselController2 = CarouselSliderController();
  final apiService = Get.put(ApiServices());
  final RxBool isShowAlert = false.obs;

  ///   Category
  final categoryList = <CategoryData>[].obs;
  final isCategoryLoading = 100.obs;

  /// special category
  final specialCategoryID = 0.obs;
  final specialCategoryData = CategoryData().obs;

  /// Sliders
  final sliderList = [].obs;
  final isBannerLoading = 1000.obs;
  final currentDotedIndex = 0.obs;

  /// Currency
  final currency = Currency().obs;

  ///  wishlist
  final wishlist = [].obs;
  final wishListedProductId = RxList<int>([]);

  ///  Collection
  final collectionList = <CollectionData>[].obs;
  final isCollectionLoading = true.obs;

  /// Brand
  final brandList = <Brand>[].obs;
  final isBrandsLoading = true.obs;

  ///  Flash Sales
  final flashSalesList = [].obs;
  final isFlashSalesLoading = 100
      .obs; //  0 = successfully get product,  1= loading , 2= error , 3 = the specific keyword value not found
  final flashSaleCurrentPage = 0.obs;
  final isFlashSaleEndPage = false.obs;
  final isFlashSaleScrollLoading = false.obs;

  ///  Special offers
  final specialOffersList = [].obs;
  final specialOfferHomeBannerList = [].obs;
  final isSpecialOffersLoading = 100.obs;
  final specialOffersCurrentPage = 0.obs;
  final isSpecialOffersEndPage = false.obs;
  final isSpecialOffersScrollLoading = false.obs;

  ///  New Arrivals
  final newArrivalsList = [].obs;
  final isNewArrivalsLoading = 100.obs;
  final newArrivalsCurrentPage = 0.obs;
  final isNewArrivalsEndPage = false.obs;
  final isNewArrivalsScrollLoading = false.obs;

  ///  Trending Products
  final trendingProductsList = [].obs;
  final isTrendingProductsLoading = 100.obs;
  final trendingProductsCurrentPage = 0.obs;
  final isTrendingProductsEndPage = false.obs;
  final isTrendingProductsScrollLoading = false.obs;

  ///   for sort filter
  final isSortFilterLoading =
      100.obs; //  0 = successfully get product, 1=loading , 2= error
  final sortList = <Sort>[].obs;
  final typeList = <FilterType>[].obs;

  /// Alert
  final alert = Rx<Alert?>(null);

  ///  Dashboard User count
  final totalCartedCount = 0.obs;
  final totalActiveOrderedCount = 0.obs;
  final totalWishListedCount = 0.obs;
  final totalNotificationCount = 0.obs;

  /// Fetch Category
  void fetchCategory() async {
    try {
      isCategoryLoading.value = 1;
      final categories = await apiService.getCategory();
      categoryList.value = categories.data!;
      isCategoryLoading.value = 0;

      for (int i = 0; i <= categoryList.length; i++) {
        CategoryData categoryData = categoryList[i];
        if (categoryData.type!.contains("special")) {
          specialCategoryID.value = categories.data![i].id!;
          specialCategoryData.value = categoryData;
          break;
        }
      }
    } catch (e) {
      handleException(e);
      isCategoryLoading.value = 2;
    }
  }

  /// Sliders
  void getSliders() async {
    try {
      isBannerLoading.value = 1;
      final slider = await apiService.getSlider();
      sliderList.value = slider.data!;
      isBannerLoading.value = 0;
    } catch (e) {
      handleException(e);
      isBannerLoading.value = 2;
    }
  }

  /// Currency
  Future<void> getCurrency() async {
    try {
      final response = await apiService.getCurrency();
      currency.value = response.data!;
    } catch (e) {
      handleException(e);
    }
  } //Get

  ///   Brands

  late ScrollController scrollController;
  Timer? timer;
  double scrollPosition = 0;
  void fetchBrands() async {
    try {
      isBrandsLoading.value = true;
      final response = await apiService.getBrands();
      brandList.value = response.data!.data!;
      isBrandsLoading.value = false;
    } catch (e) {
      handleException(e);
    }
  }

  /// Fetch Wishlist
  void fetchWishlist() async {
    try {
      final response = await apiService.getWishlist();
      if (response.data == null || response.data!.isEmpty) {
        return;
      } else {
        wishListedProductId.clear();
        for (int i = 0; i <= response.data!.length; i++) {
          if (!wishListedProductId.contains(response.data![i].productId)) {
            wishListedProductId.add(response.data![i].productId!);
            wishlist.add(response.data![i]);
          }
        }
      }
    } catch (e) {
      handleException(e);
    }
  }

  ///   Add to wishlist
  Future<void> addToWishlist(
      {required int productId,
      required int productVariationId,
      required int productSizeId}) async {
    try {
      final response = await apiService.addToWishlist(
          productId, productVariationId, productSizeId);
      if (response.status == true) {
        wishListedProductId.add(productId);
        globalSnackBar(
            title: 'Added to wishlist', message: response.message.toString());
      }
      // fetchWishlist();
      // wishListedProductId.add(productId);
    } catch (e) {
      handleException(e);
    }
  }

  ///   Remove to wishlist
  Future<void> removeToWishlist({required int productId}) async {
    try {
      final response = await apiService.removeToWishlist(productId);
      if (response.status == true) {
        wishListedProductId.remove(productId);
        globalSnackBar(
            title: 'Remove to wishlist', message: response.message.toString());
      }
      // fetchWishlist();
    } catch (e) {
      handleException(e);
    }
  }

  ///  Fetch SortFilter List
  void fetchSortFilterList() async {
    try {
      isSortFilterLoading.value = 1;
      final response = await apiService.sortFilterList();
      sortList.value = response.data!.sort!;
      typeList.value = response.data!.type!;
      isSortFilterLoading.value = 0;
    } catch (e) {
      handleException(e);
      isSortFilterLoading.value = 2;
    }
  }

  ///  LogOut
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<void> logOut() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        bool isGoogleSignIn = currentUser.providerData.any((userInfo) =>
            userInfo.providerId == GoogleAuthProvider.PROVIDER_ID);
        if (isGoogleSignIn) {
          await googleSignIn.signOut();
          Log.i('User signed out from Google');
        }
        await FirebaseAuth.instance.signOut();
      }
      final response = await apiService.logOutUser();
      HiveService.deleteToken();
      HiveService.deleteUserID();
      HiveService.setAlertShowed(false);
      Get.delete<HomeController>(force: true);
      Get.delete<MainPageController>(force: true);
      Get.offAllNamed(Routes.LOGIN);
      globalSnackBar(
          title: "Logout Successfully", message: response.message.toString());
    } catch (e) {
      handleException(e); // Handle any errors
    }
  }

  ///  Collection
  Future<void> getCollections() async {
    try {
      isCollectionLoading.value = true;
      final response = await apiService.getCollections();
      collectionList.value = response.data!;
      isCollectionLoading.value = false;
    } catch (e) {
      handleException(e);
      isCollectionLoading.value = false;
    }
  }

  ///          For    All  Type   Product    Fetching           ///

  ///  Flash Sales
  void fetchFlashSalesProducts({
    String? sort,
    String? filterType,
    int? filterSizeID,
    int? filterColorID,
    int? categoryId,
    int? subCategoryId,
    int? offerCollectionId,
    int? page,
  }) async {
    // if (isEndPage.value) return;
    try {
      if (page == null) {
        isFlashSalesLoading.value = 1;
      }
      final products = await apiService.getProduct(
        sort: sort,
        filterType: 'flash_sale',
        filterSizeID: filterSizeID,
        filterColorID: filterColorID,
        categoryId: categoryId,
        subCategoryId: subCategoryId,
        collectionId: offerCollectionId,
        page: page,
      );
      if (products.data!.data!.isEmpty) {
        isFlashSaleEndPage.value = true;
        isFlashSaleScrollLoading.value = false;
        if (page == null) {
          isFlashSalesLoading.value = 3;
        }
        return;
      }
      if (page == null) {
        flashSalesList.value = products.data!.data!;
        isFlashSalesLoading.value = 0;
      } else {
        flashSalesList.addAll(products.data!.data!);
        isFlashSalesLoading.value = 0;
      }

      flashSaleCurrentPage.value = products.data!.currentPage!;
      isFlashSaleScrollLoading.value = false;
      if (flashSaleCurrentPage.value == products.data!.lastPage!) {
        isFlashSaleEndPage.value = true;
      }
    } catch (e) {
      handleException(e);
      isFlashSaleScrollLoading.value = false;
      if (flashSaleCurrentPage.value >= 2) {
        globalSnackBar(
            title: "Something went wrong!",
            message: 'Fail reloading more product.\n Please try again letter');
        return;
      }
      isFlashSalesLoading.value = 2;
    }
  }

  ///   Special Offers
  void fetchSpecialOffersProducts({
    String? sort,
    String? filterType,
    int? filterSizeID,
    int? filterColorID,
    int? categoryId,
    int? subCategoryId,
    int? offerCollectionId,
    int? page,
  }) async {
    // if (isEndPage.value) return;
    try {
      if (page == null) {
        isSpecialOffersLoading.value = 1;
      }
      final products = await apiService.getProduct(
        sort: sort,
        filterType: filterType,
        filterSizeID: filterSizeID,
        filterColorID: filterColorID,
        categoryId: categoryId,
        subCategoryId: subCategoryId,
        collectionId: offerCollectionId,
        page: page,
      );
      if (products.data!.data!.isEmpty) {
        isSpecialOffersEndPage.value = true;
        isSpecialOffersScrollLoading.value = false;
        if (page == null) {
          isSpecialOffersLoading.value = 3;
        }
        return;
      }
      if (page == null) {
        specialOfferHomeBannerList.value = products.data!.data!;
        specialOffersList.value = products.data!.data!;
        isSpecialOffersLoading.value = 0;
      } else {
        specialOffersList.addAll(products.data!.data!);
        isSpecialOffersLoading.value = 0;
      }
      specialOffersCurrentPage.value = products.data!.currentPage!;
      isSpecialOffersScrollLoading.value = false;
      if (specialOffersCurrentPage.value == products.data!.lastPage!) {
        isSpecialOffersEndPage.value = true;
      }
    } catch (e) {
      handleException(e);
      isSpecialOffersScrollLoading.value = false;
      isSpecialOffersLoading.value = 2;
    }
  }

  ///  New Arrivals
  void fetchNewArrivalsProducts({
    String? sort,
    String? filterType,
    int? filterSizeID,
    int? filterColorID,
    int? categoryId,
    int? subCategoryId,
    int? offerCollectionId,
    int? page,
  }) async {
    try {
      if (page == null) {
        isNewArrivalsLoading.value = 1;
      }
      final products = await apiService.getProduct(
        sort: sort,
        filterType: filterType,
        filterSizeID: filterSizeID,
        filterColorID: filterColorID,
        categoryId: categoryId,
        subCategoryId: subCategoryId,
        collectionId: offerCollectionId,
        page: page,
      );
      if (products.data!.data!.isEmpty) {
        isNewArrivalsEndPage.value = true;
        isNewArrivalsScrollLoading.value = false;
        if (page == null) {
          isNewArrivalsLoading.value = 3;
        }
        return;
      }
      if (page == null) {
        newArrivalsList.value = products.data!.data!;
        isNewArrivalsLoading.value = 0;
      } else {
        newArrivalsList.addAll(products.data!.data!);
        isNewArrivalsLoading.value = 0;
      }
      newArrivalsCurrentPage.value = products.data!.currentPage!;
      isNewArrivalsScrollLoading.value = false;
      if (newArrivalsCurrentPage.value == products.data!.lastPage!) {
        isNewArrivalsEndPage.value = true;
      }
    } catch (e) {
      handleException(e);
      isNewArrivalsScrollLoading.value = false;
      isNewArrivalsLoading.value = 2;
    }
  }

  ///  Trending Products
  void fetchTrendingProducts({
    String? sort,
    String? filterType,
    int? filterSizeID,
    int? filterColorID,
    int? categoryId,
    int? subCategoryId,
    int? offerCollectionId,
    int? page,
  }) async {
    // if (isEndPage.value) return;
    try {
      if (page == null) {
        isTrendingProductsLoading.value = 1;
      }
      final products = await apiService.getProduct(
        sort: sort,
        filterType: filterType,
        filterSizeID: filterSizeID,
        filterColorID: filterColorID,
        categoryId: categoryId,
        subCategoryId: subCategoryId,
        collectionId: offerCollectionId,
        page: page,
      );
      if (products.data!.data!.isEmpty) {
        isTrendingProductsEndPage.value = true;
        isTrendingProductsScrollLoading.value = false;
        if (page == null) {
          isTrendingProductsLoading.value = 3;
        }
        return;
      }
      if (page == null) {
        trendingProductsList.value = products.data!.data!;
        isTrendingProductsLoading.value = 0;
      } else {
        trendingProductsList.addAll(products.data!.data!);
        isTrendingProductsLoading.value = 0;
      }
      trendingProductsCurrentPage.value = products.data!.currentPage!;
      isTrendingProductsScrollLoading.value = false;

      if (trendingProductsCurrentPage.value == products.data!.lastPage!) {
        isTrendingProductsEndPage.value = true;
      }
    } catch (e) {
      handleException(e);
      isTrendingProductsScrollLoading.value = false;
      isTrendingProductsLoading.value = 2;
    }
  }

  /// Alert
  Future<void> getAlert() async {
    try {
      final response = await apiService.getAlert();
      // if Alert active status is true then alert will be shown accordingly
      if (response.data!.active!) {
        alert.value = response.data!;
      } else {
        HiveService.setAlertShowed(false);
      }
    } catch (e) {
      handleException(e);
      Log.e('Alert : $e');
    }
  }

  ///  Dashboard User count
  Future<void> fetchDashboardUserCount() async {
    try {
      final response = await apiService.getDashboardUserCount();
      totalCartedCount.value = response.data!.totalCart!;
      totalActiveOrderedCount.value = response.data!.totalActiveOrder!;
      totalWishListedCount.value = response.data!.totalWishlist!;
      totalNotificationCount.value = response.data!.totalNotification!;
    } catch (e) {
      handleException(e);
    }
  }

  // Brands Auto Scrolling
  // void startAutoScroll() {
  //   timer = Timer.periodic(const Duration(seconds: 2), (timer) {
  //     if (scrollController.hasClients) {
  //       double maxScrollExtent = scrollController.position.maxScrollExtent;
  //       double itemWidth = 100; // Adjust according to item width
  //       // Move the scroll by the width of one item
  //       scrollPosition += itemWidth;
  //       if (scrollPosition > maxScrollExtent) {
  //         // Reset to the first item if we reach the end
  //         scrollPosition = scrollController.position.minScrollExtent;
  //       }
  //       scrollController.animateTo(
  //         scrollPosition,
  //         duration: const Duration(milliseconds: 500),
  //         curve: Curves.linear,
  //       );
  //     }
  //   });
  // }

  @override
  void onInit() async {
    scrollController = ScrollController();
    getCurrency();
    fetchSortFilterList();
    fetchCategory();
    getSliders();
    getCollections();
    fetchBrands();
    fetchFlashSalesProducts(filterType: HelperUtils.flashSales);
    fetchSpecialOffersProducts(filterType: HelperUtils.specialOffers);
    fetchNewArrivalsProducts(filterType: HelperUtils.newArrivals);
    fetchTrendingProducts(filterType: HelperUtils.trendingProducts);
    if (HelperUtils.isLogin) {
      fetchDashboardUserCount();
      fetchWishlist();
    }
    getAlert();
    super.onInit();
  }

  @override
  void onClose() {
    timer?.cancel(); // Cancel the timer when controller is closed
    scrollController.dispose();
    super.onClose();
  }
}
