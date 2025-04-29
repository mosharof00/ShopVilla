import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa/gen/colors.gen.dart';
import 'package:shop_villa/global/app_text_style.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import '../../../../../global/custom_option.dart';
import '../controllers/account_and_security_controller.dart';

class AccountAndSecurityView extends GetView<AccountAndSecurityController> {
  const AccountAndSecurityView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorName.bgColor,
        appBar: AppBar(
          title: const AppTextStyle(text: 'Account & Security'),
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
                customOFFONOption(text: "Biometric ID", onChanged: (value) {}),
                customOFFONOption(text: "Face ID", onChanged: (value) {}),
                customOFFONOption(
                    text: "SMS Authentication", onChanged: (value) {}),
                customOFFONOption(
                    text: "Google Authentication",initialValue: true, onChanged: (value) {}),
                customOption(onTap: () {}, text: "Change Password"),
                customOption(onTap: () {}, text: "Device Management"),
                customOption(onTap: () {}, text: "Deactivate Account"),
                customOption(
                    onTap: () {},
                    text: "Delete Account",
                    textColor: Colors.red),
              ],
            ),
          ),
        ));
  }
}
