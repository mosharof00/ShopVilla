import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/modules/cart/controllers/cart_controller.dart';
import 'package:shop_villa/global/methods/get_image_url.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/app_text_style_over_flow.dart';
import '../../../../global/cached_network_image_builder.dart';
import '../../../../global/divider.dart';
import '../../../../global/methods/get_currency.dart';
import '../../../models/cart/cart_get_model.dart';
import '../../../models/product_model.dart';
import '../../../repository/api_endpoint.dart';
import '../../home/controllers/home_controller.dart';

class YourOrder extends StatelessWidget {
  const YourOrder({
    super.key,
    this.viewProducts,
  });

  final bool? viewProducts;

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.find<CartController>();
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
          color: ColorName.white, borderRadius: BorderRadius.circular(15.r)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            10.height,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                5.width,
                const Icon(
                  Icons.shopping_cart_rounded,
                  color: Colors.green,
                ),
                10.width,
                AppTextStyle(
                  text: '${'Your Order'.tr} (${cartController.cart.length})',
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
              ],
            ),
            10.height,
            customDivider(),
            5.height,
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cartController.cart.length,
              itemBuilder: (context, index) {
                final Cart cart = cartController.cart[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        cachedImageHelper(imgurl: cart.image!, imgWidth: 110.w, imgHeight: 120.h),
                        15.width,
                        Expanded(
                          flex: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextStyleOverFlow(
                                text: cart.productName!,
                                maxLines: 3,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                              ),
                              5.height,
                              Row(
                                children: [
                                  AppTextStyle(
                                    text: '${'Size'.tr} : ${cart.productSize}',
                                    fontSize: 12.sp,
                                  ),
                                  5.width,
                                  AppTextStyle(
                                    text: '${'Color'.tr} : ${cart.productColor}',
                                    fontSize: 12.sp,
                                  ),
                                ],
                              ),
                              5.height,
                              Row(
                                children: [
                                  AppTextStyle(
                                    text: '${'Quantity'.tr} : ',
                                    fontSize: 12.sp,
                                  ),
                                  AppTextStyle(
                                    text: cart.qty!.toString(),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                              5.height,
                              AppTextStyle(
                                text: '${'Total'.tr} : ${GetCurrency.concatWithCurrency(
                                    cart.total?.split('.')[0] ?? '0',
                                    GetCurrency.currencySymbol)}',
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
