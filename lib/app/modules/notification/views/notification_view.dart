import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:shop_villa/app/models/notification/notification_model.dart';
import 'package:shop_villa/gen/assets.gen.dart';
import 'package:shop_villa/global/server_error_widget.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import 'package:shop_villa/helper/appbar_title.dart';
import 'package:shop_villa/helper/helper_utils.dart';
import '../../../../appConfig.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/loading_animation_widget.dart';
import '../../../routes/app_pages.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        title: appbarTitle(text: 'Notification'),
        centerTitle: true,
        backgroundColor: ColorName.bgColor,
        surfaceTintColor: ColorName.bgColor,
      ),
      body: Obx(() {
        if (controller.isLoading.value == 0) {
          if (controller.notificationList.isNotEmpty) {
            return GroupedListView<NotificationData, String>(
              elements: controller.notificationModel.value.data ?? [],
              groupBy: (element) => HelperUtils.groupByDate(element.createdAt),
              groupComparator: (value1, value2) =>
                  HelperUtils.groupComparator(value1, value2),
              itemComparator: (item1, item2) =>
                  item1.title!.compareTo(item2.title!),
              order: GroupedListOrder.ASC,
              useStickyGroupSeparators: true,
              groupSeparatorBuilder: (String value) => Padding(
                padding: EdgeInsets.all(5.0.r),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppTextStyle(
                    text: value,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorName.primaryColor,
                  ),
                ),
              ),
              itemBuilder: (c, element) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom:
                          BorderSide(width: 1.w, color: Colors.grey.shade300),
                    ),
                  ),
                  child: ListTile(
                    title: AppTextStyle(
                      text: element.title!,
                      textAlign: TextAlign.start,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        element.description == null
                            ? const SizedBox.shrink()
                            : AppTextStyle(
                                text: element.description!,
                                fontSize: 12.sp,
                                textAlign: TextAlign.start,
                                color: ColorName.primaryColor,
                              ),
                        3.height,
                        AppTextStyle(
                          text: HelperUtils.formatTimeAgo(element.createdAt!),
                          fontSize: 12.sp,
                          textAlign: TextAlign.start,
                          color: ColorName.primaryColor,
                        ),
                      ],
                    ),
                    onTap: element.type == 'order'
                        ? () async {
                      await controller.userOrderList(
                          invoiceID: element.invoice!);
                      if (controller.myOrder.isNotEmpty) {
                        await Get.toNamed(Routes.ORDER_DETAILS,
                            arguments: {
                              'arg1': controller.myOrder.first
                            });
                      }
                    }
                        : () {},
                    leading: CircleAvatar(
                      backgroundColor: ColorName.primaryColor.withOpacity(0.2),
                      child: Center(
                          child: SvgPicture.asset(
                        AppConfig.appLogo,
                        height: 25,
                        width: 25,
                      )),
                    ),
                  ),
                );
              },
            );
          } else {
            return ServerErrorWidget(
              svgImagePath: Assets.icons.emptyNotification,
              title: 'Sorry',
              message: "You don't have any notification yet.",
              iconHeight: 200.h,
              iconWidth: 200,
            );
          }
        } else if (controller.isLoading.value == 1) {
          return Center(
              child: loadingAnimationWidget(
                  color: ColorName.primaryColor, size: 40));
        } else {
          return const ServerErrorWidget(
            iconHeight: 300,
            iconWidth: 300,
          );
        }
      }),
    );
  }
}
