import 'package:get/get.dart';

import '../controllers/choose_delivery_controller.dart';

class ChooseDeliveryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseDeliveryController>(
      () => ChooseDeliveryController(),
    );
  }
}
