import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_scroll_to_top/flutter_scroll_to_top.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_villa/app/models/product/porduct_model_api.dart';
import 'package:shop_villa/gen/colors.gen.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import 'package:shop_villa/helper/appbar_title.dart';
import 'package:shop_villa/helper/product_layout.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/not_search_items_found_widget.dart';
import '../../../../global/server_error_widget.dart';
import '../../../routes/app_pages.dart';
import '../controllers/products_controller.dart';
import '../widget/filter_widget.dart';
import '../widget/sort_widget.dart';

class ProductsView extends GetView<ProductsController> {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    ProductsController controller = Get.put(ProductsController());
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (_, dynamic) {
        Get.delete<ProductsController>();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorName.bgColor,
        appBar: AppBar(
          backgroundColor: ColorName.bgColor,
          surfaceTintColor: ColorName.bgColor,
          leading: Get.currentRoute != '/products'
              ? const AppTextStyle(
                  text: '',
                )
              : IconButton(
                  onPressed: () {
                    Get.back();
                    Get.delete<ProductsController>();
                  },
                  icon: const Icon(
                    Icons.arrow_back_sharp,
                  ),
                ),
          title: appbarTitle(text: 'Products'),
          centerTitle: false,
          actions: [
            Visibility(
              visible: !controller.isFromCollection.value,
              child: const SortWidget(),
            ),
            10.width,
            Visibility(
              visible: !controller.isFromCollection.value,
              child: const FilterWidget(),
            ),
            10.width,
          ],
        ),
        body: Column(
          children: [
            /// Search bar widget
            InkWell(
              borderRadius: BorderRadius.circular(15.r),
              onTap: () {
                Get.toNamed(Routes.SEARCHING);
                Get.delete<ProductsController>();
              },
              child: Container(
                  height: 45.h,
                  margin: const EdgeInsets.all(8),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x19000000),
                        blurRadius: 9,
                        offset: Offset(0, 2),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      10.width,
                      Icon(
                        Icons.search_rounded,
                        size: 23.sp,
                        color: Colors.grey,
                      ),
                      10.width,
                      AppTextStyle(
                        text: controller.searchedText.value.isEmpty
                            ? "Search"
                            : controller.searchedText.value,
                        color: controller.searchedText.value.isEmpty
                            ? Colors.grey
                            : Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      )
                    ],
                  )),
            ),

            ///           ListView.builder             ///
            Obx(() {
              if (controller.isLoading.value == 0 &&
                  controller.productList.isNotEmpty) {
                return NotificationListener(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent &&
                        controller.isEndPage.value == false &&
                        controller.scrollLoading.value == false) {
                      controller.scrollLoading.value = true;
                      if (controller.isFromSearch.value == false) {
                        controller.fetchProducts(
                            page: controller.currentPage.value + 1);
                      } else {
                        controller.fetchSearchProduct(
                            text: controller.searchedText.value,
                            page: controller.currentPage.value + 1);
                      }
                    }
                    return false;
                  },
                  child: Expanded(
                    child: AnimationLimiter(
                      child: ScrollWrapper(
                        promptAlignment: Alignment.bottomRight,
                        enabledAtOffset: 100,
                        alwaysVisibleAtOffset: true,
                        promptTheme:
                            const PromptButtonTheme(color: ColorName.gray410),
                        builder: (context, properties) => Obx(
                          () => MasonryGridView.count(
                            // controller: controller.scrollController,
                            crossAxisCount: 2,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            itemCount: controller.productList.length +
                                (controller.scrollLoading.value ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == controller.productList.length &&
                                  controller.scrollLoading.value) {
                                return Center(
                                  child: LoadingAnimationWidget.stretchedDots(
                                    size: 40,
                                    color: ColorName.primaryColor,
                                  ),
                                );
                              } else {
                                final ProductData product =
                                    controller.productList[index];
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 500),
                                  child: ScaleAnimation(
                                    child: ProductLayout(product: product),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else if (controller.isLoading.value == 1) {
                return Center(
                  child: LoadingAnimationWidget.stretchedDots(
                    size: 40,
                    color: ColorName.primaryColor,
                  ),
                );

                ///   For Search result not found or empty data   ///
              } else if (controller.isLoading.value == 3) {
                return const Expanded(child: NotSearchedItemFoundWidget());
              } else {
                ///   For any kind of fetching product error
                return ServerErrorWidget(
                  iconHeight: 350.h,
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
