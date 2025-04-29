import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../global/app_text_style.dart';
import '../../../../../global/custom_option.dart';
import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final localController = ValueNotifier<bool>(true);
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(

        title: const AppTextStyle(text: 'Notifications'),
        centerTitle: true,
        backgroundColor: ColorName.bgColor,
        surfaceTintColor: ColorName.bgColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.height,
              customOFFONOption(
                  text: "New Arrival Notification",
                  initialValue: true,
                  onChanged: (value) {}),
              customOFFONOption(text: "Sale Alerts", onChanged: (value) {}),
              customOFFONOption(
                  text: "Wishlist Update",
                  initialValue: true,
                  onChanged: (value) {}),
              customOFFONOption(
                  text: "Security Alerts",
                  initialValue: true,
                  onChanged: (value) {}),
              customOFFONOption(
                  text: "Order Status Updates",
                  initialValue: true,
                  onChanged: (value) {}),
              customOFFONOption(
                  text: "Exclusive Offers",
                  initialValue: true,
                  onChanged: (value) {}),
              customOFFONOption(
                  text: "Style Recombination", onChanged: (value) {}),
              customOFFONOption(
                  text: "Flash Sales Notification", onChanged: (value) {}),
              customOFFONOption(
                  text: "Review Remainders", onChanged: (value) {}),
              customOFFONOption(
                  text: "App Update and News",
                  initialValue: true,
                  onChanged: (value) {}),
              customOFFONOption(
                  text: "Event Invitation",
                  initialValue: true,
                  onChanged: (value) {}),
              customOFFONOption(
                  text: "Reward Program Updates",
                  initialValue: true,
                  onChanged: (value) {}),
              customOFFONOption(
                  text: "Important Announcement", onChanged: (value) {}),
              customOFFONOption(
                  text: "Apps Tips and Tutorial", onChanged: (value) {}),
            ],
          ),
        ),
      ),
    );
  }
}
