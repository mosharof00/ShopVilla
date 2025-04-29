import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/modules/my_order/widgets/track_order.dart';
import 'package:shop_villa/global/app_text_style.dart';
import 'package:shop_villa/helper/appbar_title.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import '../../../../../gen/colors.gen.dart';
import '../controllers/order_details_controller.dart';
import '../widgets/order_details_view.dart';

class OrderDetailsView extends GetView<OrderDetailsController> {
  const OrderDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    const selectColor = Colors.white;
    const unselectColor = Colors.black;
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        surfaceTintColor: ColorName.bgColor,
        title: appbarTitle(text: 'Order Details'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(10),
              clipBehavior: Clip.hardEdge,
              child: Container(
                height: 40.h,
                decoration: ShapeDecoration(
                  color: ColorName.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Obx(
                  () => TabBar(
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
                        text: 'Order Details',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        height: 0,
                        color: controller.selectedTabIndex.value == 0
                            ? selectColor
                            : unselectColor,
                      ),
                      AppTextStyle(
                        text: 'Track Order',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        height: 0,
                        color: controller.selectedTabIndex.value == 1
                            ? selectColor
                            : unselectColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const ViewOrderDetails(),
                TrackOrder(myOrder: controller.myOrder,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
