import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/repository/api_services.dart';
import 'package:shop_villa/helper/exception_handle.dart';
import '../../../../models/order place/re_order_model.dart';
import '../../../../models/order place/user_orderlist_post_model.dart';
import '../../../../models/profile/profile_get_model.dart';
import '../../../checkout/widgets/webview.dart';
import '../../../profile/paymentMethods/controllers/payment_methods_controller.dart';

class OrderDetailsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final RxInt selectedTabIndex = 0.obs; // Tab selected Index
  final isSelect = false.obs;
  late TabController tabController;
  late MyOrder myOrder;
  final profileDetails = ProfileGetModel().obs;
  late RxInt sum = 0.obs;
  // Calculate Total Sum
  int totalSum(String subTotal, String shippingChrg, String promos) {
    sum.value = int.parse(subTotal) + int.parse(shippingChrg) - int.parse(promos);
    return sum.value;
  }
  /// Payment Method
  final paymentController = Get.put(PaymentMethodsController());
  final gateway = ''.obs;
  final image = ''.obs;
  void getPaymentMethod(String method) {
    for (var paymentMethod in paymentController.paymentTypeList) {
      if (paymentMethod.value == method) {
        gateway.value = paymentMethod.status ?? 'Cash On Delivery';
        image.value = paymentMethod.image ?? 'Unknown';
        return;
      }
    }
    gateway.value = 'Cash On Delivery';
    image.value = 'public/backend/images/payment/sslcommerz.png'; // Default image URL
  }

  /// Re-Order
  // Handle re-order API call and navigate to payment
  final apiService = ApiServices();
  final reOrderData = ReOrder().obs;
  Future<void> reOrder({required String invoiceID, required String paymentMethod}) async {
    try{
      final response = await apiService.reOrder(invoiceID, paymentMethod);
      if (response.data != null) {
        reOrderData.value = response.data!;
        String paymentUrl = reOrderData.value.redirectUrl!;
        Get.to(() => PaymentWebViewScreen(url: paymentUrl));
      } else {
        Get.snackbar('Re Order', 'Sorry there has some problem');
      }
    }catch(e){
      handleException(e);
    }
  }

  /// Fetches profile details from the API
  Future<void> getProfileDetails() async {
    try {
      final profile = await apiService.profileDetails();
      profileDetails.value = profile;
    } catch (e) {
      handleException(e);
    }
  }

  @override
  void onInit() {
    getProfileDetails();
    super.onInit();
    final args = Get.arguments; //From Active Order // Get arguments from previous screen
    myOrder = args['arg1'];  // Extract order details

    tabController = TabController(
      length: 2,
      vsync: this,
    );
    tabController.addListener(() {
      selectedTabIndex.value = tabController.index;
    });
  }
  // Update selected tab and animate to it
  void updateSelectedTab(int index) {
    selectedTabIndex.value = index;
    tabController.animateTo(index);
  }
  // Dispose TabController on close
  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
