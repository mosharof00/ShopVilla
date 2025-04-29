import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';

import '../gen/assets.gen.dart';
import 'app_text_style.dart';

class ServerErrorWidget extends StatelessWidget {
  const ServerErrorWidget(
      {super.key,
      this.title,
      this.message,
      this.onTap,
      this.buttonText,
      this.svgImagePath,
      this.iconHeight,
      this.iconWidth});
  final String? svgImagePath;
  final String? title;
  final String? message;
  final String? buttonText;
  final VoidCallback? onTap;
  final double? iconHeight;
  final double? iconWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svgImagePath ?? Assets.images.errorStorySet,
            height: iconHeight ?? Get.height,
            width: iconWidth ?? Get.width,
          ),
          AppTextStyle(
            text: title ?? "We are sorry!",
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
          10.height,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppTextStyle(
              text: message ?? "Something went wrong. Please try again.",
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          100.height,
        ],
      ),
    );
  }
}
