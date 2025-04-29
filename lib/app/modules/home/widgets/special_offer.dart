import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/models/product/porduct_model_api.dart';
import 'package:shop_villa/helper/helper_utils.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/cached_network_image_builder.dart';
import '../../../routes/app_pages.dart';
import '../../flashSales/controllers/flash_sales_controller.dart';
import '../controllers/home_controller.dart';

class SpecialOfferHome extends StatelessWidget {
  const SpecialOfferHome({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: ColorName.bgColorWhite,
      ),
      child: Row(
        children: [
          SizedBox(
            height: 90.h,
            width: 90.w,
            child: CarouselSlider(
              items: List.generate(controller.specialOffersList.length,
                  (index) {
                final ProductData product =
                    controller.specialOffersList[index];
                return ClipRRect(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.r), topLeft: Radius.circular(15.r)),
                  child: cachedImageHelper(
                    imgurl:
                    product.productvariations![0].image! ,
                    shimmerHeight: 90.h,
                    shimmerWidth: 90.w,
                    imgHeight: 90.h,
                    imgWidth: 90.w,
                  ),
                );
              }),
              options: CarouselOptions(
                height: 90.h,
                aspectRatio: 3,
                viewportFraction: 1,
                enlargeFactor: 0.8,
                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                enlargeCenterPage: true,
                reverse: true,
                autoPlay: true,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextStyle(
                    text: 'Special Offers',
                    textAlign: TextAlign.start,
                    color: ColorName.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 17.sp,
                  ),
                  AppTextStyle(
                    text: 'We make sure you get the offer',
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    fontSize: 12.sp,
                    color: ColorName.black,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                final FlashSalesController flashSalesController =Get.put(FlashSalesController());
                flashSalesController.selectedFilterTypeName.value = HelperUtils.specialOffers;
                flashSalesController.flashSalesList.value = controller.specialOffersList;
                flashSalesController.flashSaleCurrentPage.value = 1;
                flashSalesController.appBarTitle.value = 'Special Offers';
                Get.toNamed(Routes.FLASH_SALES);
              },
              icon: const Icon(
                Icons.arrow_forward,
                color: ColorName.black,
                size: 22,
              )),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
    );
  }
}
