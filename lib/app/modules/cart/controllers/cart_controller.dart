import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_add_to_cart_button/flutter_add_to_cart_button.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/modules/home/controllers/home_controller.dart';
import 'package:shop_villa/helper/helper_utils.dart';
import '../../../../global/awesome_alert_dialog.dart';
import '../../../../global/global_snackbar.dart';
import '../../../../helper/exception_handle.dart';
import '../../../models/cart/cart_get_model.dart';
import '../../../models/product_details/product_details_model.dart';
import '../../../repository/api_services.dart';
import '../../../routes/app_pages.dart';

class CartController extends GetxController {
  // Add to Cart Button
  AddToCartButtonStateId stateId = AddToCartButtonStateId.idle;
  // Add to Cart Button - Update State
  void updateStateId(AddToCartButtonStateId newStateId) {
    stateId = newStateId;
    update();
  }

  /// Cart Model
  final apiService = Get.put(ApiServices());
  final cartList = CartGetModel().obs;
  final cart = <Cart>[].obs;
  final isCartLoading = false.obs;

  Future<bool> getCart() async {
    try {
      isCartLoading.value = true;
      final carts = await apiService.getCart(); // Fetch Cart List
      cartList.value = carts;
      cart.value = carts.data!.carts!;
      isCartLoading.value = false;
      Get.find<HomeController>().totalCartedCount.value =
          carts.data!.carts!.length;
      return cart.isNotEmpty ? true : false;
    } catch (e) {
      handleException(e); // Handle Exception
      isCartLoading.value = false;
      return false;
    }
  }

  //Add-To-Cart Post
  final isCarted = false.obs;
  var addToCartStateId = AddToCartButtonStateId.idle.obs;
  Future<void> postCart({
    required int productID,
    required int varientID,
    required int qty,
    required int sizeID,
  }) async {
    try {
      /// Dont Remove the commented Codes
      // addToCartStateId.value = AddToCartButtonStateId.loading; // Set the button to loading state
      final addToCart = await apiService.postCart(
          productID, varientID, qty, sizeID); // Post Add to Cart
      // isCarted.value = true;
      // addToCartStateId.value = AddToCartButtonStateId.done; // Once done, set the button to idle or done state
      await getCart(); // Call the Cart List
      // awesomeAlertDialog(
      //   Get.context!,
      //   DialogType.success,
      //   addToCart.title.toString(),
      //   'Want to Continue Shopping',
      //   'Go to Cart',
      //       () {
      //     Get.toNamed(Routes.CART);
      //   },
      //   'Continue',
      //       () {},
      //   false,
      // );
      // Future.delayed(const Duration(seconds: 2), () {
      //   addToCartStateId.value = AddToCartButtonStateId.idle;
      // });// After a short delay, reset the button to idle state
    } catch (e) {
      // isCarted.value = false;
      // On error, reset the button state and handle the exception
      // addToCartStateId.value = AddToCartButtonStateId.idle;
      handleException(e);
    }
  }
  // Future<void> postCart({
  //   required int productID,
  //   required int varientID,
  //   required int qty,
  //   required int sizeID,
  // }) async {
  //   try {
  //     final addToCart = await apiService.postCart(
  //         productID, varientID, qty, sizeID); // Post Add to Cart
  //     isCarted.value = true;
  //     // final String message = addToCart.title.toString();
  //     // globalSnackBar(title: 'Added to Cart', message: message.toString());
  //     getCart(); // Call the Cart List
  //   } catch (e) {
  //     isCarted.value = false;
  //     handleException(e);
  //   }
  // }

  // Update Cart
  final isUpdated = false.obs;
  Future<void> updateCart(
      {required int productID,
      required int qty,
      required int varientID,
      required int sizeID}) async {
    try {
      isUpdated.value = false;
      final updateCart = await apiService.updateCart(
          productID, qty, varientID, sizeID); // Update the cart
      final message = updateCart.title!;
      isUpdated.value = true;
      getCart(); // call the cart list
      globalSnackBar(title: 'Product Cart Updated', message: message);
    } catch (e) {
      isUpdated.value = false;
      globalSnackBar(title: 'Warning!', message: 'Cart not Updated!');
      handleException(e);
    }
  }

  // Remove-cart
  Future<void> removeCart({required int id}) async {
    try {
      final removeCart =
          await apiService.removeCart(id); // Remove cart by product ID
      final String message = removeCart.title.toString();
      globalSnackBar(title: 'Remove', message: message.toString());
      getCart();
    } catch (e) {
      handleException(e);
    }
  }

  /// Cart Update BottomSheet
  /// When the user click on Update icon it gets the product Id and run quick scan for product details then it showed to the bottomsheet.
  final product = ProductDetailsModel().obs;
  final isLoading = false.obs; // RxBool to keep track of loading state
  int? _productID;
  int? get productID => _productID;
  set productID(int? value) {
    _productID = value;
    if (_productID != null) {
      getProductDetails();
    }
  }
  void getProductDetails() async {
    isLoading.value = true; // Set loading state to true
    try {
      final productDetails = await apiService.getProductDetails(_productID!);
      product.value = productDetails;
    } catch (e) {
      debugPrint("Product Details error: ${e.toString()}");
      handleException(e);
    } finally {
      isLoading.value = false; // Set loading state to false
    }
  }

  @override
  void onInit() {
    if (HelperUtils.isLogin) {
      getCart();
    }
    super.onInit();
  }
}
