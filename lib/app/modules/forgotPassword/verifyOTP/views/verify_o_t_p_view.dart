import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:shop_villa/appConfig.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../gen/fonts.gen.dart';
import '../../../../../global/app_text_style.dart';
import '../controllers/verify_o_t_p_controller.dart';

class VerifyOTPView extends GetView<VerifyOTPController> {
  const VerifyOTPView({super.key});
  @override
  Widget build(BuildContext context) {
    /// for pinput design
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20.sp,
          color: Colors.black,
          fontFamily: FontFamily.lato,
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(20.r),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: ColorName.primaryColor),
      borderRadius: BorderRadius.circular(10.r),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color(0xFFe9ecef),
      ),
    );
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
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
                  text: 'Enter OTP Code',
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.start,
                ),
                10.width,
                SvgPicture.asset(
                  Assets.icons.keyLockIcon,
                  height: 20.h,
                  width: 20.w,
                )
              ],
            ),
            5.height,
            AppTextStyle(
              text:
                  "Please check your email inbox for a message from shop_villa. Enter the one-time verification code bellow.",
              textAlign: TextAlign.left,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
            40.height,
            Align(
              alignment: Alignment.center,
              child: Obx(() {
                final token = controller.token
                    .toString(); // for only just handle "[Get] the improper use of a GetX has been detected." this exception
                debugPrint(token);
                return  Pinput(
                  length: 6,
                  controller: controller.otpController,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onCompleted: (pin) {
                    controller.onComplete(pin);
                  },
                );
              }),
            ),
            5.height,
            Obx(
              () => AppTextStyle(
                text: controller.errorMessage.value == " "
                    ? " "
                    : controller.errorMessage.value,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
            20.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppTextStyle(
                  text: "You can resend the code in ",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
                5.width,
                Obx(() {
                  if (controller.isRefreshed.value == true) {
                    return TimerCountdown(
                      spacerWidth: 3,
                      timeTextStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                        color: const Color(0xFF00FF00),
                      ),
                      colonsTextStyle: TextStyle(
                        color: Colors.white, // Replace with ColorName.white
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                      enableDescriptions: false,
                      format: CountDownTimerFormat.secondsOnly,
                      endTime: DateTime.now().add(const Duration(minutes: 1)),
                      onEnd: () {
                        controller.code.value = 0;
                        controller.isRefreshed.value = false;
                      },
                    );
                  } else {
                    return AppTextStyle(
                      text: '00',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF00FF00),
                    );
                  }
                }),
                5.width,
                AppTextStyle(
                  text: "seconds",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: Obx(() {
                if (controller.isRefreshed.value == false) {
                  return TextButton(
                    onPressed: controller.resendOTP,
                    child: AppTextStyle(
                      text: 'Resend Code',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorName.primaryColor,
                    ),
                  );
                } else {
                  return TextButton(
                    onPressed: () {},
                    child: AppTextStyle(
                      text: 'Resend code',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                    ),
                  );
                }
              }),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(20),
      //   child: globalButton(onTap: controller.verifyOTP, text: 'Verify'),
      // ),
    );
  }
}
