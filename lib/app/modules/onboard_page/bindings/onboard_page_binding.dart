import 'package:get/get.dart';

import '../controllers/onboard_page_controller.dart';

class OnboardPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardPageController>(
      () => OnboardPageController(),
    );
  }
}
