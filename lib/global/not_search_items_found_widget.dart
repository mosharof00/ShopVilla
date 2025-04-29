import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_villa/appConfig.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';

import '../gen/assets.gen.dart';
import 'app_text_style.dart';

class NotSearchedItemFoundWidget extends StatelessWidget {
  const NotSearchedItemFoundWidget(
      {super.key,
      this.title,
      this.description,
      this.iconSvgPath,
      this.heightLogo,
      this.widthLogo,
      this.widgetHeight});
  final String? title;
  final String? description;
  final String? iconSvgPath;
  final double? heightLogo;
  final double? widthLogo;
  final Widget? widgetHeight;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AppConfig.appLogo,
            height: 80.h,
            width: 100.w,
          ),
          10.height,
          AppTextStyle(
            text: title ?? "We're Sorry",
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
          10.height,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: AppTextStyle(
              text: description ??
                  "We did not find any matching product for your search item.",
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          widgetHeight ?? 40.height,
        ],
      ),
    );
  }
}
