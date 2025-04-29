import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../gen/colors.gen.dart';
import 'app_text_style.dart';

class SortFilter extends StatelessWidget {
  const SortFilter(
      {super.key,
      required this.text,
      required this.filterIcon,
      required this.onTap, this.textColor, this.iconColor,
      });
  final String text;
  final bool filterIcon;
  final VoidCallback onTap;
  final Color? textColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onTap,
      child: Container(
        width: 75.w,
        height: 30.h,
        decoration: BoxDecoration(
            color: ColorName.white,
            borderRadius: BorderRadius.circular(5.r),
            // border: Border.all(
            //   width: 1,
            //   color: Colors.grey
            // )
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, offset: Offset(1, 2), blurRadius: 3)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppTextStyle(
              text: text,
              color: textColor ?? Colors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            filterIcon
                ? Icon(
                    MdiIcons.filter,
                    size: 15.sp,
                    color:iconColor ?? ColorName.black,
                  )
                :  Icon(
                    Icons.sort,
                    size: 15.sp,
                    color:iconColor ??  ColorName.black,
                  )
          ],
        ),
      ),
    );
  }
}
