import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import '../gen/colors.gen.dart';

final player = AudioPlayer();

void awesomeAlertDialog(
  BuildContext context,
  DialogType dialogType,
  String? title,
  String? desc,
  String? cancelBtnText,
  VoidCallback btnCancelOnPress,
  String? okBtnText,
  VoidCallback btnOkOnPress,
  bool? dismisableTouchOutside,
) {
  AwesomeDialog(
    context: context,
    dialogType: dialogType,
    headerAnimationLoop: true,
    animType: AnimType.scale,
    title: title?.tr,
    desc: desc?.tr,
    titleTextStyle: GoogleFonts.poppins(
      fontSize: 17.sp,
      fontWeight: FontWeight.w600,
    ),
    descTextStyle: GoogleFonts.poppins(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
    ),
    dismissOnTouchOutside: dismisableTouchOutside ?? true,
    btnCancelColor: ColorName.gray410,
    btnOkColor: ColorName.primaryColor,
    btnCancelText: cancelBtnText?.tr ?? 'Cancel'.tr,
    btnOkText: okBtnText?.tr ?? 'Ok'.tr,
    btnCancelOnPress: btnCancelOnPress,
    btnOkOnPress: btnOkOnPress,
  ).show();
  player.setAsset('assets/tone/correct.mp3');
  player.play();
}
