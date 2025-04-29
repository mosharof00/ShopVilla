import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';

import '../../../../../global/app_text_style.dart';

Widget customOption(
    {required VoidCallback onTap,
      required String text,
      Color? textColor,
      Widget? actionText}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 15.h),
    child: TextButton(
      onPressed: onTap,
      child: Row(
        children: [
          AppTextStyle(
            text: text,
            color: textColor ?? Colors.black,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
          const Spacer(),
          actionText ?? const AppTextStyle(text: ''),
          10.width,
          Icon(
            Icons.arrow_forward_ios_sharp,
            size: 17.sp,
          )
        ],
      ),
    ),
  );
}

Widget customOFFONOption(
    {required String text,
    Function(dynamic)? onChanged,
    bool? initialValue,
    Color? textColor,
    Widget? actionText}) {
  final localController = ValueNotifier<bool>(initialValue ?? false);
  return Padding(
    padding: EdgeInsets.only(bottom: 25.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppTextStyle(
          text: text,
          color: textColor ?? Colors.black,
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
        ),
        AdvancedSwitch(
          controller: localController,
          activeColor: Colors.green,
          inactiveColor: Colors.grey,
          // activeChild: const Text('ON'),
          // inactiveChild: const Text('OFF'),
          borderRadius: BorderRadius.all(Radius.circular(15.r)),
          width: 40.w,
          height: 20.h,
          enabled: true,
          disabledOpacity: 0.5,
          initialValue: initialValue ?? false,
          onChanged: onChanged,
        ),
      ],
    ),
  );
}
