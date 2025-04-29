import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/models/product/porduct_model_api.dart';
import 'package:shop_villa/gen/colors.gen.dart';
import 'package:shop_villa/global/app_linear_gradient.dart';
import 'package:shop_villa/global/app_text_style.dart';
import 'package:shop_villa/global/app_text_style_over_flow.dart';
import 'package:shop_villa/global/cached_network_image_builder.dart';
import 'package:shop_villa/global/methods/get_currency.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import '../../../routes/app_pages.dart';

class FlashWidgetVertical extends StatelessWidget {
  const FlashWidgetVertical(
      {super.key, required this.product, required this.item});

  final ProductData product;
  final int item;
  // final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          Routes.PRODUCT_DETAILS,
          arguments: {
            'productID': product.id,
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 12.0, top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  cachedImageHelper(
                      imgurl: product.productvariations![0].image!,
                      imgHeight: 130.h,
                      imgWidth: 120.w),
                  Positioned(
                    top: 10.h,
                    left: 10.w,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: ColorName.yellowOcher,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: AppTextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          text: '${product.discountPercent.toString()}%',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: AppTextStyleOverFlow(
                        text: product.productName!,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AppTextStyle(
                            text: GetCurrency.concatWithCurrency(
                              product.sizes![0].salePrice!.toString(),
                              GetCurrency.currencySymbol,
                            ),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(width: 10),
                          AppTextStyle(
                            text: GetCurrency.concatWithCurrency(
                              product.sizes![0].regularPrice!.toString(),
                              GetCurrency.currencySymbol,
                            ),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.lineThrough,
                            color: ColorName.gray410,
                          ),
                        ],
                      ),
                    ),
                    10.height,
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Center(
                              child: FAProgressBar(
                            animatedDuration: const Duration(milliseconds: 500),
                            maxValue:
                                product.totalStock!.toDouble().roundToDouble(),
                            backgroundColor: ColorName.gray410,
                            // changeProgressColor: ColorName.green,
                            // progressColor: ColorName.yellow,
                            progressGradient: appLinearGradient(),
                            displayTextStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            size: 20,
                            currentValue:
                            product.sold!.toDouble().toInt().toDouble(),
                                displayText: '  Sold'.tr,
                          )),
                        ),
                        10.width,
                        Expanded(
                          flex: 2,
                          child: TextButton(
                            onPressed: () async {
                              Get.toNamed(
                                Routes.PRODUCT_DETAILS,
                                arguments: {
                                  'productID': product.id,
                                },
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  ColorName.yellowOcher),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                  size: 17,
                                ),
                                5.width,
                                SizedBox(
                                  width: 25.w,
                                  child: AppTextStyleOverFlow(text: 'Buy', color: Colors.white,
                                    fontSize: 12.sp,
                                    maxLines: 1,
                                    fontWeight: FontWeight.w500,),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
