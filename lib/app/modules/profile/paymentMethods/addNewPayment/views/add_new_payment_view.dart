import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:shop_villa/gen/colors.gen.dart';
import 'package:shop_villa/global/app_text_style.dart';
import 'package:shop_villa/global/global_button.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../global/app_input_textformfield.dart';
import '../controllers/add_new_payment_controller.dart';

class AddNewPaymentView extends GetView<AddNewPaymentController> {
  const AddNewPaymentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        title: const AppTextStyle(text: 'Add New Payment'),
        centerTitle: true,
        backgroundColor: ColorName.bgColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.height,
            AppTextStyle(
              text: 'Card Number',
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            5.height,
            AppInputTextFormField(
              // prefixIcon: Icon(Icons.person),
              prefixIcon: SvgPicture.asset(
                Assets.icons.numberIcon,
                width: 12.w,
                height: 12.h,
              ),
              hintText: 'Number',
            ),
            30.height,
            AppTextStyle(
              text: 'Account Holder Name',
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            5.height,
            AppInputTextFormField(
              // prefixIcon: Icon(Icons.person),
              prefixIcon: SvgPicture.asset(
                Assets.icons.numberIcon,
                width: 12.w,
                height: 12.h,
              ),
              hintText: 'Name',
            ),
            50.height,
            const Divider(),
            AppTextStyle(
              text: "Supported Payments",
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            10.height,
            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: Image.asset(
                    Assets.images.bkashImage.path,
                    width: 35.w,
                    height: 35.h,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Image.asset(
                    Assets.images.nagadImage.path,
                    width: 40.w,
                    height: 40.h,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Image.asset(
                    Assets.images.rocketImage.path,
                    width: 32.w,
                    height: 32.h,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: SvgPicture.asset(
                    Assets.icons.googleIcon,
                    height: 30.h,
                    width: 30.w,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: SvgPicture.asset(
                    Assets.icons.appleIcon,
                    height: 30.h,
                    width: 30.w,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 26.w),
        child: globalButton(onTap: () {}, text: 'Save'),
      ),
    );
  }
}
