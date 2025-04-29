import 'package:get/get.dart';

import '../controllers/choose_delivery_address_controller.dart';

class ChooseDeliveryAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseDeliveryAddressController>(
      () => ChooseDeliveryAddressController(),
    );
  }
}
