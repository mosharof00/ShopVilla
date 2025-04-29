import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/models/sub_category/sub_category_model.dart';
import 'package:shop_villa/app/modules/home/controllers/home_controller.dart';
import 'package:shop_villa/app/modules/products/controllers/products_controller.dart';
import 'package:shop_villa/global/loading_animation_widget.dart';
import 'package:shop_villa/global/methods/get_image_url.dart';
import 'package:shop_villa/global/server_error_widget.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/app_text_style_over_flow.dart';
import '../../../../global/shimmer_loading.dart';
import '../../../../helper/appbar_title.dart';
import '../../../../helper/log_printer.dart';
import '../../../models/category/category_model.dart';
import '../../../routes/app_pages.dart';
import '../../mainpage/controllers/mainpage_controller.dart';
import '../controllers/categories_controller.dart';

class CategoriesView extends GetView<CategoriesController> {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoriesController());
    final homeController = Get.find<HomeController>();
    Get.put(MainPageController());
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        surfaceTintColor: ColorName.bgColor,
        title: appbarTitle(text: 'Beauty & Fashion'),
        centerTitle: true,
        leading: Get.currentRoute != '/categories'
            ? const AppTextStyle(
                text: '',
              )
            : InkWell(
                onTap: () {
                  Get.back();
                  Get.delete<CategoriesController>();
                },
                child: const Icon(Icons.arrow_back),
              ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Row(
              children: [
                ///   for Category view
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 1.sh,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: homeController.categoryList.length,
                      itemBuilder: (context, index) {
                        final CategoryData category =
                            homeController.categoryList[index];
                        return InkWell(
                          onTap: () {
                            controller.selectedIndex.value = index;
                            controller.selectedCategoryId.value = category.id!;
                            Log.i(
                                " Category iD : ${controller.selectedCategoryId.value}");
                            controller.fetchSubCategories(
                                categoryId:
                                    controller.selectedCategoryId.value);
                          },
                          child: Obx(
                            () {
                              bool isSelected =
                                  controller.selectedIndex.value == index;
                              return Material(
                                elevation: isSelected ? 8 : 0,
                                child: Container(
                                  height: 100.h,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Colors.white38
                                        : ColorName.bgColor,
                                    border: Border(
                                      left: BorderSide(
                                          color: isSelected
                                              ? Colors.black
                                              : Colors.transparent,
                                          width: 6.w),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl:
                                              GetImageUrl.url(category.image!),
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            width: 50.0.w,
                                            height: 50.0.h,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.grey,
                                                  offset:
                                                      Offset(0.0, 1.0), //(x,y)
                                                  blurRadius: 6.0,
                                                ),
                                              ],
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              shimmerLoadingWidget(
                                                  borderRadius: 50,
                                                  height: 50.0.h,
                                                  width: 50.0.w),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        Expanded(
                                          child: AppTextStyleOverFlow(
                                            text: category.categoryName
                                                .toString(),
                                            fontWeight: FontWeight.w500,
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            fontSize: 11.sp,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),

                ///  for SubCategory view
                Expanded(
                  flex: 4,
                  child: SizedBox(
                    height: 1.sh,
                    child: Obx(() {
                      if (controller.isSubCategoryLoading.value == 1) {
                        return loadingAnimationWidget();
                      } else if (controller.isSubCategoryLoading.value == 0) {
                        return GridView.builder(
                          itemCount: controller.subCategoryList.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            final SubCategory subCategory =
                                controller.subCategoryList[index];
                            return InkWell(
                              onTap: () async {
                                controller.selectedSubCategoryId.value =
                                    subCategory.id!;
                                final ProductsController productController =
                                    Get.put(ProductsController());
                                productController.appBarTitle.value =
                                    "${subCategory.name!}s";
                                productController.categoryID.value =
                                    controller.selectedCategoryId.value;
                                productController.subCategoryID.value =
                                    controller.selectedSubCategoryId.value;
                                productController.fetchProducts(page: null);
                                Get.toNamed(Routes.PRODUCTS);
                              },
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            topLeft: Radius.circular(20)),
                                        child: CachedNetworkImage(
                                          imageUrl: GetImageUrl.url(
                                              subCategory.image!),
                                          fit: BoxFit.fill,
                                          height: 60.h,
                                          placeholder: (context, url) =>
                                              shimmerLoadingWidget(
                                            height: 125.h,
                                            width: 125.w,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              SvgPicture.asset(
                                            Assets.images.errorThumbnail,
                                            width: Get
                                                .width, // Keep consistent sizing
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      AppTextStyleOverFlow(
                                        text: subCategory.name.toString(),
                                        fontWeight: FontWeight.w500,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        fontSize: 11.sp,
                                      )
                                    ],
                                  )),
                            );
                          },
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5.r,
                            mainAxisSpacing: 3.r,
                            mainAxisExtent: 110.r,
                            childAspectRatio: 1,
                          ),
                        );
                      } else {
                        return ServerErrorWidget(
                          iconHeight: 200.h,
                          iconWidth: 200.w,
                          title: 'We are sorry!',
                          message:
                              "Something went wrong. Please try again letter.",
                        );
                      }
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
