
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../gen/colors.gen.dart';
import 'app_input_textformfield.dart';

class InputFieldWithSendButton extends StatelessWidget {
  const InputFieldWithSendButton({
    super.key,
    this.prefixIcon,
    this.icon,
    required this.textEditingController,
    required this.onTap
  });
  final IconData? prefixIcon;
  final VoidCallback onTap;
  final IconData? icon;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppInputTextFormField(
          controller: textEditingController,
          width: 290.w,
          fillColor: ColorName.white,
          borderRadius: 10.r,
          contentPadding: EdgeInsets.only(bottom: 0, left: 8.w),
          hintText: 'Ask Questions'.tr,
          focusedBorderColor: ColorName.primaryColor,
          prefixIcon: Icon(
            prefixIcon ?? Icons.question_answer,
            size: 22,
          ),
        ),
        IconButton(onPressed: onTap, icon: Icon(icon ?? MdiIcons.send))
      ],
    );
  }
}
