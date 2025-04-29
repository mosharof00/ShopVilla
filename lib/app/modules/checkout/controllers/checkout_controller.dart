import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_villa/app/models/delivery_options/get_delivery_options.dart';
import 'package:shop_villa/app/modules/home/controllers/home_controller.dart';
import 'package:shop_villa/global/global_snackbar.dart';
import 'package:shop_villa/helper/helper_utils.dart';
import 'package:shop_villa/helper/log_printer.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../helper/exception_handle.dart';
import '../../../models/order place/order_list_post_model.dart';
import '../../../models/profile/profile_get_model.dart';
import '../../../repository/api_services.dart';
import '../../choose_delivery_address/controllers/choose_delivery_address_controller.dart';
import '../../profile/paymentMethods/controllers/payment_methods_controller.dart';
import '../widgets/webview.dart';

class CheckoutController extends GetxController {
  final isAdvancePaymentCheck = false.obs;
  var totalValue = 0;
  ScrollController scrollController = ScrollController();
  final isAddressValid = false.obs;
  final addressController = Get.put(ChooseDeliveryAddressController());
  final deliveryOptionsModel = DeliveryOptionsModel().obs;
  RxString selectedDeliveryOption = RxString('');
  RxMap<String, String> selectedOption = RxMap<String, String>();
  /// Observable to store the profile details retrieved from the API
  final profileDetails = ProfileGetModel().obs;
  /// Api Service
  final apiService = Get.put(ApiServices());
  final payType = 'cash_on_delivery'.obs;
  final freeShippingCharge = '0'.obs;
  final freeShippingStatus = ''.obs;
  // Make it observable if you want to track changes
  RxDouble shippingProgressPercentage = 0.0.obs;

  /// Order Place
  final isDone = false.obs;
  final confirmOrder = ConfirmOrder().obs;
  final ordersList = OrderListPostModel().obs;
  // Method to place an order with the given shipping address and payment type

  // Calculate the total value of the order including subtotal, delivery charge, and promos
  num getTotal({
    required num subTotal,
    required num deliveryCharge,
    required num promos,
    required num advancePayment,
  }) {
    return (subTotal - advancePayment + deliveryCharge - promos).toInt();
  }

  /// Handle payment tap
  final isLoading = true.obs;
  Future<void> handlePaymentTap({required String deliveryCharge}) async {

    if (validateAddress()) {
      final PaymentMethodsController paymentMethodsController = Get.find();
      await orderList(
        shippingAddressId: addressController.selectedAddressId.value.toString(),
        isAdvancePayment: isAdvancePaymentCheck.value ? '1' : '0',
        paymentType: paymentMethodsController
            .paymentTypeList[paymentMethodsController.paymentSelectIndex.value]
            .value!,
        deliveryCharge: deliveryCharge,
      );
    } else {
      scrollToTop();
    }
  }

  /// Order Place
  Future<void> orderList({
    required String shippingAddressId,
    required String paymentType,
    required String isAdvancePayment,
    required String deliveryCharge,
  }) async {
    try {
      isDone.value = false;
      final orderList = await apiService.orderList(
          shippingAddressId, paymentType, isAdvancePayment, deliveryCharge);
      if (orderList.status!) {
        Get.put(HomeController()).fetchDashboardUserCount();
        if (orderList.data != null) {
          confirmOrder.value = orderList.data!;
          String paymentUrl = confirmOrder.value.redirectUrl!;
          Log.w(paymentUrl);
          Get.to(() => PaymentWebViewScreen(url: paymentUrl));
        } else {
          HelperUtils.navigateToOrder();
        }
      } else {
        globalSnackBar(
            title: 'Order Place',
            message: orderList.message!,
            durationInSeconds: 2);
      }
    } catch (e) {
      handleException(e);
    }
  }

  /// Deliver Options
  Future<void> getDeliveryOptions() async {
    try{
      final response = await apiService.getDeliveryOptions();
      deliveryOptionsModel.value = response;
      freeShippingStatus.value = response.data!.freeShippingStatus!;
      freeShippingCharge.value = response.data!.freeShippingFee!;
    }catch(e){
      handleException(e);
    }
  }

  // New method to calculate progress percentage
  double calculateShippingProgressPercentage(String subTotal) {
    try {
      // Remove commas from the values
      double shippingThreshold = double.parse(
          freeShippingCharge.value.toString().replaceAll(',', '').split('.')[0]
      );
      double currentCartTotal = double.parse(
          subTotal.toString().replaceAll(',', '').split('.')[0]
      );
      double progress = currentCartTotal / shippingThreshold;
      return progress > 1.0 ? 1.0 : progress;
    } catch (e) {
      Log.e('Error calculating shipping progress: $e');
      return 0.0;
    }
  }

  // Show loading dialog
  void showLoadingDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: ColorName.gray70,
        elevation: 3,
        title: LoadingAnimationWidget.inkDrop(
          size: 40,
          color: ColorName.primaryColor,
        ),
        content: AppTextStyle(
          text: 'Processing Payments...',
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      barrierDismissible: true,
    );
  }

  //Close Dialog
  void closeLoadingDialogIfOpen() {
    if (Get.isDialogOpen!) {
      Get.back(); // Close the dialog if it's still open
    }
  }

  // Scroll to the top of the page
  void scrollToTop() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  // Validate if the address is selected
  bool validateAddress() {
    if (addressController.selectedAddressId.value == null ||
        addressController.addressList.isEmpty) {
      return false;
    }
    return true;
  }

  // Update address validation state
  void updateAddressValidation() {
    isAddressValid.value = validateAddress();
  }

  // Helper method to get active delivery options
  List<Map<String, String>> getActiveDeliveryOptions(DeliveryOptions data) {
    final options = <Map<String, String>>[];
    if (data.normalDeliveryStatus == '1') {
      options.add({
        'type': 'normal',
        'duration': data.normalDeliveryDuration ?? 'N/A',
        'fee': data.normalDeliveryFee ?? '0.00',
      });
    }
    if (data.expressDeliveryStatus == '1') {
      options.add({
        'type': 'express',
        'duration': data.expressDeliveryDuration ?? 'N/A',
        'fee': data.expressDeliveryFee ?? '0.00',
      });
    }
    if (data.pickUpOurPlaceStatus == '1') {
      options.add({
        'type': 'pickup',
        'duration': data.pickUpOurPlaceDuration ?? 'N/A',
        'fee': data.pickUpOurPlaceFee ?? '0.00',
      });
    }
    return options;
  }

  // Helper method to get readable delivery option titles
  String getDeliveryOptionTitle(String type) {
    switch (type) {
      case 'normal':
        return 'Normal Delivery';
      case 'express':
        return 'Express Delivery';
      case 'pickup':
        return 'Pick Up Our Place';
      default:
        return 'Unknown Delivery Option';
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
    getDeliveryOptions();
    getProfileDetails();
    ever(deliveryOptionsModel, (model) {
      if (model.data != null) {
        final deliveryOptions = getActiveDeliveryOptions(model.data!);
        if (deliveryOptions.isNotEmpty) {
          selectedDeliveryOption.value = deliveryOptions.first['type']!;
          selectedOption.value = deliveryOptions.first;
        }
      }
    });
    super.onInit();
    addressController.selectedAddressId.listen((addressId) {
      updateAddressValidation();
    });
  }
}
