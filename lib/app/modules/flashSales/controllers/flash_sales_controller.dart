import 'package:get/get.dart';
import '../../../../global/global_snackbar.dart';
import '../../../../helper/exception_handle.dart';
import '../../../repository/api_services.dart';

class FlashSalesController extends GetxController {
  final apiService = Get.put(ApiServices());
  final appBarTitle = 'Flash Sales'.obs;
  final flashSalesList = [].obs;
  final isFlashSalesLoading = 100
      .obs; //  0 = successfully get product,  1= loading , 2= error , 3 = the specific keyword value not found
  final flashSaleCurrentPage = 0.obs;
  final isFlashSaleEndPage = false.obs;
  final isFlashSaleScrollLoading = false.obs;
  final selectedFilterTypeName = ''.obs;

  ///  Flash Sales  products
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
        flashSaleCurrentPage.value = 0;
        isFlashSaleEndPage.value = false;
      }
      final products = await apiService.getProduct(
        sort: sort,
        filterType: selectedFilterTypeName.value,
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

}
