import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/modules/register/controllers/register_controller.dart';
import 'package:shop_villa/app/routes/app_pages.dart';
import 'package:shop_villa/gen/assets.gen.dart';
import 'package:shop_villa/gen/colors.gen.dart';
import 'package:shop_villa/global/app_text_style.dart';
import 'package:shop_villa/global/loading_button.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import 'package:shop_villa/helper/helper_utils.dart';
import '../../../../appConfig.dart';
import '../../../../global/app_input_textformfield.dart';
import '../controllers/login_controller.dart';
import 'login_ui_helper.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    final registerController = Get.put(RegisterController());
    HelperUtils.deletePermanentController();
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar:AppBar(
      backgroundColor: ColorName.bgColor,
      toolbarHeight: 150,
      automaticallyImplyLeading: false,
      title: Image.asset(
        AppConfig.appLogo,
        height: 130.h,
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
              AppTextStyle(
                text: 'Welcome \nBack!',
                fontSize: 30.sp,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.start,
              ),
              30.height,
              AppTextStyle(
                text: 'Email',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              5.height,
              AppInputTextFormField(
                controller: controller.emailEditingController,
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
                  controller: controller.passEditingController,
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
              10.height,
              Row(
                children: [
                  Obx(() {
                    if (controller.boxCheck.value) {
                      return boxUnChecked(onTap: () {
                        controller.boxCheck.value = false;
                      });
                    } else {
                      return boxChecked(onTap: () {
                        controller.boxCheck.value = true;
                      });
                    }
                  }),
                  10.width,
                  AppTextStyle(
                    text: 'Remember Me',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.FORGOT_PASSWORD);
                    },
                    child: AppTextStyle(
                      text: 'Forgot Password?',
                      color: ColorName.primaryColor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              25.height,
              orPart(),
              25.height,
              loadingButton(
                onTap: () {
                  registerController.signInWithGoogle();
                },
                controller: registerController.btnController,
                color: ColorName.white,
                fontColor: Colors.black,
                valueColor: ColorName.primaryColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                isImage: true,
                text: 'Continue with Google',
              ),
              30.height,
              loadingButton(
                valueColor: Colors.white,
                  onTap: () {
                    if (controller.validateInputs()) {
                      controller.loginUser(
                        email: controller.emailEditingController.text,
                        password: controller.passEditingController.text,
                      );
                    } else {
                      controller.btnController.stop();
                    }
                  },
                  controller: controller.btnController,
                  text: "Login"),
              15.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppTextStyle(
                    text: "Don't have an account?",
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.REGISTER);
                    },
                    child: AppTextStyle(
                      text: 'Register',
                      color: ColorName.primaryColor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
