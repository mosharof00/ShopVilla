import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:shop_villa/app/models/profile/profile_get_model.dart';
import 'package:shop_villa/app/models/profile/profile_post_model.dart';
import 'package:shop_villa/app/modules/profile/controllers/profile_controller.dart';
import 'package:shop_villa/app/repository/api_services.dart';
import 'package:shop_villa/helper/exception_handle.dart';
import 'package:shop_villa/helper/log_printer.dart';

class EditProfileController extends GetxController {
  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final apiService = Get.put(ApiServices());
  final profileUpdate = ProfilePostModel().obs;
  final Rx<XFile?> selectedProfilePhoto = Rxn<XFile>();
  RxString selectedGender = ''.obs;
  Rx<DateTime?> myData = Rx<DateTime?>(null);
  late final date = "".obs;
  final exceptions = "".obs;
  final countryName = ''.obs;
  final errorMessage = ''.obs;
  final List dropDownClassList = [
    'Male'.tr,
    'Female'.tr,
    'Others'.tr,
  ];

  void setProfileForEditing(ProfileDetails profileDetails) {
    fullNameController.text = profileDetails.name ?? '';
    emailController.text = profileDetails.email ?? '';
    phoneController.text = profileDetails.phone ?? '';
    countryName.value = profileDetails.country ?? '';
    // Load the profile image if available
    if (profileDetails.image != null && profileDetails.image!.isNotEmpty) {
      selectedProfilePhoto.value = XFile(profileDetails.image!);
    } else {
      selectedProfilePhoto.value = null;
    }

// Set gender if available
    int index = dropDownClassList.indexOf(profileDetails.gender ?? 'Male');
    if (index != -1) {
      selectedGender.value = dropDownClassList[index];
    } else {
      // If the gender doesn't match any item, add it to the list or set a default
      selectedGender.value =
          dropDownClassList[0]; // Default to the first item, for example
    }

// Use this in your DropdownButton
    DropdownButton<String>(
      value: selectedGender.value,
      items: dropDownClassList.map((value) {
        return DropdownMenuItem<String>(
          value: value as String, // Explicitly cast if necessary
          child: Text(value),
        );
      }).toList(), // Convert to List<DropdownMenuItem<String>>
      onChanged: (newValue) {
        selectedGender.value = newValue!;
      },
    );
    setDate(profileDetails.birthday);
  }

  void clearAll() {
    fullNameController.clear();
    emailController.clear();
    phoneController.clear();
  }

  ///     For Profile photo

  Future<void> getProfileImageFromFile() async {
    final XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      selectedProfilePhoto.value = pickedImage;
      exceptions.value = pickedImage.path.toString();
    } else {
      return;
    }
  }

  Future<void> getProfileImageFromCamera() async {
    final XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      selectedProfilePhoto.value = pickedImage;
      // imagePath.value = pickedImage.path;
    } else {
      return;
    }
  }

  void upDateSelectedGender(String value) {
    selectedGender.value = value;
  }

  /// for Date pick
  // TextEditingController leaveReasonController = TextEditingController();

  void setDate(DateTime? data) {
    myData.value = data;
    date.value = myData.value != null
        ? '${myData.value?.year}-${myData.value?.month.toString().padLeft(2, '0')}-${myData.value?.day.toString().padLeft(2, '0')}'
        : '';
  }

  /// Api Service
  final isUpdate = false.obs;
  Future<void> postProfileUpdate({
    required String name,
    required String email,
    required String birthday,
    required String gender,
    required String phone,
    required String country,
    String? image,
  }) async {
    try {
      final update = await apiService.profileUpdates(
          name, email, birthday, gender, phone, country, image!.contains('public') ? null : image);
      if (update.status!) {
        profileUpdate.value = update;
        Get.snackbar('Profile Update', update.message!);
        isUpdate.value = true;

        // Navigator.pop(Get.context!);
        Get.find<ProfileController>().profileDetails;
        btnController.success();
        Navigator.pop(Get.context!);
      } else {
        isUpdate.value = false;
        Get.snackbar('Profile Update', update.message!);
        btnController.stop();
      }
      btnController.stop();
    } catch (e) {
      Log.w(e.toString());
      isUpdate.value = false;
      handleException(e);
      btnController.stop();
    }
  }

  @override
  void onInit() {
    clearAll();
    super.onInit();
  }
}
