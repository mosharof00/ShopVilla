import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shop_villa/appConfig.dart';
import 'package:shop_villa/gen/colors.gen.dart';
import 'package:shop_villa/global/loading_button.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../global/app_input_textformfield.dart';
import '../../../../global/app_text_style.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
        Get.put(ForgotPasswordController());
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_sharp),
        ),
        title: SvgPicture.asset(
          AppConfig.appLogo,
          height: 30.h,
          colorFilter:
              const ColorFilter.mode(ColorName.primaryColor, BlendMode.srcIn),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AppTextStyle(
                  text: 'Forgot Password?',
                  fontSize: 22.sp,
                  maxLines: 2,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.start,
                ),
                10.width,
                SvgPicture.asset(
                  Assets.icons.keyIcon,
                  height: 20.h,
                  width: 20.w,
                )
              ],
            ),
            5.height,
            AppTextStyle(
              text:
                  "We've got you covered. Enter your registered email to reset your password. Will will send an OTP code to your email for the next steps.",
              textAlign: TextAlign.left,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
            40.height,
            AppTextStyle(
              text: 'Your Registered Email',
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            5.height,
            AppInputTextFormField(
              controller: controller.emailController,
              // prefixIcon: Icon(Icons.person),
              keyboardType: TextInputType.emailAddress,
              prefixIcon: SvgPicture.asset(
                Assets.icons.emailIcon,
                width: 12.w,
                height: 12.h,
              ),
              hintText: 'Email',
            ),
            Obx(() => Visibility(
                  visible: controller.emailError.isNotEmpty,
                  child: AppTextStyle(
                    text: controller.emailError.value,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorName.crimsonRed,
                  ),
                )),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: loadingButton(
            text: 'Send OTP Code',
            controller: controller.btnController,
            onTap: () {
              if (controller.validateInputs()) {
                controller.sendOTP(
                  email: controller.emailController.text.toString(),
                );
              } else {
                controller.btnController.stop();
              }
            }),
      ),
    );
  }
}
