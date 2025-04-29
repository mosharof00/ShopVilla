import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:shop_villa/app/modules/my_order/order_details/widgets/orderDetailsContainer.dart';
import 'package:shop_villa/global/cached_network_image_builder.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import 'package:shop_villa/helper/appbar_title.dart';
import 'package:shop_villa/helper/log_printer.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/divider.dart';
import '../../../../global/global_button.dart';
import '../../../../global/methods/get_currency.dart';
import '../../../../global/methods/get_image_url.dart';
import '../../../routes/app_pages.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../cart/widgets/your_order.dart';
import '../../my_order/order_details/widgets/helper_container.dart';
import '../../profile/paymentMethods/controllers/payment_methods_controller.dart';
import '../../promos_vouchers/controllers/promos_vouchers_controller.dart';
import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controllers
    Get.put(CheckoutController());
    final cartController = Get.put(CartController());
    final paymentController = Get.put(PaymentMethodsController());
    final promosController = Get.put(PromosVouchersController());
    final selectedPromos = promosController.selectedPromosID.value != null
        ? promosController.promosList.firstWhereOrNull(
            (promos) => promos.id == promosController.selectedPromosID.value)
        : promosController.promosList.isNotEmpty
            ? promosController.promosList.first
            : null;

    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        title: appbarTitle(text: 'Checkout'),
        centerTitle: true,
        backgroundColor: ColorName.bgColor,
        surfaceTintColor: ColorName.bgColor,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Obx(() {
        if (controller.profileDetails.value.data == null) {
          return Center(
            child: LoadingAnimationWidget.progressiveDots(
                color: ColorName.primaryColor, size: 30),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              controller: controller.scrollController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  10.height,
                  Obx(() {
                    final selectedAddress =
                        controller.addressController.selectedAddressId.value !=
                                null
                            ? controller.addressController.addressList
                                .firstWhereOrNull((address) =>
                                    address.id ==
                                    controller.addressController
                                        .selectedAddressId.value)
                            : null;
                    return orderDetailsContainer(
                      icon: const Icon(
                        Icons.location_on_outlined,
                        color: Colors.green,
                      ),
                      text: 'Delivery Address',
                      isTrailing: true,
                      onTap: () {
                        Get.toNamed(Routes.CHOOSE_DELIVERY_ADDRESS)
                            ?.then((value) {
                          controller.addressController.getAddressList();
                        });
                      },
                      leading: const Icon(
                        Icons.location_on_sharp,
                        color: Colors.white,
                      ),
                      firstTitleTextValue: selectedAddress != null
                          ? '${selectedAddress.label ?? "Select Address".tr}'
                          : "Select Address".tr,
                      firstFontSize: 15.sp,
                      firstFontWeight: FontWeight.w600,
                      secondTitleTextValue: selectedAddress != null
                          ? '${selectedAddress.city}, ${selectedAddress.selectedArea}'
                          : "Select Address".tr,
                      secondFontColor: Colors.black54,
                      secondFontSize: 14.sp,
                      secondFontWeight: FontWeight.normal,
                      subtitleTextValue: selectedAddress != null
                          ? selectedAddress.address ?? "No Address Selected".tr
                          : "No Address Selected".tr,
                    );
                  }),
                  15.height,
                  const YourOrder(
                    viewProducts: true,
                  ),
                  15.height,
                  Obx(() {
                    if (paymentController.isPartialEnabled.value) {
                      return helperContainer(
                        isTrailing: true,
                        showIcon: false,
                        icon: const Icon(
                          Icons.spatial_audio_off_sharp,
                          color: Colors.green,
                        ),
                        text: 'Select Advance Pay',
                        leading: Container(
                          height: 30.h,
                          width: 30.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: controller.isAdvancePaymentCheck.value
                                  ? ColorName.green
                                  : ColorName.gray70,
                            ),
                            color: controller.isAdvancePaymentCheck.value
                                ? ColorName.green
                                : ColorName.gray70,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              // Toggle the value
                              controller.isAdvancePaymentCheck.value =
                                  !controller.isAdvancePaymentCheck.value;

                              Log.i(controller.isAdvancePaymentCheck.value);
                            },
                            child: Center(
                              child: Icon(
                                controller.isAdvancePaymentCheck.value
                                    ? Icons.check
                                    : Icons.check_box_outline_blank,
                                color: controller.isAdvancePaymentCheck.value
                                    ? ColorName.white
                                    : ColorName.gray410,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                        titleText: 'Advance Payment',
                        subtitleText:
                            paymentController.partialPaymentText.string,
                        trailWidget: AppTextStyle(
                          text:
                              '- ${paymentController.partialAmount.value.toString().split('.')[0]}',
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: controller.isAdvancePaymentCheck.value
                              ? ColorName.green
                              : ColorName.gray410,
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
                  15.height,
                  Obx(() {
                    if (controller.deliveryOptionsModel.value.data == null) {
                      return const Center(child: SizedBox.shrink());
                    }
                    final deliveryOptions = controller.getActiveDeliveryOptions(
                        controller.deliveryOptionsModel.value.data!);
                    return Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.transparent),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Header
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                5.width,
                                Icon(
                                  MdiIcons.truckDeliveryOutline,
                                  color: Colors.green,
                                  size: 25,
                                ),
                                10.width,
                                AppTextStyle(
                                  text: 'Delivery Options',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                ),
                              ],
                            ),
                          ),
                          customDivider(),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: deliveryOptions.length,
                            itemBuilder: (context, index) {
                              final option = deliveryOptions[index];
                              return Obx(
                                () => RadioListTile<String>(
                                  title: AppTextStyle(
                                    text: controller.getDeliveryOptionTitle(
                                        option['type']!),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.sp,
                                    textAlign: TextAlign.start,
                                  ),
                                  subtitle: AppTextStyle(
                                    text: 'Duration: ${option['duration']}',
                                    fontWeight: FontWeight.w500,
                                    color: ColorName.gray410,
                                    fontSize: 10.sp,
                                    textAlign: TextAlign.start,
                                  ),
                                  secondary: AppTextStyle(
                                    text:
                                    GetCurrency.concatWithCurrency(
                                        option['fee']!.split('.')[0],
                                        GetCurrency.currencySymbol),
                                    fontWeight: FontWeight.w600,
                                    color: ColorName.black,
                                    fontSize: 13.sp,
                                  ),
                                  activeColor: ColorName.green,
                                  value: option['type']!,
                                  groupValue:
                                      controller.selectedDeliveryOption.value,
                                  onChanged: (value) {
                                    if (value != null) {
                                      controller.selectedDeliveryOption.value =
                                          value;
                                      controller.selectedOption.value =
                                          deliveryOptions.firstWhere((option) =>
                                              option['type'] == value);
                                      Log.w(controller.selectedOption['fee']);
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  }),
                  15.height,
                  Obx(() {
                    return helperContainer(
                      isTrailing: false,
                      showIcon: true,
                      onPressed: () {
                        Get.toNamed(Routes.PAYMENT_METHODS);
                      },
                      icon: Icon(
                        MdiIcons.creditCardOutline,
                        color: Colors.green,
                      ),
                      text: 'Payment Methods',
                      leading: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            GetImageUrl.url(
                              paymentController
                                  .paymentTypeList[paymentController
                                      .paymentSelectIndex.value]
                                  .image!,
                            ),
                          ),
                          radius: 30.r,
                        ),
                      ),
                      titleText: paymentController
                          .paymentTypeList[
                              paymentController.paymentSelectIndex.value]
                          .status!,
                      subtitleText: '',
                    );
                  }),
                  15.height,
                  Obx(() {
                    return helperContainer(
                      isTrailing: true,
                      trailWidget: promosController.isApply.value
                          ? AppTextStyle(
                              text: '-${promosController.disCountAmount.value}',
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: ColorName.green,
                            )
                          : const SizedBox.shrink(),
                      showIcon: true,
                      onPressed: () {
                        Get.toNamed(Routes.PROMOS_VOUCHERS);
                      },
                      icon: Icon(
                        MdiIcons.brightnessPercent,
                        color: Colors.green,
                      ),
                      text: 'Promos & Vouchers',
                      leading: Icon(
                        MdiIcons.brightnessPercent,
                        color: ColorName.green,
                      ),
                      titleText: promosController.isApply.value
                          ? selectedPromos?.code?.toString() ??
                              "Select Promo".tr
                          : 'Select Promo'.tr,
                      subtitleText: promosController.isApply.value
                          ? selectedPromos?.validity
                                  ?.toString()
                                  .split(' ')
                                  .first ??
                              "No Promo Selected"
                          : '',
                    );
                  }),
                  15.height,
                  Container(
                    width: Get.width,
                    padding: EdgeInsets.all(15.r),
                    decoration: BoxDecoration(
                      color: ColorName.white,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            controller.profileDetails.value.data!.image == null
                                ? Icon(
                                    MdiIcons.fileDocumentOutline,
                                    color: Colors.green,
                                  )
                                : cachedImageHelper(
                                    imgurl: controller
                                        .profileDetails.value.data!.image!,
                                    imgWidth: 25.w,
                                    imgHeight: 25.h,
                                    radius: 50.r),
                            10.width,
                            AppTextStyle(
                              text: 'Billing Address',
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                            ),
                          ],
                        ),
                        customDivider(),
                        10.height,
                        summaryOptionsRow(
                          leadingText: 'Name',
                          thrillingText:
                              controller.profileDetails.value.data!.name!,
                          thrillingTextColor: ColorName.gray410,
                        ),
                        5.height,
                        controller.profileDetails.value.data!.email == null
                            ? const SizedBox.shrink()
                            : summaryOptionsRow(
                                leadingText: 'Email',
                                thrillingText: controller
                                    .profileDetails.value.data!.email!,
                                thrillingTextColor: ColorName.gray410,
                              ),
                        5.height,
                        controller.profileDetails.value.data!.phone == null
                            ? const SizedBox.shrink()
                            : summaryOptionsRow(
                                leadingText: 'Phone',
                                thrillingText: controller
                                    .profileDetails.value.data!.phone!,
                                thrillingTextColor: ColorName.gray410,
                              ),
                      ],
                    ),
                  ),
                  15.height,
                  Container(
                    width: Get.width,
                    padding: EdgeInsets.all(15.r),
                    decoration: BoxDecoration(
                      color: ColorName.white,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              MdiIcons.fileDocumentOutline,
                              color: Colors.green,
                            ),
                            10.width,
                            AppTextStyle(
                              text: 'Review Summary',
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                            ),
                          ],
                        ),
                        customDivider(),
                        10.height,
                        summaryOptionsRow(
                          leadingText: '${'Subtotal'.tr} (${cartController.cart.length} ${'item'.tr})',
                          thrillingText: '+ ${GetCurrency.concatWithCurrency(
                              cartController.cartList.value.data!.subTotal.toString().split('.')[0],
                              GetCurrency.currencySymbol)}',
                        ),
                        5.height,
                        Obx(() {
                          final selectedAddress = controller.addressController.selectedAddressId.value != null
                              ? controller.addressController.addressList.firstWhereOrNull(
                                  (address) => address.id == controller.addressController.selectedAddressId.value)
                              : null;

                          return Column(
                            children: [
                              buildDeliveryChargeRow(context, cartController),
                              5.height,
                              controller.isAdvancePaymentCheck.value
                                  ? summaryOptionsRow(
                                leadingText: 'Advance Payment',
                                thrillingText: '- ${GetCurrency.concatWithCurrency(
                                    paymentController.partialAmount.value.toString().split('.')[0],
                                    GetCurrency.currencySymbol)}',
                              )
                                  : const SizedBox.shrink(),
                              5.height,
                              promosController.isApply.value
                                  ? summaryOptionsRow(
                                  leadingText: 'Promos',
                                  thrillingText: '- ${GetCurrency.concatWithCurrency(
                                      promosController.disCountAmount.value.toString(),
                                      GetCurrency.currencySymbol)}')
                                  : const SizedBox.shrink(),
                              5.height,
                              customDivider(paddingHorizontal: 0),
                              5.height,
                              buildTotalRow(cartController, paymentController, promosController),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                  20.height,
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: globalButton(
                      text: 'Confirm Order',
                      onTap: () {
                        final selectedAddress = controller
                            .addressController.selectedAddressId.value !=
                            null
                            ? controller.addressController.addressList.firstWhereOrNull((address) =>
                        address.id == controller.addressController.selectedAddressId.value)
                            : null;
                        final addressDeliveryCharge = num.tryParse(
                            selectedAddress?.deliveryCharge?.replaceAll(',', '') ?? '0') ??
                            0;
                        final selectedOptionFee = num.tryParse(
                            controller.selectedOption['fee']?.replaceAll(',', '') ?? '0') ??
                            0;
                        final totalDeliveryCharge = addressDeliveryCharge + selectedOptionFee;
                        // Check if free shipping threshold is met
                        final deliveryCharge = meetsFreeSippingThreshold(cartController)
                            ? 0
                            : totalDeliveryCharge;
                        controller.handlePaymentTap(deliveryCharge: deliveryCharge.toString());
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }),
      bottomNavigationBar: SizedBox(
        height: 50.h,
        width: Get.width - 20.w,
        child: Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5.h),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: ColorName.white,
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: Column(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  5.height,
                  Obx(() {
                    int shippingThreshold = int.parse(controller
                        .freeShippingCharge.value
                        .toString()
                        .replaceAll(',', '')
                        .split('.')[0]);
                    int currentCartTotal = int.parse(cartController
                        .cartList.value.data!.subTotal!
                        .toString()
                        .replaceAll(',', '')
                        .split('.')[0]);
                    int remainingAmount = shippingThreshold - currentCartTotal;
                    return AppTextStyle(
                      text: remainingAmount >= 0
                          ? 'Add more ${GetCurrency.concatWithCurrency(
                          remainingAmount.toString(),
                          GetCurrency.currencySymbol)} for Free Delivery Charge'
                          : '🎉 Yeah! You got Free Delivery Charge!',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.start,
                      color: Colors.green,
                    );
                  }),
                  SizedBox(
                    height: 20,
                    width: Get.width - 40.w,
                    child: FloatingActionButton(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      onPressed: () {
                        // Your action here
                      },
                      child: Obx(
                        () => LinearProgressIndicator(
                          minHeight: 6.h,
                          valueColor: const AlwaysStoppedAnimation<Color>(ColorName.green),
                          borderRadius: BorderRadius.circular(15.r),
                          value: controller.calculateShippingProgressPercentage(
                              cartController.cartList.value.data!.subTotal!),
                          backgroundColor: ColorName.gray70,
                          color: ColorName.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDeliveryChargeRow(
      BuildContext context, CartController cartController) {
    final selectedAddress = controller
                .addressController.selectedAddressId.value !=
            null
        ? controller.addressController.addressList.firstWhereOrNull((address) =>
            address.id == controller.addressController.selectedAddressId.value)
        : null;
    return summaryOptionsRow(
      leadingText: 'Delivery',
      thrillingText: calculateDeliveryChargeText(selectedAddress, cartController),
    );
  }

  bool meetsFreeSippingThreshold(CartController cartController) {
    final subtotal = num.parse(cartController.cartList.value.data!.subTotal
        .toString()
        .replaceAll(',', ''));
    final freeShippingThreshold = num.parse(
        controller.freeShippingCharge.value.toString().replaceAll(',', ''));
    return subtotal >= freeShippingThreshold;
  }

  String calculateDeliveryChargeText(dynamic selectedAddress, CartController cartController) {
    if (controller.selectedOption['type'] == 'pickup') return 'Free';
    final addressDeliveryCharge = num.tryParse(
            selectedAddress?.deliveryCharge?.replaceAll(',', '') ?? '0') ??
        0;
    final selectedOptionFee = num.tryParse(
            controller.selectedOption['fee']?.replaceAll(',', '') ?? '0') ??
        0;
    final totalDeliveryCharge = addressDeliveryCharge + selectedOptionFee;
    return meetsFreeSippingThreshold(cartController)
        ? 'Free'
        : '+ ${GetCurrency.concatWithCurrency(
        totalDeliveryCharge.toInt().toString(),
        GetCurrency.currencySymbol)}';
  }

  Widget buildTotalRow(
      CartController cartController,
      PaymentMethodsController paymentController,
      PromosVouchersController promosController) {
    final selectedAddress = controller
                .addressController.selectedAddressId.value !=
            null
        ? controller.addressController.addressList.firstWhereOrNull((address) =>
            address.id == controller.addressController.selectedAddressId.value)
        : null;

    return summaryOptionsRow(
      leadingText: 'Total',
      thrillingText: calculateTotalText(
          selectedAddress, cartController, paymentController, promosController),
      fontSizeThrillingText: 18.sp,
      fontWeightThrillingText: FontWeight.w600,
    );
  }

  String calculateTotalText(
      dynamic selectedAddress,
      CartController cartController,
      PaymentMethodsController paymentController,
      PromosVouchersController promosController) {
    final subTotal = parseNumericValue(
        cartController.cartList.value.data!.subTotal.toString());

    final deliveryCharge = calculateDeliveryCharge(selectedAddress);
    final promos = getPromoDiscount(promosController);

    final total = controller.getTotal(
      subTotal: subTotal,
      advancePayment: controller.isAdvancePaymentCheck.value
          ? (num.tryParse(paymentController.partialAmount.value.toString()) ??
              0)
          : 0, // Pass 0 or appropriate default if advancePayment isn't used
      deliveryCharge:
          meetsFreeSippingThreshold(cartController) ? 0 : deliveryCharge,
      promos: promos,
    );
    return GetCurrency.concatWithCurrency(
      total.toString(),
      GetCurrency.currencySymbol,
    );
  }

  num parseNumericValue(String value) {
    return num.parse(value.replaceAll(',', ''));
  }

  num getAdvancePayment(PaymentMethodsController paymentController) {
    return controller.isAdvancePaymentCheck.value
        ? num.tryParse(paymentController.partialAmount.value.toString()) ?? 0
        : 0;
  }

  num calculateDeliveryCharge(dynamic selectedAddress) {
    if (controller.selectedOption['type'] == 'pickup') return 0;

    final addressDeliveryCharge = num.tryParse(
            selectedAddress?.deliveryCharge?.replaceAll(',', '') ?? '0') ??
        0;
    final selectedOptionFee = num.tryParse(
            controller.selectedOption['fee']?.replaceAll(',', '') ?? '0') ??
        0;
    return addressDeliveryCharge + selectedOptionFee;
  }

  num getPromoDiscount(PromosVouchersController promosController) {
    return promosController.isApply.value
        ? num.tryParse(promosController.disCountAmount.value.toString()) ?? 0
        : 0;
  }
}
