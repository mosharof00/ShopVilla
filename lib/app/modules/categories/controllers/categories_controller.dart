import 'package:get/get.dart';
import '../../../../helper/exception_handle.dart';
import '../../../repository/api_services.dart';

class CategoriesController extends GetxController {
  //TODO: Implement CategoriesController
  final ApiServices apiService = ApiServices();
  final subCategoryList = [].obs;
  final selectedCategoryId = 1.obs;
  final selectedSubCategoryId = 0.obs;
  final isSubCategoryLoading = 100.obs;
  final index = 0.obs;
  RxInt selectedIndex = 0.obs;

  /// Fetch SubCategory Product
  Future<void> fetchSubCategories({required int categoryId}) async {
    try {
      isSubCategoryLoading.value = 1;
      final response =
          await apiService.getSubCategory(categoryId: selectedCategoryId.value);
      subCategoryList.value = response.data!;
      isSubCategoryLoading.value = 0;
    } catch (e) {
      handleException(e);
      isSubCategoryLoading.value = 2;
    }
  }
}
