import 'package:get/get.dart';
import 'package:shop_villa/app/models/address/shipping_address_get_model.dart';
import 'package:shop_villa/app/repository/api_services.dart';
import 'package:shop_villa/global/global_snackbar.dart';
import 'package:shop_villa/helper/exception_handle.dart';
import 'package:shop_villa/helper/log_printer.dart';

class ChooseDeliveryAddressController extends GetxController {
  Function? onAddressSelectedCallback; // Callback function to be called when an address is selected

  ///Get Shipping Address
  final apiService = Get.put(ApiServices());
  //Get
  final addressList = <Address>[].obs;
  final primaryAddress = Rxn<Address>();
  final Rx<int?> selectedAddressId = Rx<int?>(null);
  // Fetch the list of shipping addresses
  Future<void> getAddressList() async {
    try {
      final getAddress = await apiService.getShippingAddress();
      final status = getAddress.status!;
      final message = getAddress.message!;
      if (status) { // Update the address list if the API call is successful
        addressList.value = getAddress.data!;
        // Set the first address as selected if no address was previously selected
        if (selectedAddressId.value == null && addressList.isNotEmpty) {
          selectedAddressId.value = addressList.first.id;
        }
      } else {
        // Show an error message if the API call fails
        globalSnackBar(title: "Address", message: message.toString());
      }
    } catch (e) {
      handleException(e);
    }
  }

  //  Show an error message if the API call fails
  Future<void> deleteAddress(int addressID) async {
    try {
      final deleteAddress = await apiService.deleteShippingAddress(addressID);
      final message = deleteAddress.message!;
      globalSnackBar(title: 'Shipping Address', message: message.toString());
      // addressList.removeWhere((address) => address.id == addressID);
      getAddressList();
    } catch (e) {
      Log.e(e.toString());
      handleException(e);
    }
  }

  // Set the callback function to be called when an address is selected
  void setOnAddressSelectedCallback(Function callback) {
    onAddressSelectedCallback = callback;
  }
  // Select an address by its ID and invoke the callback function
  void selectAddress(int addressId) {
    selectedAddressId.value = addressId;
    onAddressSelectedCallback?.call();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAddressList();
  }
}
