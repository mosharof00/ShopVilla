import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/models/Delivery%20Charge/checklist_get_model.dart';
import 'package:shop_villa/app/models/delivery%20list/delivery_list_model.dart';
import 'package:shop_villa/app/modules/choose_delivery_address/controllers/choose_delivery_address_controller.dart';
import 'package:shop_villa/app/repository/api_services.dart';
import 'package:shop_villa/global/global_snackbar.dart';
import 'package:shop_villa/helper/exception_handle.dart';
import '../../../../models/address/shipping_address_get_model.dart';

class AddDeliveryAddressController extends GetxController {
  final chooseAddressController = Get.put(ChooseDeliveryAddressController());
  final deliveryCityList = <DeliveryList>[].obs;
  final isDeliveryCityLoading = true.obs;
  final selectedAmount = ''.obs;
  final selectedCity = ''.obs;
  /// Text Editing Controller
  TextEditingController labelTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController addressTextController = TextEditingController();
  TextEditingController areaTextController = TextEditingController();
  TextEditingController cityTextController = TextEditingController();
  TextEditingController districtTextController = TextEditingController();
  final RxMap allAddresses = {}.obs; // Stores addresses
  RxString errorMessage = "".obs;
  int? editingAddressID;

  ///Add Shipping Address
  final apiService = Get.put(ApiServices());
  // Add Shipping Address
  Future<void> addShippingAddress({
    required String name,
    required String email,
    required String phone,
    required String area,
    required String city,
    required String district,
    required String address,
    required String deliveryCharge,
    required String label,
  }) async {
    try {
      final addAddress = await apiService.addShippingAddress(
        name,
        email,
        phone,
        city,
        district,
        area,
        address,
        deliveryCharge,
        label,
      ); // Post Address
      final message = addAddress.message!;
      final status = addAddress.status!;
      if (status) {
        globalSnackBar(title: "Shipping Address", message: message.toString());
        chooseAddressController.getAddressList();
      } else {
        debugPrint('Address Not Added');
      }
    } catch (e) {
      handleException(e);
    }
  }

  // Update Shipping Address
  Future<void> updateShippingAddress(
      {required String name,
      required String email,
      required String phone,
      required String city,
      required String district,
      required String area,
      required String address,
      required String label,
      required String deliveryCharge,
      required int addressID}) async {
    try {
      final updateAddress = await apiService.updateShippingAddress(
        label,
        name,
        phone,
        email,
        city,
        district,
        area,
        address,
        deliveryCharge,
        addressID,
      );
      if (updateAddress.status!) {
        Get.snackbar('Shipping Address', updateAddress.message!);
        chooseAddressController.getAddressList();
      } else {
      }
    } catch (e) {
      handleException(e);
    }
  }


  // Set Existing Data for Editing
  void setAddressForEditing(Address address) {
    labelTextController.text = address.label ?? '';
    nameTextController.text = address.name ?? '';
    phoneTextController.text = address.phone ?? '';
    emailTextController.text = address.email ?? '';
    cityTextController.text = address.city ?? '';
    districtTextController.text = address.district ?? '';
    areaTextController.text = address.selectedArea ?? '';
    addressTextController.text = address.address ?? '';
    editingAddressID = address.id;
    final selectCity = deliveryCityList.where(
          (city) => city.city == address.city,
    );
    // Check if any city matches
    if (selectCity.isNotEmpty) {
      final matchingCity = selectCity.first; // Get the first matching city
      selectedCity.value = '${matchingCity.city}'; // Set selectedCity to the city name
      selectedAmount.value = matchingCity.amount.toString().split('.')[0]; // Set selectedAmount to the amount associated with the city
    } else {
      selectedCity.value = ''; // Reset if no match found
      selectedAmount.value = ''; // Reset if no match found
    }
  }

  /// CheckList
  final deliveryCharge = DeliveryCharge().obs;
  final charge = ''.obs;
  Future<void> getDeliveryCharge() async {
    try {
      final getList = await apiService.deliveryCharge();
      if (getList.data != null) {
        deliveryCharge.value = getList.data!;
        charge.value = deliveryCharge.value.shippingCharge.toString();
      } else {
        debugPrint('CheckList Empty');
      }
    } catch (e) {
      handleException(e);
    }
  }

  /// Delivery List

  Future<void> getDeliveryCityList() async {
    try{
      final response = await apiService.getDeliveryList();
      deliveryCityList.value = response.data!;
      isDeliveryCityLoading.value = false;
    } catch(e){
      isDeliveryCityLoading.value = false;
      handleException(e);
    }
  }

  // Clear all textfields
  void clearForm() {
    labelTextController.clear();
    nameTextController.clear();
    phoneTextController.clear();
    emailTextController.clear();
    addressTextController.clear();
    areaTextController.clear();
    districtTextController.clear();
    cityTextController.clear();
    editingAddressID = null;
    selectedCity.value = '';
    selectedAmount.value = '';
  }

  @override
  void onInit() {
    getDeliveryCharge();
    getDeliveryCityList();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    clearForm();
  }
}
