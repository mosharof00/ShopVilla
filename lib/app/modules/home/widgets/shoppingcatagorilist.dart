import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/models/category/category_model.dart';
import 'package:shop_villa/app/modules/home/controllers/home_controller.dart';
import 'package:shop_villa/global/methods/get_image_url.dart';

import '../../../../global/app_text_style_over_flow.dart';
import '../../../../global/shimmer_loading.dart';
import '../../../routes/app_pages.dart';
import '../../categories/controllers/categories_controller.dart';

class ShoppingCategoryList extends StatelessWidget {
  const ShoppingCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return ListView.builder(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      scrollDirection: Axis.horizontal,
      itemCount: controller.categoryList.length,
      itemBuilder: (context, item) {
        final CategoryData category = controller.categoryList[item];
        return InkWell(
          onTap: () {
            final CategoriesController categoriesController  = Get.put(CategoriesController());
            categoriesController.selectedIndex.value = item;
            categoriesController.selectedCategoryId.value = category.id!;
            categoriesController.fetchSubCategories(categoryId:  categoriesController.selectedCategoryId.value);
            Get.toNamed(Routes.CATEGORIES);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: GetImageUrl.url(category.image!),
                  imageBuilder: (context, imageProvider) => Container(
                    width: 50.0.w,
                    height: 50.0.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => shimmerLoadingWidget(
                      borderRadius: 50, height: 50.0.h, width: 50.0.w),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Expanded(
                  child: AppTextStyleOverFlow(
                    text: category.categoryName!.split(' ')[0].toString(),
                    fontWeight: FontWeight.w500,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    fontSize: 11.sp,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
