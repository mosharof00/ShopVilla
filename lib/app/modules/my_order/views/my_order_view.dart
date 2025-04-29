import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/modules/mainpage/controllers/mainpage_controller.dart';
import 'package:shop_villa/app/modules/my_order/widgets/active_order.dart';
import 'package:shop_villa/app/modules/my_order/widgets/canceled_order.dart';
import 'package:shop_villa/global/app_text_style_over_flow.dart';
import 'package:shop_villa/helper/appbar_title.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../controllers/my_order_controller.dart';
import '../widgets/completed_order.dart';

class MyOrderView extends GetView<MyOrderController> {
  const MyOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyOrderController());
    Get.put(MainPageController());
    const selectColor = Colors.white;
    const unselectColor = Colors.black;
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        surfaceTintColor: ColorName.bgColor,
        title: appbarTitle(text: 'My Order'),
        centerTitle: true,
        automaticallyImplyLeading:
            Get.currentRoute != '/my-order' ? false : true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(10),
              clipBehavior: Clip.hardEdge,
              child: Container(
                height: 40.h,
                // width: Get.width,
                decoration: ShapeDecoration(
                  color: ColorName.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Obx(() => TabBar(
                      indicatorWeight: 0,
                      tabAlignment: TabAlignment.fill,
                      controller: controller.tabController,
                      dividerColor: Colors.transparent,
                      automaticIndicatorColorAdjustment: true,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: RectangularIndicator(
                        color: ColorName.primaryColor,
                        bottomLeftRadius: 8,
                        bottomRightRadius: 8,
                        topLeftRadius: 8,
                        topRightRadius: 8,
                        paintingStyle: PaintingStyle.fill,
                      ),
                      unselectedLabelColor: Colors.black,
                      onTap: (index) {
                        controller.updateSelectedTab(index);
                      },
                      tabs: [
                        AppTextStyle(
                          text: 'Active',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          height: 0,
                          color: controller.selectedTabIndex.value == 0
                              ? selectColor
                              : unselectColor,
                        ),
                        AppTextStyle(
                          text: 'Completed',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          height: 0,
                          color: controller.selectedTabIndex.value == 1
                              ? selectColor
                              : unselectColor,
                        ),
                        AppTextStyleOverFlow(
                          text: 'Canceled',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          height: 0,
                          color: controller.selectedTabIndex.value == 2
                              ? selectColor
                              : unselectColor,
                        ),
                      ],
                    )),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller.tabController,
              children: const [
                ActiveOrders(),
                CompleteOrder(),
                CancelledOrder()
              ],
            ),
          )
        ],
      ),
    );
  }
}
