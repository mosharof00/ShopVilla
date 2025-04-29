import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:shop_villa/app/repository/api_services.dart';
import 'package:shop_villa/app/services/local_store_config.dart';
import 'package:shop_villa/global/global_snackbar.dart';
import 'package:shop_villa/helper/exception_handle.dart';
import 'package:shop_villa/helper/log_printer.dart';
import '../../../../helper/helper_utils.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  // Loading button
  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  // Is remember me
  RxBool boxCheck = true.obs;
  // Password visibility
  RxBool hidePassword = true.obs;
  // Text Field Controller
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passEditingController = TextEditingController();
  var emailError = ''.obs;
  var passwordError = ''.obs;

  ///Auth
  final ApiServices apiService = ApiServices();

  /// Login
  Future<bool> loginUser({
    required String email,
    required String password,
    bool isSocial = false,
  }) async {
    try {
      final response = await apiService.loginUser(email, password);
      final bool? status = response.data?.user?.status;
      final String message = response.message![0];
      if (status == true) {
        // Delete Existing token set new token for login
        HiveService.deleteToken();
        HiveService.setToken(response.data!.token!);
        // Delete Existing UserID set new token for login
        HiveService.deleteUserID();
        HiveService.setUserID(response.data!.user!.id!);
        // Set the Token and UserID in local storage
        HelperUtils.token = response.data!.token!;
        HelperUtils.userID = response.data!.user!.id!;
        Log.w(HelperUtils.userID);

        // set the user is Authenticate or Unauthenticated
        await HiveService.checkLoginStatus();
        // Reduce Loading initializing the controller
        await HelperUtils.initializeController();

        btnController.stop();
        Get.offNamed(Routes.MAINPAGE, arguments: 0);
        globalSnackBar(
            title: "Login!",
            message: response.message![0].toString(),
            durationInSeconds: 2);
        return true;
      } else {
        if (!isSocial) {
          globalSnackBar(
              title: "Unsuccessful Login!",
              message: message,
              durationInSeconds: 2);
          btnController.stop();
        }
        return false;
      }
    } catch (e) {
      handleException(e);
      btnController.stop();
      return false;
    }
  }

  //Login Validation
  bool validateInputs() {
    bool isValid = true;
    if (emailEditingController.text.isEmpty) {
      emailError.value = '* Required';
      isValid = false;
    } else if (!GetUtils.isEmail(emailEditingController.text)) {
      emailError.value = 'Enter a valid email';
      isValid = false;
    } else {
      emailError.value = '';
    }
    if (passEditingController.text.isEmpty) {
      passwordError.value = '* Required';
      isValid = false;
    } else {
      passwordError.value = '';
    }
    return isValid;
  }

  @override
  void dispose() {
    emailEditingController.dispose();
    passEditingController.dispose();
    super.dispose();
  }
}
