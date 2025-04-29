import 'package:get/get.dart';
import 'package:shop_villa/app/models/product/porduct_model_api.dart';
import 'package:shop_villa/app/repository/api_services.dart';
import 'package:shop_villa/global/global_snackbar.dart';
import 'package:shop_villa/helper/exception_handle.dart';
import '../../../../global/global_controllers/product_attributes_controller.dart';

class ProductsController extends GetxController {
  ProductAttributesController productAttributesController =
      Get.put(ProductAttributesController());

  final apiService = ApiServices();
  final appBarTitle = "".obs;
  final favourite = false.obs;
  var productModelApi = ProductModelApi().obs;
  final productList = [].obs;
  final isLoading =
      100.obs; //  0 = successfully get product, 1=loading , 2= error
  final isFromSearch = false.obs;
  final selectedVariationIndex = 0.obs;
  final isFiltered = false.obs;
  final isSorted = false.obs;
  final isFromCollection = false.obs;

  ///  for pagination
  final currentPage = 0.obs;
  final isEndPage = false.obs;
  final scrollLoading = false.obs;

  /// for search
  final searchedText = "".obs;

  ///  for Sort and filter
  ///  size
  final selectedFilterSizeID = 0.obs;
  final selectedSizeName = ''.obs;
  final selectedSizeIndex = 10000.obs;

  /// color
  final selectedFilterColorID = 0.obs;
  final selectedFilterColorName = ''.obs;
  final selectedColorIndex = 10000.obs;

  /// type
  String initialType = '';
  final selectedFilterTypeName = ''.obs;
  RxInt selectedFilterTypeIndex = 10000.obs;
  final isFilterTypeSelected = false.obs;

  ///  for Sort
  final selectedSortName = ''.obs;
  RxInt selectedSortIndex = 10000.obs;

  ///  for category & subCategory
  final categoryID = 0.obs;
  final subCategoryID = 0.obs;

  ///   collections
  final selectedCollectionId = 0.obs;

  ///  brand
  final selectedBrandID = 0.obs;


  void getProduct(
      {required ProductModelApi productModelApi_,
      required List productList_,
      required int status_}) {
    productModelApi.value = productModelApi_;
    productList.addAll(productList_);
    isLoading.value = status_;
  }

  ///  Fetch Products
  void fetchProducts({
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
        isLoading.value = 1;
        currentPage.value = 0;
        isEndPage.value = false;
      }
      final products = await apiService.getProduct(
        sort: selectedSortName.value,
        filterType: selectedFilterTypeName.value,
        filterSizeID: selectedFilterSizeID.value,
        filterColorID: selectedFilterColorID.value,
        categoryId: categoryID.value,
        subCategoryId: subCategoryID.value,
        collectionId: selectedCollectionId.value,
        brandId: selectedBrandID.value,
        page: page,
      );
      // Log.w('sort: ${selectedSortName.value},filterType: ${selectedFilterTypeName.value}, categoryid:  ${categoryID.value}, collectionid:  ${selectedCollectionId.value}');

      if (products.data!.data!.isEmpty) {
        isEndPage.value = true;
        scrollLoading.value = false;
        if (page == null) {
          isLoading.value = 3;
        }
        return;
      }
      if (page == null) {
        productList.value = products.data!.data!;
        productModelApi.value = products;
        isLoading.value = 0;
      } else {
        getProduct(
            productModelApi_: products,
            productList_: products.data!.data!,
            status_: 0);
      }

      currentPage.value = products.data!.currentPage!;
      scrollLoading.value = false;
      if (currentPage.value == products.data!.lastPage!) {
        isEndPage.value = true;
      }
    } catch (e) {
      handleException(e);
      scrollLoading.value = false;
      if (currentPage.value >= 2) {
        globalSnackBar(
            title: "Something went wrong!",
            message: 'Fail reloading more product.\n Please try again letter');
        return;
      }
      isLoading.value = 2;
    }
  }

  ///             For Search                  ///

  void getSearch(String text) {
    searchedText.value = text;
    fetchSearchProduct(
      text: text,
    );
    isFromSearch.value = true;
    isEndPage.value = false;
    productList.clear();
  }

  Future<void> fetchSearchProduct({
    required String text,
    String? sort,
    int? filterColorID,
    int? filterSizeID,
    int? page,
  }) async {
    try {
      if (page == null) {
        isLoading.value = 1;
        currentPage.value = 0;
        isEndPage.value = false;
      }
      final products = await apiService.getSearch(
        text: searchedText.value,
        sort: selectedSortName.value,
        filterColorID: selectedFilterColorID.value,
        filterSizeID: selectedFilterSizeID.value,
        page: page,
      );

      if (products.data!.data!.isEmpty) {
        isEndPage.value = true;
        scrollLoading.value = false;
        if (page == null) {
          isLoading.value = 3;
        }
        return;
      }
      if (page == null) {
        productList.value = products.data!.data!;
        productModelApi.value = products;
        isLoading.value = 0;
      } else {
        getProduct(
            productModelApi_: products,
            productList_: products.data!.data!,
            status_: 0);
      }

      currentPage.value = products.data!.currentPage!;
      scrollLoading.value = false;
      if (currentPage.value == products.data!.lastPage!) {
        isEndPage.value = true;
      }
    } catch (e) {
      handleException(e);
      scrollLoading.value = false;
      if (currentPage.value >= 2) {
        globalSnackBar(
            title: "Something went wrong!",
            message: 'Fail reloading more product.\n Please try again letter');
        return;
      }
      isLoading.value = 2;
    }
  }

  ///  Reset all  selected filter data
  void resetAllFilterData() {
    isEndPage.value = false;
    currentPage.value = 0;
    scrollLoading.value = false;

    /// type
    selectedFilterTypeName.value = '';
    selectedFilterTypeIndex.value = 10000;

    ///  size
    selectedFilterSizeID.value = 0;
    selectedSizeName.value = '';
    selectedSizeIndex.value = 10000;

    /// color
    selectedFilterColorID.value = 0;
    selectedFilterColorName.value = '';
    selectedColorIndex.value = 10000;
    isFiltered.value = false;
  }

  void resetSortData() {
    isEndPage.value = false;
    currentPage.value = 0;
    scrollLoading.value = false;
    selectedSortName.value = '';
    selectedSortIndex.value = 10000;
    isSorted.value = false;
  }
}
