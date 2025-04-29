import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../gen/assets.gen.dart';

class AppRoundColorButton extends StatelessWidget {
  const AppRoundColorButton(
      {super.key,
      this.width,
      this.height,
      this.text,
      this.textColor,
      this.fontSize,
      this.fontWeight,
      this.fontFamily,
      this.onTap,
      this.borderRadius,
      this.gradient,
      this.btnColor});
  final double? width;
  final double? height;
  final String? text;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final void Function()? onTap;
  final double? borderRadius;
  final Gradient? gradient;
  final Color? btnColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width?.w ?? 200.w,
        height: height?.h ?? 40.h,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: ShapeDecoration(
          color: btnColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text!.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontSize: fontSize?.sp ?? 16.sp,
                fontFamily: Assets.fonts.rundschriftPro,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
