import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/modules/profile/controllers/profile_controller.dart';
import 'package:shop_villa/app/repository/api_endpoint.dart';
import 'package:shop_villa/app/routes/app_pages.dart';
import 'package:shop_villa/global/loading_animation_widget.dart';
import 'package:shop_villa/global/methods/url_launcher.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import 'package:shop_villa/helper/appbar_title.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../global/custom_option.dart';
import '../controllers/help_and_support_controller.dart';

class HelpAndSupportView extends GetView<HelpAndSupportController> {
  const HelpAndSupportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find();
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        title: appbarTitle(text: 'Help & Support'),
        centerTitle: true,
        backgroundColor: ColorName.bgColor,
      ),
      body: Obx(() {
        if (profileController.adminInfo.isEmpty) {
          return loadingAnimationWidget();
        } else {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.height,
                  customOption(
                    onTap: () {
                      UrlLauncher.url('${ApiEndpoint.domainUrl}/faq');
                    },
                    text: "FAQ",
                  ),
                  customOption(
                    onTap: () {
                      UrlLauncher.url(
                          '${ApiEndpoint.domainUrl}/link/privacy-policy');
                    },
                    text: "Privacy Policy",
                  ),
                  customOption(
                    onTap: () {
                      UrlLauncher.url('${ApiEndpoint.domainUrl}/contact');
                    },
                    text: "Contact",
                  ),
                  customOption(
                    onTap: () {
                      UrlLauncher.url(ApiEndpoint.domainUrl);
                    },
                    text: "About us",
                  ),
                  customOption(
                    onTap: () {
                      UrlLauncher.url(ApiEndpoint.domainUrl);
                    },
                    text: "Rate us",
                  ),
                  customOption(
                    onTap: () {
                      UrlLauncher.url(ApiEndpoint.domainUrl);
                    },
                    text: "Visit Our Website ",
                  ),
                  customOption(
                    onTap: () async {
                      Get.toNamed(
                        Routes.CHATS,
                        arguments: {
                          'uniqueId': profileController.adminInfo[0].uniqueId,
                        },
                      );
                    },
                    text: "Customer Support",
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
