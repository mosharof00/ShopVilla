import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import '../../gen/colors.gen.dart';
import '../app_text_style.dart';

Future successBottomSheet({required BuildContext context, String? text, IconData? icons, Color? iconColor}) {
  return showModalBottomSheet(
    useSafeArea: true,
    context: (context),
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            5.height,
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 2.h,
                width: 35.w,
                color: Colors.grey.shade300,
              ),
            ),
            15.height,
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 50.h,
                width: 50.w,
                decoration: const BoxDecoration(
                    color: ColorName.primaryColor, shape: BoxShape.circle),
                child: Center(
                  child: Icon(
                    icons ?? Icons.done,
                    color: iconColor ?? Colors.white,
                    size: 30.sp,
                  ),
                ),
              ),
            ),
            20.height,
            AppTextStyle(
              text: text?.tr ?? 'Order Canceled Successfully!',
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
            ),
            20.height,
          ],
        ),
      );
    },
  );
}
