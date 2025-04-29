import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/routes/app_pages.dart';
import 'package:shop_villa/gen/colors.gen.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import 'package:shop_villa/helper/appbar_title.dart';
import '../../../../../global/custom_option.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        title: appbarTitle(text: 'Settings'),
        centerTitle: true,
        backgroundColor: ColorName.bgColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.height,
              // customOption(
              //   onTap: () {}, text: "Theme",
              //   // actionText: Obx(() => AppTextStyle(text: ),
              // ),
              customOption(
                onTap: () {
                  Get.toNamed(Routes.LANGUAGE);
                },
                text: "Language",
              ),
              customOption(
                  onTap: () {
                    Get.toNamed(Routes.FORGOT_PASSWORD);
                  },
                  text: "Change Password"),
            ],
          ),
        ),
      ),
    );
  }
}
