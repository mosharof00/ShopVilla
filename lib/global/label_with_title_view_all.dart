import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import 'app_text_style.dart';

class TitleWithViewAllWidget extends StatelessWidget {
  const TitleWithViewAllWidget({
    super.key,
    required this.title,
    this.viewAll,
    this.onTap,
    this.topPadding,
    this.btnColor,
    this.viewAllFontSize,
    this.viewAllFontWeight,
    this.titlefontSize,
    this.textAlign,
    this.paddingLeft,
    this.paddingTop,
  });
  final String title;
  final String? viewAll;
  final VoidCallback? onTap;
  final double? topPadding;
  final Color? btnColor;
  final double? viewAllFontSize;
  final double? paddingLeft;
  final double? paddingTop;
  final double? titlefontSize;
  final TextAlign? textAlign;
  final FontWeight? viewAllFontWeight;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: paddingLeft ?? 8.0, top: paddingTop ?? 8),
          child: AppTextStyle(
            text: title,
            textAlign: textAlign,
            fontSize: titlefontSize ?? 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppTextStyle(
                text: viewAll ?? "View All",
                fontSize: viewAllFontSize ?? 12.sp,
                fontWeight: viewAllFontWeight ?? FontWeight.w600,
                color: btnColor,
              ),
              3.width,
              Icon(
                Icons.arrow_forward_rounded,
                color: btnColor,
              ),
              5.width
            ],
          ),
        ),
      ],
    );
  }
}
