import 'package:get/get.dart';

import '../controllers/qus_and_ans_controller.dart';

class QusAndAnsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QusAndAnsController>(
      () => QusAndAnsController(),
    );
  }
}
