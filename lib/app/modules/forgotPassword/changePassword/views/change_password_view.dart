import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shop_villa/appConfig.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../global/app_input_textformfield.dart';
import '../../../../../global/app_text_style.dart';
import '../../../../../global/loading_button.dart';
import '../../../../../helper/log_printer.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    Log.i(controller.token);
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        leading: IconButton(
            onPressed: () {
              Get.toNamed(Routes.FORGOT_PASSWORD);
            },
            icon: const Icon(Icons.arrow_back_sharp)),
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
                  text: 'Secure Your Account',
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            5.height,
            AppTextStyle(
              text:
                  'Create a new password for shop_villa account to keep it secure. Remember to choose a strong and unique password.',
              textAlign: TextAlign.left,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
            40.height,
            AppTextStyle(
              text: 'Create new password',
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            5.height,
            Obx(
              () => AppInputTextFormField(
                controller: controller.newPasswordController,
                maxLines: 1,
                hintText: 'Password',
                obscureText: controller.hidePassword.value,
                prefixIcon: SvgPicture.asset(
                  Assets.icons.lockIcon,
                  width: 18.w,
                  height: 17.h,
                ),
                suffixIcon: controller.hidePassword.value
                    ? InkWell(
                        onTap: () {
                          controller.hidePassword.value = false;
                        },
                        child: SvgPicture.asset(
                          Assets.icons.inVisibleEyeIcon,
                          width: 10.w,
                          height: 10.h,
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          controller.hidePassword.value = true;
                        },
                        child: SvgPicture.asset(
                          Assets.icons.visibleEyeIcon,
                          width: 10.w,
                          height: 10.h,
                        ),
                      ),
              ),
            ),
            Obx(() => Visibility(
                  visible: controller.passwordTextInputError.isNotEmpty,
                  child: AppTextStyle(
                    text: controller.passwordTextInputError.value,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorName.crimsonRed,
                  ),
                )),
            25.height,
            AppTextStyle(
              text: 'Confirm new password',
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            5.height,
            Obx(
              () => AppInputTextFormField(
                controller: controller.confirmNewPasswordController,
                maxLines: 1,
                hintText: 'Confirm new password',
                obscureText: controller.hideConfirmPassword.value,
                prefixIcon: SvgPicture.asset(
                  Assets.icons.lockIcon,
                  width: 18.w,
                  height: 17.h,
                ),
                suffixIcon: controller.hideConfirmPassword.value
                    ? InkWell(
                        onTap: () {
                          controller.hideConfirmPassword.value = false;
                        },
                        child: SvgPicture.asset(
                          Assets.icons.inVisibleEyeIcon,
                          width: 10.w,
                          height: 10.h,
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          controller.hideConfirmPassword.value = true;
                        },
                        child: SvgPicture.asset(
                          Assets.icons.visibleEyeIcon,
                          width: 10.w,
                          height: 10.h,
                        ),
                      ),
              ),
            ),
            Obx(() => Visibility(
                  visible: controller.passwordTextInputError.isNotEmpty,
                  child: AppTextStyle(
                    text: controller.passwordTextInputError.value,
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
                controller.changePassword(context);
              } else {
                controller.btnController.stop();
              }
            }),
      ),
    );
  }
}
