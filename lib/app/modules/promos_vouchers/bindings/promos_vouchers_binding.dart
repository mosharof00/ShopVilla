import 'package:get/get.dart';

import '../controllers/promos_vouchers_controller.dart';

class PromosVouchersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PromosVouchersController>(
      () => PromosVouchersController(),
    );
  }
}
