import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/modules/products/controllers/products_controller.dart';
import 'package:shop_villa/helper/helper_utils.dart';

import '../../../../global/label_with_title_view_all.dart';
import '../../../../helper/product_layout.dart';
import '../../../models/product/porduct_model_api.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class NewArrivalsHome extends StatelessWidget {
  const NewArrivalsHome({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Container(
      constraints: BoxConstraints(
        minHeight: 270.h,
        maxHeight: 350.h,
      ),
      height: 320.h,
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: Colors.green.shade50,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h),
            child: TitleWithViewAllWidget(
              title: 'New Arrivals',
              onTap: () {
                final ProductsController productsController =
                    Get.put(ProductsController());
                productsController.appBarTitle.value = "New Arrivals";
                productsController.selectedFilterTypeName.value =
                    HelperUtils.newArrivals;
                productsController.productList.value =
                    controller.newArrivalsList;
                productsController.currentPage.value = 1;
                productsController.isLoading.value = 0;
                productsController.initialType = HelperUtils.newArrivals;
                Get.toNamed(Routes.PRODUCTS);
              },
              titlefontSize: 17.sp,
              viewAllFontSize: 14.sp,
            ),
          ),
          SizedBox(
              height: 270.h,
              child: AnimationLimiter(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: controller.newArrivalsList.length,
                  itemBuilder: (context, item) {
                    final ProductData products =
                        controller.newArrivalsList[item];
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
                      ),
                    );
                  },
                ),
              )),
        ],
      ),
    );
  }
}
