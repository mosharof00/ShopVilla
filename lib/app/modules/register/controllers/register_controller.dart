import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:shop_villa/app/repository/api_services.dart';
import 'package:shop_villa/app/routes/app_pages.dart';
import 'package:shop_villa/app/services/local_store_config.dart';
import 'package:shop_villa/global/global_snackbar.dart';
import 'package:shop_villa/helper/exception_handle.dart';
import 'package:shop_villa/helper/helper_utils.dart';
import 'package:shop_villa/helper/log_printer.dart';
import '../../login/controllers/login_controller.dart';

class RegisterController extends GetxController {
  // Loading Button
  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  RxBool isAgree = false.obs;
  // Password Visibility
  RxBool hidePassword = true.obs;
  RxBool hideConfirmPassword = true.obs;
  // Text Editing Controller
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  var userNameError = ''.obs;
  var emailError = ''.obs;
  var passwordError = ''.obs;
  var confirmPasswordError = ''.obs;

  ///<-API->
  final ApiServices apiService = ApiServices();

  ///Auth
  ///Registration:
  Future<void> registerUser(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final response = await apiService.registerUser(
          name, email, password); //pass name, mail, password
      final String? token = response.data?.token;
      final int? id = response.data?.user!.id;
      final bool? status = response.status;
      final String? message = response.message![0];
      if (status!) {
        // Delete Existing Token and UserID
        HiveService.deleteToken();
        HiveService.deleteUserID();
        // Set Token and UserID for Registered User
        HiveService.setToken(token!);
        HiveService.setUserID(id!);
        HelperUtils.token = response.data!.token!;
        HelperUtils.userID = response.data!.user!.id!;
        // Set the User Logged In
        HiveService.checkLoginStatus();

        btnController.stop();
        Get.offNamed(Routes.MAINPAGE);
        Get.snackbar('Registration', message!);
      } else {
        btnController.stop();
        globalSnackBar(
            title: "Unsuccessful Registration.",
            message: 'Account Already Exists',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      handleException(e);
      btnController.stop();
    }
  }

  //Registration Validation
  bool validateInputs() {
    bool isValid = true;
    if (userNameController.text.isEmpty) {
      userNameError.value = '* Required';
      isValid = false;
    } else {
      userNameError.value = '';
    }
    if (emailController.text.isEmpty) {
      emailError.value = '* Required';
      isValid = false;
    } else if (!GetUtils.isEmail(emailController.text)) {
      emailError.value = 'Enter a valid email';
      isValid = false;
    } else {
      emailError.value = '';
    }

    if (passwordController.text.isEmpty) {
      passwordError.value = '* Required';
      isValid = false;
    } else {
      passwordError.value = '';
    }
    if (confirmPasswordController.text.isEmpty) {
      confirmPasswordError.value = '* Required';
      isValid = false;
    } else if (confirmPasswordController.text != passwordController.text) {
      confirmPasswordError.value = 'Passwords do not match';
      isValid = false;
    } else {
      confirmPasswordError.value = '';
    }
    return isValid;
  }

  /// Google Sign In
  final FirebaseAuth auth =
      FirebaseAuth.instance; // Initialize Firebase Auth instance
  final Rx<User?> user = Rx<User?>(null); // Reactive user variable
  final GoogleSignIn googleSignIn = GoogleSignIn(); // Initialize Google Sign-In

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn(); // Start Google sign-in flow
      if (googleSignInAccount == null) {
        btnController.stop();
        globalSnackBar(
          title: "Google Sign-In Cancelled",
          message: "You did not select an account.",
        );
        return; // Handle case where user cancels sign-in
      }
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount
              .authentication; // Get Google authentication tokens
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      ); // Create credential using tokens
      final UserCredential userCredential = await auth.signInWithCredential(
          credential); // Sign in to Firebase with Google credentialse
      user.value = userCredential.user; // Update reactive user variable
      if (user.value != null) {
        final String? email = user.value!.email; // Get user email
        // Retrieve UserInfo from providerData
        final UserInfo? userInfo = user.value!.providerData.isNotEmpty
            ? user.value!.providerData[0] // Access the first UserInfo
            : null;
        final String name = userInfo!.displayName!; // Get display name
        final String password = user.value!.uid; // Use UID as password
        final loginController =
            Get.put(LoginController()); // Initialize LoginController
        try {
          bool status = await loginController.loginUser(
            email: email!,
            password: password,
            isSocial: true,
          ); // Attempt login with social credentials
          if (!status) {
            await registerUser(
                name: name,
                email: email,
                password: password); // Register user if login fails
          }
        } catch (loginError) {
          handleException(loginError); // Handle login errors
        }
      } else {
        await auth.signOut(); // Sign out if user is null
        user.value = null; // Reset user variable
      }
      btnController.stop();
    } catch (e) {
      Log.e(e);
      handleException(e); // Handle sign-in errors
    }
  }

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
