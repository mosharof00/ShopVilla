import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/modules/categories/views/categories_view.dart';
import 'package:shop_villa/app/modules/my_order/views/my_order_view.dart';
import 'package:shop_villa/app/modules/products/views/products_view.dart';
import 'package:shop_villa/app/modules/profile/views/profile_view.dart';
import '../../../../global/awesome_dialog_login.dart';
import '../../../../helper/helper_utils.dart';
import '../../../routes/app_pages.dart';
import '../../categories/controllers/categories_controller.dart';
import '../../home/views/home_view.dart';
import '../../my_order/controllers/my_order_controller.dart';
import '../../products/controllers/products_controller.dart';

class MainPageController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final userName = "User".obs;
  final userEmail = "User@gmail.com".obs;
  final count = 0.obs;
  final selectedTab = 0.obs;

  List pageList = [
    const HomeView(),
    const CategoriesView(),
    const ProductsView(),
    const MyOrderView(),
    const ProfileView(),
  ];

  @override
  onInit() {
    final args = Get.arguments;
    if (args != null && args['index'] != null) {
      changeTab(int.parse(args['index'].toString()));
    }
    super.onInit();
  }

  changeTab(int index) {
    if (index == 0) {
      selectedTab.value = index;
      return;
    } else if (index == 1) {
      final CategoriesController categoriesController =
          Get.put(CategoriesController());
      categoriesController.fetchSubCategories(
          categoryId: categoriesController.selectedCategoryId.value);
      selectedTab.value = index;
      return;
    } else if (index == 2) {
      final ProductsController productsController =
          Get.put(ProductsController());
      productsController.appBarTitle.value = "All Products";
      productsController.isLoading.value = 0;
      productsController.fetchProducts(page: null);
      selectedTab.value = index;
      return;
    } else if (index == 3) {
      if (HelperUtils.isLogin) {
        Get.put(MyOrderController());
        selectedTab.value = index;
        return;
      } else {
        DialogUtils.showWarningDialog(
          dismissOnBackKeyPress: false,
          dismissOnTouchOutside: true,
          context: Get.context!,
          title: 'You are Unauthenticated',
          description: 'Please Log In',
          onOkPressed: () {
            Get.toNamed(Routes.LOGIN);
          },
        );
        return;
      }
    } else {
      if (HelperUtils.isLogin) {
        selectedTab.value = index;
        return;
      } else {
        DialogUtils.showWarningDialog(
          dismissOnBackKeyPress: false,
          dismissOnTouchOutside: true,
          context: Get.context!,
          title: 'You are Unauthenticated',
          description: 'Please Log In',
          onOkPressed: () {
            Get.toNamed(Routes.LOGIN);
          },
        );
        return;
      }
    }
  }
}
