import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/round_color_button_container.dart';

class LogOutBottomSheet {
  static void show(
      BuildContext context, VoidCallback btnLogOut, VoidCallback btnCancel) {
    showModalBottomSheet(
      backgroundColor: ColorName.white,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 220.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.r),
              topLeft: Radius.circular(30.r),
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                5.height,
                SvgPicture.asset(
                  Assets.images.logout,
                  width: 60.w,
                  height: 70.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: AppTextStyle(
                    text: 'Log Out Account',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: AppTextStyle(
                    text: 'Are you sure, you want to log out?',
                    fontSize: 14.sp,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AppRoundColorButton(
                      height: 40.h,
                      width: Get.width / 3,
                      onTap: btnCancel,
                      borderRadius: 30.r,
                      text: 'Cancel',
                      textColor: ColorName.black,
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [ColorName.white, ColorName.white],
                      ),
                    ),
                    AppRoundColorButton(
                      height: 40.h,
                      width:  Get.width / 3,
                      onTap: btnLogOut,
                      borderRadius: 30.r,
                      text: 'LogOut',
                      textColor: ColorName.white,
                      btnColor: ColorName.crimsonRed,
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [ColorName.crimsonRed, ColorName.crimsonRed],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
