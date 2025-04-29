import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shop_villa/app/modules/products/productDetails/controllers/product_details_controller.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../global/app_text_style.dart';

class ProductQty extends StatelessWidget {
  const ProductQty({
    super.key,
    this.buttonHeight,
    this.buttonWidth,
    this.qty,
    required this.stock,
  });
  final double? buttonHeight;
  final int? qty;
  final double? buttonWidth;
  final int stock;
  @override
  Widget build(BuildContext context) {
    final productDetailsController = Get.find<ProductDetailsController>();
    return Row(
      children: [
        InkWell(
          onTap: () {
            if (productDetailsController.productQty.value <= 1) {
              productDetailsController.productQty.value = 1;
            } else {
              productDetailsController.productQty.value--;
            }
          },
          borderRadius: BorderRadius.circular(50.r),
          child: Container(
            height: buttonHeight ?? 30.h,
            width: buttonWidth ?? 30.w,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: ColorName.primaryColor),
            child: Center(
              child: Icon(
                MdiIcons.minus,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
        ),
        8.width,
        Obx(
              () => AppTextStyle(
            text: productDetailsController.productQty.value.toString(),
            fontSize: 16.sp,
            color: ColorName.primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        8.width,
        InkWell(
          onTap: () {
            if(productDetailsController.productQty.value < stock){
              productDetailsController.productQty.value++;
            }
          },
          borderRadius: BorderRadius.circular(50.r),
          child: Container(
            height: buttonHeight ?? 30.h,
            width: buttonWidth ?? 30.w,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: ColorName.primaryColor),
            child: Center(
              child: Icon(
                MdiIcons.plus,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
