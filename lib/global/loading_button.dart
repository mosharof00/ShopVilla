import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:shop_villa/gen/assets.gen.dart';
import 'package:shop_villa/gen/colors.gen.dart';

import 'app_text_style.dart';

Widget loadingButton({
  required VoidCallback onTap,
  required RoundedLoadingButtonController controller,
  required String text,
  Color? color,
  Color? fontColor,
  Color? valueColor,
  double? height,
  double? blurRadius,
  double? width,
  double? fontSize,
  FontWeight? fontWeight,
  double? borderRadius,
  LinearGradient? gradient,
  bool isImage = false,
  String? image,
}) {
  return RoundedLoadingButton(
    height: height ?? 45.h,
    width: width ?? Get.width,
    controller: controller,
    valueColor: valueColor ?? Colors.black,
    color: color ?? ColorName.primaryColor,
    onPressed: onTap,
    borderRadius: borderRadius ?? 50.r,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isImage
            ? Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: SvgPicture.asset(
                  image ?? Assets.icons.googleIcon,
                  height: 18.h,
                  width: 18.w,
                ),
              )
            : const SizedBox.shrink(),
        Center(
          child: AppTextStyle(
            text: text,
            color: fontColor ?? Colors.white,
            fontSize: fontSize ?? 18.sp,
            fontWeight: fontWeight ?? FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}
