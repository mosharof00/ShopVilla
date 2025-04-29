import 'package:get/get.dart';

import '../controllers/flash_sales_controller.dart';

class FlashSalesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FlashSalesController>(
      () => FlashSalesController(),
    );
  }
}
