
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/modules/home/controllers/home_controller.dart';
import 'package:shop_villa/global/app_text_style_over_flow.dart';
import 'package:shop_villa/global/cached_network_image_builder.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';

import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../routes/app_pages.dart';
import '../../products/controllers/products_controller.dart';

class FlatHeels extends StatelessWidget {
  const FlatHeels({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        height: 135.h,
        // width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          gradient: const LinearGradient(
              colors: [Color(0xff6a11cb), Color(0xff2575fc)]),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 0.4.sw,
              child: cachedImageHelper(
                imgurl: controller.specialCategoryData.value.image!,
                imgHeight: 135.h,
                imgWidth: 130.w,
                radius: 25.r,
              ),
            ),
            10.width,
            SizedBox(
              width: 0.52.sw,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextStyle(
                    text: 'Flat and Heels',
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: ColorName.white,
                  ),
                  AppTextStyleOverFlow(
                    text: 'Stand a chance to get rewarded',
                    fontWeight: FontWeight.w500,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    fontSize: 14.sp,
                    color: ColorName.white,
                  ),
                  InkWell(
                    onTap: () {
                      final ProductsController productsController =
                          Get.put(ProductsController());
                      productsController.appBarTitle.value = 'Flat and Heels';
                      productsController.categoryID.value =
                          controller.specialCategoryID.value;
                      productsController.fetchProducts();
                      Get.toNamed(Routes.PRODUCTS);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        width: 95.w,
                        height: 35.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: ColorName.white),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: AppTextStyle(
                                text: 'View All',
                                fontSize: 14.sp,
                                color: ColorName.white,
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            const Icon(
                              Icons.arrow_forward,
                              color: ColorName.white,
                              size: 22,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
