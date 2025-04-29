
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/models/collections/collection_model.dart';
import 'package:shop_villa/app/modules/home/controllers/home_controller.dart';
import 'package:shop_villa/global/app_text_style_over_flow.dart';
import 'package:shop_villa/global/cached_network_image_builder.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/label_with_title_view_all.dart';
import '../../../routes/app_pages.dart';
import '../../products/controllers/products_controller.dart';

class Collections extends StatelessWidget {
  const Collections({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 10.w,
            top: 10.h,
          ),
          child: AppTextStyle(
            text: 'Collections',
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.start,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 10.w,
          ),
          child: AppTextStyle(
            text: 'We are associated with this popular Collections',
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: ColorName.gray410,
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(
          height: 300.h,
          width: Get.width,
          child: ListView.builder(
              itemCount: controller.collectionList.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final CollectionData collection =
                    controller.collectionList[index];
                return GestureDetector(
                  onTap: () {
                    final ProductsController productsController =
                        Get.put(ProductsController());
                    productsController.appBarTitle.value =
                        'Collection Products';
                    productsController.selectedCollectionId.value =
                        collection.id!;
                    productsController.isFromCollection.value = true;
                    productsController.fetchProducts();
                    Get.toNamed(Routes.PRODUCTS);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10.r),
                    child: Container(
                        // height: 350,
                        width: 300.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.r),
                                  topLeft: Radius.circular(20.r)),
                              child: cachedImageHelper(imgurl: collection.image!, imgHeight: 200.h, imgWidth: 300.w),
                            ),
                            TitleWithViewAllWidget(
                              title: collection.title!,
                              textAlign: TextAlign.start,
                              titlefontSize: 16.sp,
                              viewAllFontSize: 15.sp,
                              viewAllFontWeight: FontWeight.w600,
                            ),
                            5.height,
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: AppTextStyleOverFlow(
                                maxLines: 1,
                                text: collection.subTitle!,
                                textAlign: TextAlign.start,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
