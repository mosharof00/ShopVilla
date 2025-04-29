import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import '../app/models/product_details/product_details_model.dart';
import '../app/modules/products/productDetails/controllers/product_details_controller.dart';
import '../gen/colors.gen.dart';
import '../global/app_text_style.dart';

class SelectColors extends StatelessWidget {
  final ProductDetailsData product;

  const SelectColors({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final productDetailsController = Get.find<ProductDetailsController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return AppTextStyle(
                text: '${'Color'.tr} : ${product
                    .productvariations![
                productDetailsController.colorSelectedIndex.value]
                    .color
                    .toString()} ', // Display Selected Color Name
                fontSize: 17.sp,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w600,
              );
            }),
          ],
        ),
        10.height,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            product.productvariations!.length,
                (index) {
              final colorCode =
              product.productvariations![index].colorCode?.substring(1);
              final int hexCode = colorCode != null
                  ? int.parse(colorCode, radix: 16)
                  : 0xFFFFFFFF; // Default color (black) in case colorCode is null
              return GestureDetector(
                onTap: () {
                  productDetailsController.selectColor(
                      index); // Select color on tap
                  productDetailsController.selectedImage.value = index;
                  productDetailsController.currentDotedIndex.value = 0;
                },
                child: Obx(() {
                  productDetailsController.selectedVarientID.value = product
                      .productvariations![
                  productDetailsController.colorSelectedIndex.value]
                      .id!; // Update selected variant ID
                  return Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Container(
                      height: 30.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0XFF000000 + hexCode),
                        // Using the parsed color
                        border: Border.all(
                          color: productDetailsController.colorSelectedIndex
                              .value ==
                              index
                              ? ColorName.primaryColor.withAlpha(120)
                              : Colors.grey, // Highlight selected color
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.check,
                        size: 15,
                        color:
                        productDetailsController.colorSelectedIndex.value ==
                            index
                            ? Colors.grey
                            : Colors.transparent, // Show check icon if selected
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ),
      ],
    );
  }
}

