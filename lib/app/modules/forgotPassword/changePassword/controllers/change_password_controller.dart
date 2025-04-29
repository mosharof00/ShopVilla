import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import 'package:shop_villa/helper/exception_handle.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../global/app_text_style.dart';
import '../../../../../global/global_button.dart';
import '../../../../../global/global_snackbar.dart';
import '../../../../repository/api_services.dart';
import '../../../../routes/app_pages.dart';

class ChangePasswordController extends GetxController {
  //TODO: Implement ChangePasswordController
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  ApiServices apiServices = ApiServices();
  final token = " ".obs;
  RxBool hidePassword = true.obs;
  RxBool hideConfirmPassword = true.obs;
  var passwordTextInputError = ''.obs;

  Future<void> changePassword(BuildContext context) async {
    try {
      final response = await apiServices.resetPassword(
          token: token.value,
          newPassword: newPasswordController.text.toString(),
          confirmNewPassword: confirmNewPasswordController.text.toString());
      if (response.status == true) {
        btnController.stop();
        globalSnackBar(
            title: 'Success!',
            message: response.message!.join('\n').toString());
        successfullyPasswordChanged(context);
      } else {
        btnController.stop();
        globalSnackBar(
            durationInSeconds: 3,
            title: 'Warning!',
            message: response.message!.join('\n').toString());
      }
    } catch (e) {
      handleException(e);
      btnController.stop();
    }
  }

  ///  text validation
  bool validateInputs() {
    bool isValid = true;
    if (newPasswordController.text.isEmpty) {
      passwordTextInputError.value = '* Required';
      isValid = false;
    } else if (confirmNewPasswordController.text.isEmpty) {
      passwordTextInputError.value = '* Required';
      isValid = false;
    } else {
      passwordTextInputError.value = '';
    }
    return isValid;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.onClose();
  }
}

Future successfullyPasswordChanged(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    useSafeArea: true,
    isDismissible: false,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.all(15.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
              width: Get.width,
            ),
            Container(
              height: 80.h,
              width: 80.w,
              decoration: BoxDecoration(
                color: ColorName.primaryColor.withOpacity(0.4),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                  child: Image.asset(
                Assets.images.lockAnimationIcon.path,
                height: 50.h,
                width: 50.w,
              )),
            ),
            30.height,
            AppTextStyle(
              text: 'You\'re All Set',
              fontSize: 17.sp,
              fontWeight: FontWeight.w800,
            ),
            SizedBox(
              height: 15.h,
            ),
            AppTextStyle(
              text: 'Your Password Changed Successfully.',
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
            SizedBox(
              height: 50.h,
            ),
            globalButton(
              onTap: () {
                Get.offAllNamed(Routes.LOGIN);
              },
              text: 'Login',
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      );
    },
  );
}
