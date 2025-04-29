import 'package:get/get.dart';

import '../controllers/account_and_security_controller.dart';

class AccountAndSecurityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountAndSecurityController>(
      () => AccountAndSecurityController(),
    );
  }
}
