import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:get/get.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import '../../gen/assets.gen.dart';
import '../../gen/colors.gen.dart';
import '../app_text_style.dart';
import '../global_button.dart';

Future customAlertDialog({
  required BuildContext context,
  required Widget crossButton,
  double? height,
  double? width,
  Color? bgColor,
  DecorationImage? backgroundImage,
  BorderRadius? borderRadius,
  Widget? headerBgImage,
  Widget? headerWidget,
  Widget? titleWidget,
  String? titleText,
  double? titleFontSize,
  FontWeight? titleFontWeight,
  Widget? subTitleWidget,
  VoidCallback? onTap,
  String? buttonText,
}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Dialog(
              backgroundColor: Colors.transparent,
              child: Stack(
                // clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    height: height ?? 310.h,
                    width: width ?? Get.width,
                    child: Padding(
                      padding: EdgeInsets.all(20.r),
                      child: Container(
                        height: Get.height,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: bgColor ?? Colors.white,
                          borderRadius:
                              borderRadius ?? BorderRadius.circular(20.r),
                          image:backgroundImage ?? DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(Assets.images.backgroundImage.path),
                            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)

                          ),
                        ),
                        child: Container(
                          height: Get.height,
                          width: Get.width,
                          decoration: BoxDecoration(
                            // color: ColorName.primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Stack(children: [
                                headerBgImage ??
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20.r),
                                      child: Image.network(
                                        "https://img.pikbest.com/background/20220119/black-friday-gold-gift-box-e-commerce-background_6225317.jpg!w700wp",
                                        width: Get.width,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                Positioned(
                                  top: 50.h,
                                  bottom: 50.h,
                                  left: 50.w,
                                  right: 50.w,
                                  child: headerWidget ??
                                      AppTextStyle(
                                        text: "Flash Sale Alert!",
                                        color: ColorName.white,
                                        textAlign: TextAlign.center,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                )
                              ]),
                              10.height,
                              titleWidget ??
                                  AppTextStyle(
                                    text: titleText ?? "Get 30",
                                    fontSize: titleFontSize ?? 14.sp,
                                    fontWeight:
                                        titleFontWeight ?? FontWeight.w500,
                                  ),
                              10.height,
                              subTitleWidget ??
                                  TimerCountdown(
                                    spacerWidth: 5,
                                    timeTextStyle: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18.sp,
                                      color: Colors.red,
                                    ),
                                    colonsTextStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.sp,
                                    ),
                                    enableDescriptions: false,
                                    format: CountDownTimerFormat
                                        .hoursMinutesSeconds,
                                    endTime: DateTime.now().add(
                                      const Duration(
                                        days: 1,
                                        hours: 00,
                                        minutes: 00,
                                        seconds: 00,
                                      ),
                                    ),
                                    onEnd: () {
                                      if (kDebugMode) {
                                        print("Timer finished");
                                      }
                                    },
                                  ),
                              20.height,
                              globalButton(
                                onTap: onTap ??
                                    () {
                                      Get.back();
                                    },
                                text: buttonText ?? 'Get it',
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp,
                                height: 30.h,
                                width: 80.w,
                                shadowColor: Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(top: 0.h, right: 0.w, child: crossButton)
                ],
              ),
            ),
          ],
        );
      });
}
