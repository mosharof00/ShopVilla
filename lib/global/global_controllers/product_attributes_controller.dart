import 'package:get/get.dart';
import '../../app/models/product_attribute/product_attribute_model.dart';
import '../../app/repository/api_services.dart';
import '../../helper/exception_handle.dart';
import '../global_snackbar.dart';

class ProductAttributesController extends GetxController {
  final ApiServices apiService = ApiServices();
  final productAttributeModel = ProductAttributeModel().obs;
  final colorList = <Attribute>[].obs;
  final sizeList = <Attribute>[].obs;
  final weightList = <Attribute>[].obs;
  final productMakerCode = <Attribute>[].obs;

  /// Fetch Product Attribute
  Future<void> fetchProductAttribute() async {
    try {
      final response = await apiService.getProductAttribute();
      productAttributeModel.value = response;
      filterColorData();
      filterSizeData();
      filterWeightData();
      filterProductMakerCodeData();
    } catch (e) {
      handleException(e);
      globalSnackBar(title: "Error", message: e.toString());
    }
  }

  void filterColorData() {
    colorList.clear();
    productAttributeModel.value.data!.attributes!.where((attribute) {
      return attribute.attributeNameId == 1;
    }).forEach((attribute) {
      if (attribute.name != 'No Color') {
        colorList.add(attribute);
      }
    });
  }

  void filterSizeData() {
    // sizeList.value = productAttributeModel.value.data!.attributes!
    //     .where((attribute) => attribute.attributeNameId == 2)
    //     .toList();
    // Clear the existing list
    sizeList.clear();
    productAttributeModel.value.data!.attributes!.where((attribute) {
      return attribute.attributeNameId == 2;
    }).forEach((attribute) {
      if (attribute.name != 'No Size') {
        sizeList.add(attribute);
      }
    });
  }

  void filterWeightData() {
    weightList.value = productAttributeModel.value.data!.attributes!
        .where((attribute) => attribute.attributeNameId == 3)
        .toList();
  }

  void filterProductMakerCodeData() {
    productMakerCode.value = productAttributeModel.value.data!.attributes!
        .where((attribute) => attribute.attributeNameId == 4)
        .toList();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    fetchProductAttribute();
    super.onInit();
  }
}
