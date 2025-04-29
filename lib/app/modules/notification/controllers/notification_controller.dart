import 'package:get/get.dart';
import '../../../../helper/exception_handle.dart';
import '../../../../helper/helper_utils.dart';
import '../../../models/notification/notification_model.dart';
import '../../../models/order place/user_orderlist_post_model.dart';
import '../../../repository/api_services.dart';

class NotificationController extends GetxController {
  //TODO: Implement NotificationController

  ApiServices apiServices = ApiServices();
  var notificationModel = NotificationModel().obs;
  final notificationList = <NotificationData>[].obs;
  final isLoading = 1.obs;
  final exceptions = " ".obs;
  final myOrder = <MyOrder>[].obs;
  Future<void> fetchNotification() async {
    try {
      isLoading.value = 1;
      final response = await apiServices.getNotification();
      notificationModel.value = response;
      notificationList.value = response.data!;
      isLoading.value = 0;
    } catch (e) {
      handleException(e);
      exceptions.value = e.toString();
      isLoading.value = 2;
    }
  }

  Future<void> userOrderList({required String invoiceID}) async {
    try {
      final response = await apiServices.userOrderList();
      myOrder.value = response.data!.data!
          .where((invoice) => invoice.invoiceId == invoiceID)
          .toList();
    } catch (e) {
      handleException(e);
    }
  }

  @override
  void onInit() {
    if (HelperUtils.isLogin) {
      fetchNotification();
    }
    super.onInit();
  }
}

