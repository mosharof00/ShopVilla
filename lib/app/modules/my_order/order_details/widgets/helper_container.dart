import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa/global/app_text_style_over_flow.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../global/app_text_style.dart';
import '../../../../../global/divider.dart';

Widget helperContainer(
    {required Widget icon,
      required String text,
      required Widget leading,
      required String titleText,
      required String subtitleText,
      double? containerHeight,
      double? containerWidth,
      VoidCallback? onPressed,
      Widget? trailWidget,
      required bool isTrailing,
      Color? borderColor,
      bool? showIcon}) {
  return InkWell(
    onTap: onPressed,
    borderRadius: BorderRadius.circular(15.r),
    child: Container(
      width: containerWidth ?? Get.width,
      height: containerHeight,
      decoration: BoxDecoration(
        color: ColorName.white,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: borderColor ?? Colors.transparent)
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
                showIcon == true
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
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(child: leading),
            ),
            title: Align(
              alignment: Alignment.bottomLeft,
              child: AppTextStyle(
                text: titleText,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.start,
              ),
            ),
            subtitle: subtitleText != '' ? Align(
              alignment: Alignment.bottomLeft,
              child: AppTextStyleOverFlow(
                maxLines: 2,
                text: subtitleText,
                color: Colors.grey,
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
              ),
            ) : const SizedBox.shrink(),
            trailing: isTrailing
                ? trailWidget
                : const SizedBox.shrink(),
          ),
        ],
      ),
    ),
  );
}

Widget summaryOptionsRow({
  required String leadingText,
  required String thrillingText,
  Widget? thrillingIcon,
  Color? leadingTextColor,
  Color? thrillingTextColor,
  double? fontSizeLeadingText,
  FontWeight? fontWeightLeadingText,
  double? fontSizeThrillingText,
  FontWeight? fontWeightThrillingText,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      AppTextStyle(
        text: leadingText,
        color: leadingTextColor ?? Colors.black,
        fontWeight: fontWeightLeadingText ?? FontWeight.w500,
        fontSize: fontSizeLeadingText ?? 14.sp,
      ),
      const Spacer(),
      AppTextStyle(
        text: thrillingText,
        color: thrillingTextColor ?? Colors.black,
        fontWeight: fontWeightThrillingText ?? FontWeight.w500,
        fontSize: fontSizeThrillingText ?? 15.sp,
      ),
      5.width,
      thrillingIcon ?? 0.width
    ],
  );
}