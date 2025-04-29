import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_villa/app/models/product/porduct_model_api.dart';
import 'package:shop_villa/global/server_error_widget.dart';
import 'package:shop_villa/helper/appbar_title.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/not_search_items_found_widget.dart';
import '../controllers/flash_sales_controller.dart';
import '../widget/flash_widget_vertical.dart';

class FlashSalesView extends GetView<FlashSalesController> {
  const FlashSalesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        title: appbarTitle(text: 'Flash Sales',),
        centerTitle: true,
        surfaceTintColor: ColorName.bgColor,
        backgroundColor: ColorName.bgColor,
        leading: InkWell(
          onTap: () {
            Get.back();
            Get.delete<FlashSalesController>();
          },
          child: const Icon(Icons.arrow_back_sharp),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(() {
            if (controller.isFlashSalesLoading.value == 0 ||
                controller.flashSalesList.isNotEmpty) {
              return NotificationListener(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent &&
                      controller.isFlashSaleEndPage.value == false &&
                      controller.isFlashSaleScrollLoading.value == false) {
                    controller.isFlashSaleScrollLoading.value = true;
                    controller.fetchFlashSalesProducts(
                        page: controller.flashSaleCurrentPage.value + 1);
                  }
                  return false;
                },
                child: Obx(() => ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.flashSalesList.length +
                          (controller.isFlashSaleScrollLoading.value ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == controller.flashSalesList.length &&
                            controller.isFlashSaleScrollLoading.value) {
                          return Center(
                            child: LoadingAnimationWidget.stretchedDots(
                              size: 40,
                              color: ColorName.primaryColor,
                            ),
                          );
                        } else {
                          final ProductData product =
                              controller.flashSalesList[index];
                          return AnimationLimiter(
                            child: AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 100),
                              child: SlideAnimation(
                                verticalOffset: 50,
                                child: ScaleAnimation(
                                  child: FlashWidgetVertical(
                                    product: product,
                                    item: index,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                ),
              );
            } else if (controller.isFlashSalesLoading.value == 1) {
              return Center(
                child: LoadingAnimationWidget.stretchedDots(
                  size: 40,
                  color: ColorName.primaryColor,
                ),
              );
            } else if (controller.isFlashSalesLoading.value == 3) {
              return const Expanded(child: NotSearchedItemFoundWidget());
            } else {
              return const ServerErrorWidget(iconWidth: 250,iconHeight: 250,);
            }
          })),
    );
  }
}
