import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';

class ProductLabels extends StatelessWidget {
  const ProductLabels(
      {super.key,
      required this.text,
      this.height,
      this.width,
      this.containerColor,
      this.fontWeight,
      this.fontSize});
  final String text;
  final double? height;
  final double? width;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? containerColor;
  @override
  Widget build(BuildContext context) {
    return LabelContainer(
        // containerHeight: height ?? 25,
        // containerWidth: width ?? 70,
        labelTitle: text,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontSize: fontSize ?? 10.sp,
        containerColor: text == 'due' ||
                text == 'Due' ||
                text == 'Canceled' ||
                text == 'canceled'
            ? ColorName.crimsonRed.withOpacity(0.5)
            : containerColor ?? ColorName.green);
  }
}

Widget labels(
    {String? text,
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLines}) {
  return AppTextStyle(
    text: text!,
    maxLines: maxLines,
    textAlign: textAlign,
    fontWeight: fontWeight ?? FontWeight.w600,
    fontSize: fontSize ?? 10.sp,
    color: color ?? ColorName.black,
  );
}

class LabelContainer extends StatelessWidget {
  const LabelContainer(
      {super.key,
      this.containerHeight,
      this.containerWidth,
      required this.labelTitle,
      this.fontSize,
      this.fontWeight,
      required this.containerColor});
  final double? containerHeight;
  final double? containerWidth;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color containerColor;
  final String labelTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: containerWidth ?? 70.w,
      // height: containerHeight ?? 25.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: containerColor,
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
        child: Center(
          child: labels(
              text: labelTitle, color: ColorName.white, fontSize: fontSize),
        ),
      ),
    );
  }
}
