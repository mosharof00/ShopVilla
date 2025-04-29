import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/modules/products/productDetails/controllers/product_details_controller.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../global/app_text_style.dart';

class PickVariations extends StatelessWidget {
  const PickVariations({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductDetailsController());
    return Obx(() => CustomSlidingSegmentedControl<int>(
          isStretch: false,
          fixedWidth: 50.w,
          innerPadding: EdgeInsets.zero,
          padding: 0,
          height: 36.h,
          children: {
            0: AppTextStyle(
              text: 'M',
              color: controller.tabSelectedIndex.value == 0
                  ? Colors.white
                  : Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
            1: AppTextStyle(
              text: 'L',
              color: controller.tabSelectedIndex.value == 1
                  ? Colors.white
                  : Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
            2: AppTextStyle(
              text: 'XL',
              color: controller.tabSelectedIndex.value == 2
                  ? Colors.white
                  : Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          },
          decoration: const BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
          ),
          thumbDecoration: BoxDecoration(
            color: ColorName.onPrimary,
            shape: BoxShape.circle,
            border: Border.all(style: BorderStyle.none),
            // borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.3),
                blurRadius: 4.0,
                spreadRadius: 1.0,
                offset: const Offset(
                  0.0,
                  2.0,
                ),
              ),
            ],
          ),
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastEaseInToSlowEaseOut,
          onValueChanged: (v) {
            if (kDebugMode) {
              print(v);
            }
            controller.tabSelectedIndex.value = v;
          },
        ));
  }
}
