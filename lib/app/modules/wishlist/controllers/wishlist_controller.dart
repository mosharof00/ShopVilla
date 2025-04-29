import 'package:get/get.dart';
import 'package:shop_villa/app/models/wishlist_model/wish_list_model.dart';
import 'package:shop_villa/app/modules/home/controllers/home_controller.dart';
import 'package:shop_villa/app/repository/api_services.dart';
import 'package:shop_villa/helper/exception_handle.dart';
import 'package:shop_villa/helper/log_printer.dart';

import '../../../../global/global_snackbar.dart';

class WishlistController extends GetxController {
  //TODO: Implement WishlistController
  final apiService = ApiServices();
  HomeController homeController = Get.put(HomeController());
  final isLoading = false.obs;

  /// Fetch Wishlist
  void fetchWishlist() async {
    try {
      isLoading.value = true;
      final response = await apiService.getWishlist();
      if (response.data == null || response.data!.isEmpty) {
      } else {
        homeController.wishlist.clear();
        homeController.wishListedProductId.clear();
        for (int i = 0; i < response.data!.length; i++) {
          if (!homeController.wishListedProductId
              .contains(response.data![i].productId)) {
            homeController.wishListedProductId
                .add(response.data![i].productId!);
            homeController.wishlist.add(response.data![i]);
          }
        }
      }
      isLoading.value = false;
    } catch (e) {
      handleException(e);
      Log.e(e);
      isLoading.value = false;
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
      final String message = response.message.toString();
      if (response.status == true) {
        homeController.wishListedProductId.add(productId);
        globalSnackBar(title: 'Added to wishlist', message: message.toString());
      }
      // fetchWishlist();
    } catch (e) {
      handleException(e);
    }
  }

  ///   Remove to wishlist
  Future<void> removeToWishlist({required int productId}) async {
    try {
      final response = await apiService.removeToWishlist(productId);
      final String message = response.message.toString();
      if (response.status == true) {
        homeController.wishListedProductId.remove(productId);
        globalSnackBar(
            title: 'Remove to wishlist', message: message.toString());
      }
      for (int i = 0; i <= homeController.wishlist.length; i++) {
        final WishListData wishList = homeController.wishlist[i];
        if (wishList.productId == productId) {
          homeController.wishlist.remove(wishList);
          return;
        }
      }
    } catch (e) {
      handleException(e);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    fetchWishlist();
    super.onInit();
  }
}
