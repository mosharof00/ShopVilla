import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import 'package:shop_villa/helper/helper_utils.dart';

import '../../../../global/label_with_title_view_all.dart';
import '../../../../helper/product_layout.dart';
import '../../../models/product/porduct_model_api.dart';
import '../../../routes/app_pages.dart';
import '../../products/controllers/products_controller.dart';
import '../controllers/home_controller.dart';

class TrendingProductHome extends StatelessWidget {
  const TrendingProductHome({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        height: 350.h,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: Colors.green.shade50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h),
              child: TitleWithViewAllWidget(
                title: 'Trending Products',
                onTap: () {
                  final ProductsController productsController =
                      Get.put(ProductsController());
                  productsController.appBarTitle.value ='Trending Products';
                  productsController.productList.value =
                      controller.trendingProductsList;
                  productsController.currentPage.value = 1;
                  productsController.selectedFilterTypeName.value =
                      HelperUtils.trendingProducts;
                  productsController.isLoading.value = 0;
                  productsController.initialType = HelperUtils.trendingProducts;
                  Get.toNamed(Routes.PRODUCTS);
                },
                titlefontSize: 17.sp,
                viewAllFontSize: 14.sp,
              ),
            ),
            5.height,
            SizedBox(
              height: 290.h,
              child: AnimationLimiter(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: controller.trendingProductsList.length,
                  itemBuilder: (context, item) {
                    final ProductData products =
                        controller.trendingProductsList[item];
                    return AnimationConfiguration.staggeredList(
                        position: item,
                        duration: const Duration(milliseconds: 500),
                        child: SlideAnimation(
                          verticalOffset: 50,
                          child: FadeInAnimation(
                            child: ProductLayout(
                              product: products,
                            ),
                          ),
                        ));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
