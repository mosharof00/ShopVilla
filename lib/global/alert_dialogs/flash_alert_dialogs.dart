import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/models/alert/alert_model.dart';
import 'package:shop_villa/global/methods/url_launcher.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import '../../app/services/local_store_config.dart';
import '../../gen/assets.gen.dart';
import '../../gen/colors.gen.dart';
import '../app_text_style.dart';
import '../cross_button.dart';
import '../global_button.dart';
import 'custom_alert_dialogs.dart';

class FlashAlertDialogs {
  static Future<void> orderOffAlert({
    required BuildContext context,
    required Alert alert,
  }) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Dialog(
              backgroundColor: Colors.transparent,
              child: Stack(
                children: [
                  SizedBox(
                    height: 320.h,
                    width: Get.width,
                    child: Container(
                      height: Get.height,
                      width: Get.width,
                      margin: EdgeInsets.all(25.r),
                      padding: EdgeInsets.all(20.r),
                      decoration: BoxDecoration(
                        color: ColorName.white,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        children: [
                          40.height,
                          AppTextStyle(
                            text: alert.title!.capitalize!,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          AppTextStyle(
                            text: alert.discount!,
                            color: Colors.red,
                            fontSize: 50.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          AppTextStyle(
                            text: alert.type!,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          10.height,
                          globalButton(
                            onTap: () {
                              HiveService.setAlertShowed(true);
                              Get.back();
                              UrlLauncher.url(alert.link!);
                            },
                            text: 'Get it',
                            height: 30.h,
                            width: 80.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(200.r),
                        child: Image.asset(
                          Assets.images.giftBoxOpenGif.path,
                          height: 90.h,
                          width: 90.w,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0.h,
                    right: 0.w,
                    child: crossButton(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      iconColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }


  //

  static Future flashSaleAlert({required BuildContext context}) {
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
                    height: 300.h,
                    width: Get.width,
                    child: Container(
                      // clipBehavior: Clip.none,
                      height: Get.height,
                      width: Get.width,
                      margin: EdgeInsets.all(25.r),
                      decoration: BoxDecoration(
                        color: ColorName.white,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Container(
                        height: Get.height,
                        width: Get.width,
                        padding: EdgeInsets.all(15.r),
                        decoration: BoxDecoration(
                          color: ColorName.primaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Column(
                          children: [
                            75.height,
                            // Image.asset(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(
                                  Assets.icons.congratsLeftIcon,
                                  height: 25.h,
                                  width: 25.w,
                                ),
                                AppTextStyle(
                                  text: "Flash Sale Alert!",
                                  color: ColorName.primaryColor,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                SvgPicture.asset(
                                  Assets.icons.congratsRightIcon,
                                  height: 25.h,
                                  width: 25.w,
                                ),
                              ],
                            ),
                            10.height,

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppTextStyle(
                                  text: "Get",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                10.width,
                                AppTextStyle(
                                  text: "30%",
                                  color: Colors.green,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                10.width,
                                AppTextStyle(
                                  text: "off all time in",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                            5.height,
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
                              format: CountDownTimerFormat.hoursMinutesSeconds,
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
                                onTap: () {
                                  Get.back();
                                },
                                text: 'Get it',
                                height: 30.h,
                                width: 80.w)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(100),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.r),
                        child: Image.asset(
                          Assets.images.flashImage.path,
                          height: 100.h,
                          width: 100.w,
                        ),
                      ),
                    )
                  ]),
                  Positioned(
                    top: 0.h,
                    right: 0.w,
                    child: crossButton(
                        onTap: () {
                          Get.back();
                        },
                        iconColor: Colors.white,
                        bgColor: ColorName.primaryColor.withOpacity(0.3)),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  static Future customFlashSaleAlert({required BuildContext context}) {
    return customAlertDialog(
      context: context,
      height: 300.h,
      // headerWidget: SizedBox(),
      backgroundImage: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage(Assets.images.backgroundImage.path),
        // colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)
      ),
      titleWidget: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppTextStyle(
            text: "Get",
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          10.width,
          AppTextStyle(
            text: "30%",
            color: Colors.yellow,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
          10.width,
          AppTextStyle(
            text: "off all time in",
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ],
      ),
      crossButton: crossButton(onTap: () {
        Get.back();
      }),
    );
  }
}
