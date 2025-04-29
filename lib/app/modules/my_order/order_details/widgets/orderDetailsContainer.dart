import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';

import '../../../../../gen/colors.gen.dart';
import '../../../../../global/app_text_style.dart';
import '../../../../../global/divider.dart';


Widget orderDetailsContainer({
  required Widget icon,
  required String text,
  required Widget leading,
  String? firstTitleTextKey,
  required String firstTitleTextValue,
  String? secondTitleTextKey,
  required String secondTitleTextValue,
  String? subtitleTextKey,
  required String subtitleTextValue,
  double? containerHeight,
  double? containerWidth,
  VoidCallback? onPressed,
  Widget? trailWidget,
  Color? borderColor,
  VoidCallback? onTap,
  double? firstFontSize,
  FontWeight? firstFontWeight,
  double? secondFontSize,
  FontWeight? secondFontWeight,
  Color? firstFontColor,
  Color? secondFontColor,
  required bool isTrailing,
}) {
  return GestureDetector(
    onTap: isTrailing ? onTap : () {},
    child: Container(
      width: containerWidth ?? Get.width,
      height: containerHeight,
      decoration: BoxDecoration(
        color: ColorName.white,
        border: Border.all(
          color: borderColor ?? Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(10.r),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                5.width,
                icon,
                10.width,
                AppTextStyle(
                  text: text,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
                const Spacer(),
                isTrailing
                    ? const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 20,
                      )
                    : 0.width,
              ],
            ),
          ),
          customDivider(),
          ListTile(
            leading: Container(
              height: 45.h,
              width: 45.w,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: Center(child: leading),
            ),
            title: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  keyWithValueText(
                    firstTitleTextKey ?? '',
                    firstTitleTextValue,
                    firstFontSize,
                    firstFontWeight,
                    firstFontColor,
                  ),
                  3.height,
                  keyWithValueText(
                    secondTitleTextKey ?? '',
                    secondTitleTextValue,
                    secondFontSize,
                    secondFontWeight,
                    secondFontColor,
                  ),
                ],
              ),
            ),
            subtitle: subtitleTextKey != ''
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextStyle(
                          maxLines: 1,
                          text: subtitleTextKey ?? '',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.start,
                        ),
                        5.width,
                        Expanded(
                          child: AppTextStyle(
                            text: subtitleTextValue,
                            textAlign: TextAlign.start,
                            fontSize: 13.sp,
                            color: secondFontColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    ),
  );
}

Widget keyWithValueText(String keyText, String valueText, double? fontSize,
    FontWeight? fontWeight, Color? color) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppTextStyle(
        text: keyText,
        fontSize: fontSize ?? 12.sp,
        fontWeight: fontWeight ?? FontWeight.w400,
        textAlign: TextAlign.start,
        color: color,
      ),
      5.width,
      Expanded(
        child: AppTextStyle(
          text: valueText,
          fontSize: fontSize ?? 13.sp,
          maxLines: 1,
          fontWeight: fontWeight ?? FontWeight.w500,
          textAlign: TextAlign.start,
          color: color,
        ),
      ),
    ],
  );
}


// Widget customDivider({
//   Color? color,
//   double? paddingHorizontal}) {
//   return Padding(
//     padding: EdgeInsets.symmetric(horizontal: paddingHorizontal ?? 10.w),
//     child: Divider(
//       color: color ?? Colors.pink.shade50,
//     ),
//   );
// }
