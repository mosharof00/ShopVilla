import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_villa/gen/colors.gen.dart';

import '../app_text_style.dart';

Future customBottomSheet(
    {required BuildContext context,
    required VoidCallback onTap1,
    required String svgIcon1,
    required String text1,
    required VoidCallback onTap2,
    required String svgIcon2,
    required String text2,
    double? icon1Height,
    double? icon1Width,
    double? icon2Height,
    double? icon2Width}) {
  return showModalBottomSheet(
    context: context,
    useSafeArea: true,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.all(15.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: onTap1,
              child: Row(children: [
                Container(
                  height: 35.h,
                  width: 35.w,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 3,
                        offset: Offset(0.50, 1),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      svgIcon1,
                      height: icon1Height ?? 20.h,
                      width: icon1Width ?? 20.w,
                      colorFilter: const ColorFilter.mode(
                          ColorName.primaryColor, BlendMode.srcIn),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30.w,
                ),
                AppTextStyle(
                  text: text1,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ]),
            ),
            TextButton(
              onPressed: onTap2,
              child: Row(children: [
                Container(
                  height: 35.h,
                  width: 35.w,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 3,
                        offset: Offset(0.50, 1),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      svgIcon2,
                      height: icon2Height ?? 20.h,
                      width: icon2Width ?? 20.w,
                    ),
                  ),
                ),
                SizedBox(
                  width: 30.w,
                ),
                AppTextStyle(
                  text: text2,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ]),
            )
          ],
        ),
      );
    },
  );
}


