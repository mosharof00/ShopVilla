import 'package:get/get.dart';
import 'package:shop_villa/app/models/profile/profile_get_model.dart';
import 'package:shop_villa/app/repository/api_services.dart';
import 'package:shop_villa/helper/exception_handle.dart';
import 'package:shop_villa/helper/helper_utils.dart';

import '../../../models/admin/admin_info.dart';

class ProfileController extends GetxController {
  /// API Service instance to handle API requests
  final apiService = Get.put(ApiServices());

  /// Observable to store the profile details retrieved from the API
  final profileDetails = ProfileGetModel().obs;

  /// Fetches profile details from the API
  Future<void> getProfileDetails() async {
    try {
      // Calls the API service to get profile details
      final profile = await apiService.profileDetails();
      // Updates the observable with the fetched profile data
      profileDetails.value = profile;
    } catch (e) {
      // Handles any errors that occur during the API call
      handleException(e);
    }
  }

  final adminInfo = <Admin>[].obs;
  Future<void> getAdminInfo() async {
    try{
      final response = await apiService.getAdminInfo();
      adminInfo.value = response.data!;
    }catch(e){
      handleException(e);
    }
  }

  @override
  void onInit() {
    getAdminInfo();
    super.onInit();
    // Check if the user is logged in
    if (HelperUtils.isLogin) {
      getProfileDetails(); // Fetch profile details if the user is logged in
    }
  }
}
