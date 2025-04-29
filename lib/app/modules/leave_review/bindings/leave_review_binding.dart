import 'package:get/get.dart';

import '../controllers/leave_review_controller.dart';

class LeaveReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaveReviewController>(
      () => LeaveReviewController(),
    );
  }
}
