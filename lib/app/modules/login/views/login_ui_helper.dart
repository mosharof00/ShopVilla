import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';

Widget disableButton({
  required VoidCallback onTap,
  required String text,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 45.h,
      width: Get.width,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment(0.00, -1.00),
          end: Alignment(0, 1),
          colors: [Color(0xFFcaf0f8), Color(0xFFade8f4)],
        ),
        borderRadius: BorderRadius.circular(50.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFade8f4),
// blurRadius: 5,
            offset: Offset(1, 2),
            spreadRadius: 0,
          )
        ],
      ),
      child: Center(
        child: AppTextStyle(
          text: text,
          color: ColorName.primaryColor,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

Widget boxChecked({required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 15.h,
      width: 15.w,
      decoration: BoxDecoration(
        color: ColorName.primaryColor,
        borderRadius: BorderRadius.circular(3.r),
      ),
      child: const Center(
        child: Icon(Icons.check, color: Colors.white, size: 15),
      ),
    ),
  );
}

Widget boxUnChecked({required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 15.h,
      width: 15.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.r),
        border: Border.all(width: 1.w, color: ColorName.primaryColor),
      ),
    ),
  );
}

Widget orPart() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(height: 1.h, width: 120.w, color: const Color(0xFFdee2e6)),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: AppTextStyle(
          text: 'Or',
          // color: Colors.grey,
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      Container(height: 1.h, width: 120.w, color: const Color(0xFFdee2e6)),
    ],
  );
}
