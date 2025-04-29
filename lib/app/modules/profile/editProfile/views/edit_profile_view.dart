import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shop_villa/gen/colors.gen.dart';
import 'package:shop_villa/global/app_text_style.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import 'package:shop_villa/helper/appbar_title.dart';
import 'package:shop_villa/helper/log_printer.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../global/app_input_textformfield.dart';
import '../../../../../global/bottomSheet/custom_bottom_sheet.dart';
import '../../../../../global/loading_button.dart';
import '../../../../../global/methods/get_image_url.dart';
import '../../../../../global/shimmer_loading.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        surfaceTintColor: ColorName.bgColor,
        title: appbarTitle(text: 'Edit Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.height,
              Align(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Container(
                      height: 110.h,
                      width: 110.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Obx(() {
                        final selectedPhoto =
                            controller.selectedProfilePhoto.value;

                        if (selectedPhoto != null &&
                            File(selectedPhoto.path).existsSync()) {
                          return CircleAvatar(
                            radius: 28,
                            backgroundImage: FileImage(
                              File(selectedPhoto.path),
                            ),
                          );
                        } else {
                          return Center(
                            child: CachedNetworkImage(
                              imageUrl: GetImageUrl.url(selectedPhoto!.path),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: 110.0.w,
                                height: 110.0.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0.0, 1.0), //(x,y)
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  shimmerLoadingWidget(
                                      borderRadius: 50,
                                      height: 110.0.h,
                                      width: 110.0.w),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          );
                          // return shimmerLoadingCircularWidget(); // Show shimmer or a placeholder
                        }
                      }),
                    ),
                    Positioned(
                      bottom: 0.h,
                      right: 10.w,
                      child: InkWell(
                        onTap: () {
                          // Get  Profile Photo
                          customBottomSheet(
                              context: context,
                              onTap1: () {
                                controller.getProfileImageFromFile();
                                Get.back();
                              },
                              svgIcon1: Assets.icons.fileIcon,
                              text1: 'File',
                              onTap2: () {
                                controller.getProfileImageFromCamera();
                                Get.back();
                              },
                              svgIcon2: Assets.icons.cameraIcon,
                              text2: 'Camera');
                        },
                        child: Container(
                          height: 22.h,
                          width: 22.w,
                          decoration: const BoxDecoration(
                              color: ColorName.gradientStart,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(1, 2),
                                    blurRadius: 3)
                              ]),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              size: 18.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              20.height,
              AppTextStyle(
                text: 'Full Name',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              5.height,
              AppInputTextFormField(
                controller: controller.fullNameController,
                // prefixIcon: Icon(Icons.person),
                prefixIcon: SvgPicture.asset(
                  Assets.icons.userIcon,
                  width: 12.w,
                  height: 12.h,
                ),
                hintText: 'Name',
              ),
              20.height,
              AppTextStyle(
                text: 'Email',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              5.height,
              AppInputTextFormField(
                controller: controller.emailController,
                // prefixIcon: Icon(Icons.person),
                keyboardType: TextInputType.emailAddress,
                prefixIcon: SvgPicture.asset(
                  Assets.icons.emailIcon,
                  width: 12.w,
                  height: 12.h,
                ),
                hintText: 'Email',
              ),
              20.height,
              AppTextStyle(
                text: 'Phone Number',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              5.height,
              IntlPhoneField(
                controller: controller.phoneController,
                initialCountryCode: controller.countryName.value == ''
                    ? controller.countryName.value = 'BD'
                    : controller.countryName.value.toUpperCase(),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  iconColor: ColorName.onPrimary,
                  hintText: 'Enter Number'.tr,
                  fillColor: const Color(0xFFe9ecef),
                  filled: true,
                  contentPadding: EdgeInsets.zero,
                  hintStyle: const TextStyle(),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(
                      color: Color(0xFFadb5bd),
                      width: 1,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  errorText: controller.phoneController.text.length < 10
                      ? 'Please enter a 10 digit phone number'
                      : null,
                ),
                languageCode: "en",
                onChanged: (phone) {
                  debugPrint(
                      'Selected Phone Number is : ${phone.completeNumber}');
                },
                onCountryChanged: (country) {
                  // debugPrint(
                  //     'Country changed to:  ${country.name} code is : ${country.code}');
                  controller.countryName.value = country.code;
                },
                validator: (value) {
                  if (value == null || value.completeNumber.length < 10) {
                    return 'Please enter a 10 digit phone number';
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
              ),
              AppTextStyle(
                text: 'Gender',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              5.height,
              Obx(() => Container(
                    height: 43.h,
                    width: Get.width,
                    padding: EdgeInsets.only(left: 10.w, right: 7.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFe9ecef),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: DropdownButton(
                      hint: AppTextStyle(
                        text: 'Select gender',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                      underline: const SizedBox(),
                      isExpanded: true,
                      elevation: 0,
                      iconSize: 30.sp,
                      value: controller.selectedGender.value.isEmpty
                          ? null
                          : controller.selectedGender.value,
                      onChanged: (newValue) {
                        controller.upDateSelectedGender(newValue.toString());
                      },
                      items: controller.dropDownClassList.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: AppTextStyle(
                            text: e,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      }).toList(),
                    ),
                  )),
              20.height,
              AppTextStyle(
                text: 'Date of Birth',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              5.height,
              InkWell(
                onTap: () async {
                  var results = await showCalendarDatePicker2Dialog(
                    context: context,
                    config: CalendarDatePicker2WithActionButtonsConfig(
                      // calendarType: CalendarDatePicker2Type.range,
                      firstDate: DateTime(1950),
                    ),
                    dialogSize: const Size(325, 400),
                    value: [
                      controller.myData.value,
                    ],
                    borderRadius: BorderRadius.circular(15),
                  );
                  if (results != null && results.isNotEmpty) {
                    controller.setDate(results[0]);
                  }
                },
                child: Container(
                  height: 43.h,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: const Color(0xFFe9ecef),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      10.width,
                      Obx(() {
                        if (controller.myData.value == null) {
                          return AppTextStyle(
                            text: 'Select Date of Birth', // Placeholder text
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            // color: Colors.grey,
                          );
                        } else {
                          return AppTextStyle(
                            text:
                                '${controller.myData.value!.day}/${controller.myData.value!.month}/${controller.myData.value!.year}',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            // color: Colors.grey,
                          );
                        }
                      }),
                      const Spacer(),
                      SvgPicture.asset(
                        Assets.icons.calenderIcon,
                        colorFilter: const ColorFilter.mode(
                            ColorName.primaryColor, BlendMode.srcIn),
                        width: 20.w,
                        height: 20.h,
                      ),
                      10.width,
                    ],
                  ),
                ),
              ),
              15.height,
              loadingButton(
                valueColor: ColorName.white,
                text: 'Save',
                controller: controller.btnController,
                onTap: () {
                  controller.postProfileUpdate(
                    name: controller.fullNameController.text,
                    email: controller.emailController.text,
                    birthday: controller.date.value.toString(),
                    gender: controller.selectedGender.value,
                    phone: controller.phoneController.text,
                    country: controller.countryName.value,
                    image: controller.selectedProfilePhoto.value?.path,
                  );
                  Log.w(controller.selectedProfilePhoto.value!.path);
                  if (controller.fullNameController.text.isNotEmpty) {
                    controller.errorMessage.value = " ";
                    // Get.back();
                  } else {
                    controller.errorMessage.value =
                        "Please enter required feeds";
                  }
                  if (controller.isUpdate.value) {
                    Navigator.pop(Get.context!);
                  }
                },
              ),
              15.height,
            ],
          ),
        ),
      ),
    );
  }
}
