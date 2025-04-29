import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/routes/app_pages.dart';
import 'package:shop_villa/global/app_text_style_over_flow.dart';
import 'package:shop_villa/global/global_snackbar.dart';
import 'package:shop_villa/global/loading_button.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import '../../../../appConfig.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_input_textformfield.dart';
import '../../../../global/app_text_style.dart';
import '../../login/views/login_ui_helper.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        title: Image.asset(
          AppConfig.appLogo,
          height: 30.h,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AppTextStyle(
                    text: 'Join ${AppConfig.appName}',
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.start,
                  ),
                  15.width,
                  const Icon(
                    Icons.shopping_cart,
                    size: 30,
                  )
                ],
              ),
              const AppTextStyle(
                text: 'Embark on a Fashion Journey Tailored for You',
                color: Colors.grey,
              ),
              30.height,
              AppTextStyle(
                text: 'User Name',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              5.height,
              AppInputTextFormField(
                controller: controller.userNameController,
                prefixIcon: SvgPicture.asset(
                  Assets.icons.userIcon,
                  width: 17.w,
                  height: 16.h,
                ),
                hintText: 'Name',
              ),
              Obx(() => Visibility(
                    visible: controller.userNameError.isNotEmpty,
                    child: AppTextStyle(
                      text: controller.userNameError.value,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      color: ColorName.crimsonRed,
                    ),
                  )),
              15.height,
              Row(
                children: [
                  AppTextStyle(
                    text: 'Email',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              5.height,
              AppInputTextFormField(
                // prefixIcon: Icon(Icons.person),
                controller: controller.emailController,
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
              15.height,
              AppTextStyle(
                text: 'Password',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              5.height,
              Obx(
                () => AppInputTextFormField(
                  controller: controller.passwordController,
                  maxLines: 1,
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
                  hintText: 'Password',
                ),
              ),
              Obx(() => Visibility(
                    visible: controller.passwordError.isNotEmpty,
                    child: AppTextStyle(
                      text: controller.passwordError.value,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      color: ColorName.crimsonRed,
                    ),
                  )),
              15.height,
              AppTextStyle(
                text: 'Confirm Password',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              5.height,
              Obx(
                () => AppInputTextFormField(
                  controller: controller.confirmPasswordController,
                  maxLines: 1,
                  hintText: 'Confirm Password',
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
                    visible: controller.confirmPasswordError.isNotEmpty,
                    child: AppTextStyle(
                      text: controller.confirmPasswordError.value,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      color: ColorName.crimsonRed,
                    ),
                  )),
              10.height,
              Row(
                children: [
                  Obx(() {
                    if (controller.isAgree.value) {
                      return boxChecked(onTap: () {
                        controller.isAgree.value = false;
                      });
                    } else {
                      return boxUnChecked(onTap: () {
                        controller.isAgree.value = true;
                      });
                    }
                  }),
                  15.width,
                  AppTextStyle(
                    text: 'I agree to ${AppConfig.appName}',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  Expanded(
                    child: AppTextStyleOverFlow(
                      text: ' Terms & Conditions.',
                      color: ColorName.primaryColor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              10.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppTextStyle(
                    text: 'Already have an account?',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.LOGIN);
                    },
                    child: AppTextStyle(
                      text: 'Login',
                      color: ColorName.primaryColor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              25.height,
              orPart(),
              25.height,
              loadingButton(
                onTap: () {
                  controller.signInWithGoogle();
                },
                controller: controller.btnController,
                color: ColorName.white,
                fontColor: Colors.black,
                valueColor: ColorName.primaryColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                isImage: true,
                text: 'Continue with Google',
              ),
              30.height,
              Obx(() {
                if (controller.isAgree.value) {
                  return loadingButton(
                    valueColor: Colors.white,
                      onTap: () {
                        if (controller.validateInputs()) {
                          controller.registerUser(
                            name: controller.userNameController.text,
                            email: controller.emailController.text,
                            password: controller.passwordController.text,
                          );
                        } else {
                          controller.btnController.stop();
                        }
                      },
                      controller: controller.btnController,
                      text: 'Register');
                } else {
                  return disableButton(
                      onTap: () {
                        globalSnackBar(
                            title: "Please select the chick box",
                            message: "Please select the chick box",
                            snackPosition: SnackPosition.BOTTOM);
                      },
                      text: 'Register');
                }
              }),
              20.height
            ],
          ),
        ),
      ),
    );
  }
}
