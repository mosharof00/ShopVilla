import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shop_villa/global/app_text_style.dart';

import '../../../../../gen/colors.gen.dart';

class IconWithText extends StatelessWidget {
  final IconData? iconData;
  final String text;
  final Color? color;

  const IconWithText({super.key, this.iconData, this.color,required this.text});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          iconData ?? MdiIcons.message,
          color: color ?? ColorName.primaryColor,
          size: 28,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: AppTextStyle(
            text: text,
            fontSize: 12.sp,
            color: ColorName.white,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}
