import 'package:get/get.dart';
import 'package:shop_villa/app/routes/app_pages.dart';
import 'package:shop_villa/app/services/local_store_config.dart';
import '../../../../helper/helper_utils.dart';

class SplashController extends GetxController {
  navigateToMainPage() async {
    // Token and UserID Checks for User Logged In Or Not
    HelperUtils.token = await HiveService.getToken() ?? "";
    HelperUtils.userID = await HiveService.getUserID() ?? 0;
    // If User Open the app for first time for one time he/she can see the Onboarding Screen
    final hasOnBoardBeenShown = await HiveService.getOnBoardShowed();
    await HelperUtils.initializeController();
    if (hasOnBoardBeenShown) {
      if(HelperUtils.token.isEmpty){
        HelperUtils.isLogin = false;
      }
      Get.offNamed(Routes.MAINPAGE);
    } else {
      Get.offNamed(Routes.ONBOARD_PAGE); // or whatever the route is for your onboarding screen
    }

  }

  @override
  void onInit() async {
    navigateToMainPage(); // Initializing the controller
    super.onInit();
  }
}
