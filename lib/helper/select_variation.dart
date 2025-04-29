import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import '../app/models/product_details/product_details_model.dart';
import '../app/modules/products/productDetails/controllers/product_details_controller.dart';
import '../gen/colors.gen.dart';
import '../global/app_text_style.dart';

class SelectVariation extends StatelessWidget {
  final ProductDetailsData product;

  const SelectVariation({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final productDetailsController = Get.find<ProductDetailsController>();
    if (product.sizes![productDetailsController.sizeSelectedIndex.value].size !=
        "No Size") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            return AppTextStyle(
              text:
              "${'Variants'.tr} : ${product.sizes![productDetailsController.sizeSelectedIndex.value].size}", // Display Selected Variant Name
              textAlign: TextAlign.start,
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
            );
          }),
          10.height,
          Obx(() {
            if (productDetailsController.product.value.data == null) {
              return Center(
                child: LoadingAnimationWidget.stretchedDots(
                    size: 40, color: ColorName.primaryColor),
              ); // or some other loading indicator
            } else {
              return Wrap(
                spacing: 10,
                children: List.generate(
                  productDetailsController.selectedVarientIndex.sizes!.length,
                      (index) {
                    var sizeId = productDetailsController
                        .selectedVarientIndex.sizes![index].id;
                    var sizeName = product.sizes!
                        .firstWhere((size) => size.id == sizeId)
                        .size!; // Get size name based on size ID
                    return GestureDetector(
                      onTap: () {
                        productDetailsController
                            .selectSize(index); // Handle size selection
                      },
                      child: Container(
                        constraints: BoxConstraints(
                          // maxHeight: 25.h,
                          maxWidth:
                          100.w, // Set maximum width for the size container
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: productDetailsController
                              .selectedSizeID.value ==
                              sizeId
                              ? Colors.blue
                              : Colors
                              .white, // Change color if size is selected
                          // shape: BoxShape.circle,
                          borderRadius: BorderRadius.circular(30.r),
                          border: Border.all(
                            color: productDetailsController
                                .selectedSizeID.value ==
                                sizeId
                                ? Colors.blue
                                : Colors.grey, // Highlight border if selected
                            width: 2,
                          ),
                        ),
                        child: Text(
                          sizeName,
                          style: TextStyle(
                            color: productDetailsController
                                .selectedSizeID.value ==
                                sizeId
                                ? Colors.white
                                : Colors
                                .black, // Set text color based on selection
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
