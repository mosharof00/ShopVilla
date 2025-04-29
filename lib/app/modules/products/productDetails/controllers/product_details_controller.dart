import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/modules/promos_vouchers/controllers/promos_vouchers_controller.dart';
import '../../../../../helper/exception_handle.dart';
import '../../../../models/Reviews/review_get_model.dart';
import '../../../../models/product_details/product_details_model.dart';
import '../../../../models/q&a/q&aGetModel.dart';
import '../../../../repository/api_services.dart';

class ProductDetailsController extends GetxController {
  /// Product Details Form Api
  /// Api Service
  final apiService = Get.put(ApiServices());
  final product = ProductDetailsModel().obs;
  final isLoadingProductDetails = true.obs;
  final promosController = Get.put(PromosVouchersController());
  // Product Details Image
  final selectedImage = 0.obs;
  // Pick Variation and Size
  final tabSelectedIndex = 0.obs;
  final colorSelectedIndex = 0.obs;
  final sizeSelectedIndex = 0.obs;
  // Pick VarientID and SizeID
  final selectedVarientID = 0.obs;
  final selectedSizeID = 0.obs;
  // Product Quantity
  final productQty = 1.obs;
  // Pick Category and SubCategory
  final categoryId = 0.obs;
  final subCategoryId = 0.obs;
  // For SingleChildScrollView in ProductDetails
  final ScrollController scrollController = ScrollController();
  late Productvariation selectedVarientIndex;
  // Dot Indicator
  CarouselSliderController carouselController = CarouselSliderController();
  final currentDotedIndex = 0.obs;

  /// Calculate Discount Perchantage
  double getDiscountPerchantage(int regularPrice, int discount) {
    return (discount / regularPrice) * 100;
  }

  // Scroll to Top
  void scrollToTop() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }


  Future<void> getProductDetails(int productID) async {
    try {
      final productDetails = await apiService.getProductDetails(productID);
      isLoadingProductDetails.value = false;
      product.value = productDetails;
      if (productDetails.data!.productvariations!.isNotEmpty) {
        selectColor(0);
        categoryId.value = productDetails.data!.categoryId!;
        subCategoryId.value = productDetails.data!.subCategoryId!;
        promosController.getPromos(currentProductCategoryId: categoryId.value);
        getSimilarProducts(
            categoryId: categoryId.value, subCategoryId: subCategoryId.value);
      }
      scrollToTop();
    } catch (e) {
      isLoadingProductDetails.value = true;
      debugPrint("product Details error ${e.toString()}");
      handleException(e);
    }
  }



  // Update Color Selection
  void selectColor(int index) {
    sizeSelectedIndex.value = 0;
    colorSelectedIndex.value = index;
    selectedVarientID.value = product.value.data!.productvariations![index]
        .id!; // Update selected variant ID
    selectedVarientIndex = product.value.data!.productvariations![index];
    selectedSizeID.value = product.value.data!.productvariations![index]
        .sizes![0].id!; // Update selected size ID
  }

  // Update size selection
  void selectSize(int index) {
    sizeSelectedIndex.value = index;
    selectedSizeID.value =
        selectedVarientIndex.sizes![sizeSelectedIndex.value].id!;
  }

  //QA Get list
  TextEditingController textEditingController = TextEditingController();
  final replyTextControllers = <String, TextEditingController>{}.obs;
  final qusAnsList = <QusAnsGetList>[].obs;
  final isLoadingQalist = true.obs;
  Future<void> qaList(int productID) async {
    try {
      isLoadingQalist.value = true;
      final list = await apiService.qaList(); // Fetch Q&A list from API
      isLoadingQalist.value = false;
      if (list.data!.isEmpty) {
        debugPrint('No Q&A for this Product');
      } else {
        qusAnsList.value = list.data!
            .where((qusAns) => qusAns.productId == productID.toString())
            .toList(); // Filter Q&A by product ID
      }
    } catch (e) {
      isLoadingQalist.value = true;
      handleException(e); // Handle API exception
    }
  }

  /// Product Reviews
  final reviewList = <GetReviews>[].obs;
  final reviewAvg = 0.0.obs;
  final isLoadingReviews = true.obs;
  void getReviews(int productID) async {
    try {
      final getReview = await apiService
          .getReview(productID.toString()); // Fetch reviews from API
      reviewList.value = getReview.data!
          .where((review) => review.productId == productID)
          .toList(); // Filter reviews by product ID
      isLoadingReviews.value = false;
      if (reviewList.isEmpty) {
        debugPrint('No Review Found');
      } else {
        double sum = 0;
        int count = reviewList.length;
        for (var review in reviewList) {
          sum += review.rating!;
        }
        reviewAvg.value = sum / count; // Calculate average rating
      }
    } catch (e) {
      isLoadingReviews.value = true;
      handleException(e); // Handle API exception
    }
  }

  ///   You may also like  / Similar products
  final similarProductList = [].obs;
  final isSimilarProductLoading = false.obs;
  final similarProductCurrentPage = 0.obs;
  final isSimilarProductEndPage = false.obs;

  void getSimilarProducts({
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
      isSimilarProductLoading.value = true;
      final products = await apiService.getProduct(
        sort: sort,
        filterType: filterType,
        filterSizeID: filterSizeID,
        filterColorID: filterColorID,
        categoryId: categoryId,
        subCategoryId: subCategoryId,
        collectionId: offerCollectionId,
        page: page,
      ); // Fetch similar products from API
      similarProductList.clear();
      similarProductList.value = products.data!.data!;
      isSimilarProductLoading.value = false;
    } catch (e) {
      handleException(e); // Handle API exception
      isSimilarProductLoading.value = false;
    }
  }

  void handleProductDetails() {
    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      final arguments = Get.arguments as Map<String, dynamic>;
      if (arguments.containsKey('productID')) {
        final productID = arguments['productID'];
        getProductDetails(productID); // Fetch product details
        getReviews(productID); // Fetch reviews
        qaList(productID); // Fetch Q&A
      } else {
        debugPrint('Product ID not found in arguments');
      }
    } else {
      debugPrint('Arguments are not a valid map');
    }
  }

  @override
  void onInit() {
    super.onInit();
    replyTextControllers.clear(); // Clear reply text controllers
  }

  @override
  void onReady() {
    handleProductDetails(); // Handle product details on ready
    super.onReady();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    replyTextControllers.forEach((key, controller) {
      controller.dispose(); // Dispose text controllers
    });
  }
}
