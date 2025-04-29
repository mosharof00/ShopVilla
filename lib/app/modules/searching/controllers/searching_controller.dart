import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:shop_villa/app/repository/api_services.dart';

import '../../../routes/app_pages.dart';
import '../../products/controllers/products_controller.dart';

class SearchingController extends GetxController {
  //TODO: Implement SearchingController
  final ApiServices apiServices = ApiServices();
  final textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final searchHistoryList = <String>[].obs;
  final productList = [].obs;
  final currentIndex = 0.obs;

  ///   fetch product
  void fetchProduct() {
    final productsController = Get.put(ProductsController());
    addToSearchHistoryList(textEditingController.text.toString());
    productsController.getSearch(textEditingController.text);
    Get.toNamed(Routes.PRODUCTS);
  }

  ///   add text into a list
  void addToSearchHistoryList(text) {
    if (text.isNotEmpty) {
      if (searchHistoryList.contains(text)) {
        searchHistoryList.remove(text);
      }
      searchHistoryList.insert(0, text);
      if (searchHistoryList.length > 10) {
        searchHistoryList.removeLast();
      }
      var box = Hive.box<List<String>>('recentSearchedTexts');
      box.put('texts', searchHistoryList.toList()); // Save the list to Hive
    }
  }

  ///   Initialize and  get search history from local hive store
  Future<void> getHistoryFromLocalHiveStore() async {
    var box = await Hive.openBox<List<String>>('recentSearchedTexts');
    var storedTexts = box.get('texts') ?? <String>[];
    searchHistoryList.assignAll(storedTexts);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getHistoryFromLocalHiveStore();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   FocusScope.of(Get.context!).requestFocus(focusNode);
    // });
    super.onInit();
  }

  @override
  void onClose() {
    textEditingController.dispose();
    focusNode.dispose();
    super.onClose();
  }
}