import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/models/order%20place/user_orderlist_post_model.dart';
import 'package:shop_villa/app/modules/my_order/controllers/my_order_controller.dart';
import 'package:shop_villa/app/modules/my_order/order_details/controllers/order_details_controller.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';

import '../../../../global/app_text_style.dart';

class DeliveryStatus extends GetView<MyOrderController> {
  const DeliveryStatus({super.key,});
  @override
  Widget build(BuildContext context) {
    final MyOrder myOrder = Get.find<OrderDetailsController>().myOrder;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            25.height,
            AppTextStyle(
              text: '${'Order ID'.tr}: ${myOrder.invoiceId}',
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            5.height,
            AppTextStyle(
              text: '${'Status'.tr}: ${controller.statusDesc(1)}',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
            20.height,
          ],
        ),
        Column(
          children: [
            40.height,
            AppTextStyle(
              text: '${'Order ID'.tr}: ${myOrder.invoiceId}',
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            5.height,
            AppTextStyle(
              text: '${'Status'.tr}: ${controller.statusDesc(2)}',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
            50.height,
          ],
        ),
        Column(
          children: [
            25.height,
            AppTextStyle(
              text: '${'Order ID'.tr}: ${myOrder.invoiceId}',
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            5.height,
            AppTextStyle(
              text: '${'Status'.tr}: ${controller.statusDesc(3)}',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
            50.height,
          ],
        ),
        Column(
          children: [
            25.height,
            AppTextStyle(
              text: '${'Order ID'.tr}: ${myOrder.invoiceId}',
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            5.height,
            AppTextStyle(
              text: '${'Status'.tr}: ${controller.statusDesc(4)}',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
            50.height,
          ],
        ),
      ],
    );
  }
}
