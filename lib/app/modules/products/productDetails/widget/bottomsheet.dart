import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/modules/products/productDetails/widget/product_qty.dart';
import 'package:shop_villa/gen/colors.gen.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import '../../../../../global/app_text_style.dart';
import '../../../../../global/app_text_style_over_flow.dart';
import '../../../../../global/cached_network_image_builder.dart';
import '../../../../../global/global_button.dart';
import '../../../../../global/methods/get_currency.dart';
import '../../../../../helper/log_printer.dart';
import '../../../../../helper/select_color.dart';
import '../../../../../helper/select_variation.dart';
import '../../../../models/product_details/product_details_model.dart';
import '../../../cart/controllers/cart_controller.dart';
import '../controllers/product_details_controller.dart';

Future buyBottomSheet({
  required BuildContext context,
  required ProductDetailsData product,
  bool? isCart,
  int? qty,
}) {
  final productDetailsController = Get.find<ProductDetailsController>();
  final cartController = Get.put(CartController());
  productDetailsController.productQty.value = qty ?? 1;

  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: ColorName.white,
    useSafeArea: true,
    builder: (BuildContext context) {
      return SizedBox(
        width: Get.width,
        child: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              5.height,
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 2.h,
                  width: 35.w,
                  color: Colors.grey.shade300,
                ),
              ),
              10.height,
              Align(
                alignment: Alignment.topCenter,
                child: AppTextStyle(
                  text: 'Edit Product Variant',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              10.height,
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 1.h,
                  width: Get.width,
                  color: Colors.grey.shade300,
                ),
              ),
              8.height,
              Obx(() {
                return Row(
                  children: [
                    cachedImageHelper(
                        imgurl: product
                            .productvariations![
                        productDetailsController.colorSelectedIndex.value]
                            .image!,
                        imgWidth: 110.w,
                        imgHeight: 125.h,
                        radius: 30.r),
                    10.width,
                    Expanded(
                      flex: 1,
                      child: Obx(() {
                        final selectedSize = productDetailsController
                            .selectedVarientIndex.sizes!
                            .firstWhere(
                              (size) =>
                          size.id ==
                              productDetailsController.selectedSizeID.value,
                          orElse: () {
                            Log.i(
                                'No matching size found for selectedSizeID: ${productDetailsController
                                    .selectedSizeID.value}');
                            return productDetailsController
                                .selectedVarientIndex
                                .sizes!
                                .first; // Return a default or first size as fallback
                          },
                        );

                        final sizeName = product.sizes!.firstWhere(
                              (size) => size.id == selectedSize.id,
                          orElse: () {
                            return product.sizes!
                                .first; // Return a default or first size as fallback
                          },
                        ).size ??
                            'N/A';

                        final selectedVariation =
                            productDetailsController.selectedVarientIndex;
                        final colorName = selectedVariation.color ?? 'N/A';
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextStyleOverFlow(
                              text: product.productName ?? '',
                              maxLines: 2,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.sp,
                            ),
                            5.height,
                            sizeName != 'No Size'
                                ? AppTextStyle(
                              text: '${'Size'.tr} : $sizeName',
                              fontSize: 12.sp,
                            )
                                : const SizedBox.shrink(),
                            5.height,
                            AppTextStyle(
                              text: '${'Color'.tr} : $colorName',
                              fontSize: 12.sp,
                            ),
                            5.height,
                            Row(
                              children: [
                                AppTextStyle(
                                  text: '${'Quantity'.tr} :',
                                  fontSize: 12.sp,
                                ),
                                5.width,
                                ProductQty(
                                  stock: product.totalStock!,
                                  qty: qty,
                                  buttonHeight: 20.h,
                                  buttonWidth: 20.w,
                                ),
                              ],
                            ),
                            5.height,
                            Row(
                              children: [
                                AppTextStyle(
                                  text: '${'Price'.tr} :',
                                  fontSize: 12.sp,
                                ),
                                5.width,
                                Obx(() {
                                  String priceString = product.sizes!
                                      .firstWhere(
                                        (size) => size.id == selectedSize.id,
                                    orElse: () =>
                                    product.sizes![
                                    0], // Return null if no size is found
                                  )
                                      ?.salePrice
                                      ?.toString() ??
                                      '0.00'; // Use '0.00' as a fallback price
                                  double price = double.parse(
                                      priceString); // Convert string to double
                                  var salePrice = price *
                                      productDetailsController.productQty.value;
                                  return AppTextStyle(
                                    text:
                                    GetCurrency.concatWithCurrency(salePrice.toStringAsFixed(0), GetCurrency.currencySymbol),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  );
                                }),
                              ],
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                );
              }),
              8.height,
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 2.h,
                  width: Get.width,
                  color: Colors.grey.shade300,
                ),
              ),
              5.height,
              SelectColors(
                product: product,
              ),
              10.height,
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 2.h,
                  width: Get.width,
                  color: Colors.grey.shade300,
                ),
              ),
              5.height,
              SelectVariation(
                product: product,
              ),
              10.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  globalButton(
                    onTap: () {
                      Get.back();
                    },
                    text: 'Cancel',
                    width: 150.w,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    shadowColor: Colors.transparent,
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.grey, Colors.grey.shade400],
                    ),
                  ),
                  10.height,
                  globalButton(
                    onTap: () {
                      cartController
                          .updateCart(
                        productID: product.id!,
                        qty: productDetailsController.productQty.value,
                        varientID:
                        productDetailsController.selectedVarientID.value,
                        sizeID: productDetailsController.selectedSizeID.value,
                      )
                          .then((_) {
                        if (cartController.isUpdated.value) {
                          // Get.back();
                          Navigator.pop(context);
                        }
                      });
                    },
                    text: 'Apply',
                    width: 150.w,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    shadowColor: Colors.transparent,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
