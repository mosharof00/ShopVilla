import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import 'app_text_style.dart';

Widget signInOption(
    {required VoidCallback onTap, required String icon, required String text}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(50.r),
    child: Container(
      height: 40.h,
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          border: Border.all(color: const Color(0xFFdee2e6), width: 1.w)),
      child: Row(
        children: [
          10.width,
          SvgPicture.asset(
            icon,
            width: 25.w,
          ),
          Expanded(
            child: AppTextStyle(
              text: text,
              textAlign: TextAlign.center,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          30.width
        ],
      ),
    ),
  );
}
