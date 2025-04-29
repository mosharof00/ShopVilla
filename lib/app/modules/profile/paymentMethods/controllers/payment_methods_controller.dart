import 'package:get/get.dart';
import '../../../../../helper/exception_handle.dart';
import '../../../../models/payment_method/payment_method.dart';
import '../../../../repository/api_services.dart';

class PaymentMethodsController extends GetxController {
  // Selected Payment Index
  RxInt paymentSelectIndex = 0.obs;

  /// Api
  final apiService = ApiServices();
  final paymentTypeList = <PaymentType>[].obs;
  final selectedPaymentType = 'stripe'.obs;
  final isPartialEnabled = false.obs;
  final partialAmount = '0'.obs;
  final partialPaymentText = ''.obs;
  Future<void> getPaymentType() async {
    try {
      final response = await apiService.getPaymentType(); // Get Payment Methods
      paymentTypeList.value = response.data!.type!;
      paymentTypeList.value = paymentTypeList.where((status)=> status.active!).toList();
      if(response.data!.advancePaymentStatus == 'ON'){
        isPartialEnabled.value = true;
        partialPaymentText.value = response.data!.advancePaymentTitle!;
        partialAmount.value = response.data!.advancePayment!;
      }else {
        isPartialEnabled.value = false;
      }
    } catch (e) {
      handleException(e);
    }
  }

  @override
  void onInit() {
    getPaymentType();
    super.onInit();
  }
}
