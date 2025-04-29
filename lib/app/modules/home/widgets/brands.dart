import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/models/brands/brand_model.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import 'package:shop_villa/helper/log_printer.dart';

import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/methods/get_image_url.dart';
import '../../../../global/shimmer_loading.dart';
import '../../../routes/app_pages.dart';
import '../../products/controllers/products_controller.dart';
import '../controllers/home_controller.dart';

class Brands extends StatelessWidget {
  const Brands({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 10.w,
            top: 10.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextStyle(
                text: 'Popular Brands',
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start,
              ),
              AppTextStyle(
                text: 'We are associated with this popular brands',
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: ColorName.gray410,
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
        10.height,
        Obx(() {
          if (controller.brandList.isNotEmpty) {
            return SizedBox(
              height: 145.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.brandList.length,
                itemBuilder: (_, index) {
                  final Brand brand = controller.brandList[index];
                  return InkWell(
                    onTap: (){
                      Log.i("tapped");
                      final ProductsController productsController =
                      Get.put(ProductsController());
                      productsController.appBarTitle.value = '${brand.name} Products';
                     productsController.selectedBrandID.value = brand.id!;
                      productsController.fetchProducts();
                      Get.toNamed(Routes.PRODUCTS);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Column(
                        children: [
                          CachedNetworkImage(
                            imageUrl: GetImageUrl.url(brand.image!),
                            imageBuilder: (BuildContext context, imageProvider) {
                              return Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            },
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 5.h),
                              Text(
                                brand.name!,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            // Show shimmer loading if brandList is empty
            return shimmerLoadingWidget(height: 0.18.sh, width: Get.width);
          }
        }),
      ],
    );
  }
}
