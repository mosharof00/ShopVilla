import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../gen/colors.gen.dart';
import 'app_linear_gradient.dart';
import 'app_text_style.dart';

Widget globalButton({
  required VoidCallback onTap,
  required String text,
  Color? shadowColor,
  double? height,
  double? blurRadius,
  double? width,
  double? fontSize,
  FontWeight? fontWeight,
  BorderRadius? borderRadius,
  LinearGradient? gradient,
  Color? color,
  Color? fontColor,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: borderRadius ?? BorderRadius.circular(50.r),
    child: Container(
      height: height ?? 45.h,
      width: width ?? Get.width,
      decoration: BoxDecoration(
        color: color ?? ColorName.primaryColor,
        gradient: gradient ?? appLinearGradient(),
        borderRadius: borderRadius ?? BorderRadius.circular(50.r),
        boxShadow: [
          BoxShadow(
            color: shadowColor ?? ColorName.primaryColor,
            blurRadius: blurRadius ?? 2,
            offset: const Offset(0, 1),
            spreadRadius: 0,
          )
        ],
      ),
      child: Center(
        child: AppTextStyle(
          text: text,
          color:  fontColor ?? Colors.white ,
          fontSize: fontSize ?? 18.sp,
          maxLines: 1,
          fontWeight: fontWeight ?? FontWeight.w600,
        ),
      ),
    ),
  );
}
