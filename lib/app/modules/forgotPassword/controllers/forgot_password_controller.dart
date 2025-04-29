import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:shop_villa/app/models/forgot_password/forgot_password_model.dart';
import 'package:shop_villa/app/modules/forgotPassword/verifyOTP/controllers/verify_o_t_p_controller.dart';
import 'package:shop_villa/app/repository/api_services.dart';
import 'package:shop_villa/app/routes/app_pages.dart';
import 'package:shop_villa/global/global_snackbar.dart';
import 'package:shop_villa/helper/exception_handle.dart';

import '../../../../helper/log_printer.dart';

class ForgotPasswordController extends GetxController {
  //TODO: Implement ForgotPasswordController
  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  VerifyOTPController verifyOTPController = Get.put(VerifyOTPController());
  ApiServices apiServices = ApiServices();
  TextEditingController emailController = TextEditingController();
  final sendOtpResponse = ForgotPasswordModel().obs;
  var emailError = ''.obs;

  ///  validation
  bool validateInputs() {
    bool isValid = true;
    if (emailController.text.isEmpty) {
      emailError.value = '* Required';
      isValid = false;
    } else if (!GetUtils.isEmail(emailController.text)) {
      emailError.value = 'Enter a valid email';
      isValid = false;
    } else {
      emailError.value = '';
    }
    return isValid;
  }

  ///   Sent OTP
  void sendOTP({required String email}) async {
    try {
      final response = await apiServices.sendOTP(email: email);
      if (response.status == true) {
        verifyOTPController.token.value = " ";
        verifyOTPController.code.value = 0;
        Log.i(response.data!.code!);
        btnController.stop();
        sendOtpResponse.value = response;
        verifyOTPController.token.value = response.data!.token!;
        verifyOTPController.code.value = response.data!.code!;
        verifyOTPController.email.value = emailController.text.toString();
        globalSnackBar(
            title: 'Success!',
            message: "${response.message.toString()} '$email' ");
        Get.toNamed(Routes.VERIFY_O_T_P);
      } else {
        btnController.stop();
        globalSnackBar(
            durationInSeconds: 3,
            title: 'Warning!',
            message:
                "${response.message!.join('\n')} \n Please enter a valid email which have already registered or Register.");
      }
    } catch (e) {
      handleException(e);
      btnController.stop();
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    emailController.clear();
    super.onClose();
  }
}
