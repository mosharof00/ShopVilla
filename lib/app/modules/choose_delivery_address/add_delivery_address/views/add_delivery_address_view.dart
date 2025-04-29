import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa/gen/colors.gen.dart';
import 'package:shop_villa/global/app_input_textformfield.dart';
import 'package:shop_villa/global/app_text_style.dart';
import 'package:shop_villa/global/global_button.dart';
import 'package:shop_villa/global/global_button_without_gradient.dart';
import 'package:shop_villa/global/loading_animation_widget.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import 'package:shop_villa/helper/appbar_title.dart';
import '../../../../models/delivery list/delivery_list_model.dart';
import '../controllers/add_delivery_address_controller.dart';

class AddDeliveryAddressView extends GetView<AddDeliveryAddressController> {
  const AddDeliveryAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddDeliveryAddressController());
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        title: appbarTitle(text: 'Add Address Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Obx(() {
            if (controller.isDeliveryCityLoading.value) {
              return loadingAnimationWidget();
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextStyle(
                    text: 'Address Label',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  3.height,
                  AppInputTextFormField(
                    controller: controller.labelTextController,
                    hintText: 'Enter Address Title',
                    fontSize: 11.sp,
                    borderRadius: 15,
                    fillColor: Colors.white,
                    validator: (value) {
                      if (value != null && int.tryParse(value) == null) {
                        return 'Required';
                      }
                      return null;
                    },
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  5.height,
                  AppTextStyle(
                    text: 'Name',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  3.height,
                  AppInputTextFormField(
                    controller: controller.nameTextController,
                    hintText: 'Enter Receipt Name',
                    fontSize: 11.sp,
                    borderRadius: 15,
                    fillColor: Colors.white,
                    validator: (value) {
                      if (value != null && int.tryParse(value) == null) {
                        return 'Required';
                      }
                      return null;
                    },
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  5.height,
                  AppTextStyle(
                    text: 'Phone No.',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  3.height,
                  AppInputTextFormField(
                    controller: controller.phoneTextController,
                    hintText: 'Enter Phone No.',
                    keyboardType: TextInputType.number,
                    fontSize: 11.sp,
                    borderRadius: 15,
                    fillColor: Colors.white,
                    validator: (value) {
                      if (value != null && int.tryParse(value) == null) {
                        return 'Required';
                      }
                      return null;
                    },
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  5.height,
                  AppTextStyle(
                    text: 'Email',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  3.height,
                  AppInputTextFormField(
                    controller: controller.emailTextController,
                    hintText: 'Enter Email Address',
                    fontSize: 11.sp,
                    borderRadius: 15,
                    fillColor: Colors.white,
                  ),
                  5.height,
                  AppTextStyle(
                    text: 'City',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  3.height,
                  AppInputTextFormField(
                    controller: controller.cityTextController,
                    hintText: 'Ex. Dhaka',
                    fontSize: 11.sp,
                    borderRadius: 15,
                    maxLines: 3,
                    // maxLength: 200,
                    fillColor: Colors.white,
                    validator: (value) {
                      if (value != null && int.tryParse(value) == null) {
                        return 'Required';
                      }
                      return null;
                    },
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  5.height,
                  AppTextStyle(
                    text: 'District',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  3.height,
                  AppInputTextFormField(
                    controller: controller.districtTextController,
                    hintText: 'Ex. Dhaka',
                    fontSize: 11.sp,
                    borderRadius: 15,
                    maxLines: 3,
                    // maxLength: 200,
                    fillColor: Colors.white,
                    validator: (value) {
                      if (value != null && int.tryParse(value) == null) {
                        return 'Required';
                      }
                      return null;
                    },
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  5.height,
                  AppTextStyle(
                    text: 'Area',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  3.height,
                  AppInputTextFormField(
                    controller: controller.areaTextController,
                    hintText: 'Enter Your Area',
                    fontSize: 11.sp,
                    borderRadius: 15,
                    maxLines: 3,
                    // maxLength: 200,
                    fillColor: Colors.white,
                    validator: (value) {
                      if (value != null && int.tryParse(value) == null) {
                        return 'Required';
                      }
                      return null;
                    },
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  5.height,
                  AppTextStyle(
                    text: 'Address',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  3.height,
                  AppInputTextFormField(
                    controller: controller.addressTextController,
                    hintText: 'Enter Delivery Address',
                    fontSize: 11.sp,
                    borderRadius: 15,
                    maxLines: 3,
                    // maxLength: 200,
                    fillColor: Colors.white,
                    validator: (value) {
                      if (value != null && int.tryParse(value) == null) {
                        return 'Required';
                      }
                      return null;
                    },
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  5.height,
                  controller.deliveryCharge.value.deliveryChargeType
                              .toString() ==
                          'order_wise'
                      ? const SizedBox.shrink()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextStyle(
                              text: 'Selected Area',
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            3.height,
                            globalButtonWithoutGradient(
                                onTap: () {
                                  DropDownState<DeliveryList>(
                                    dropDown: DropDown<DeliveryList>(
                                      isDismissible: true,
                                      bottomSheetTitle: const Text(
                                        'Select City',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      submitButtonText: 'Done',
                                      clearButtonText: 'Clear',
                                      enableMultipleSelection: false,
                                      data: controller.deliveryCityList
                                          .map((deliveryItem) {
                                        return SelectedListItem(
                                          data: deliveryItem,
                                        );
                                      }).toList(),
                                      listItemBuilder: (index, item) {
                                        return Text(
                                          '${item.data.city} - ৳${item.data.amount}',
                                          style: const TextStyle(fontSize: 16),
                                        );
                                      },
                                      onSelected: (selectedItems) {
                                        if (selectedItems.isNotEmpty) {
                                          final selectedCityModel =
                                              selectedItems.first.data;
                                          controller.selectedCity.value =
                                              selectedCityModel.city ??
                                                  'Unknown';
                                          controller.selectedAmount.value =
                                              selectedCityModel.amount ?? '0';
                                        }
                                      },
                                      searchDelegate: (query, items) {
                                        return items.where((item) {
                                          final city =
                                              item.data.city?.toLowerCase() ??
                                                  '';
                                          return city
                                              .contains(query.toLowerCase());
                                        }).toList();
                                      },
                                    ),
                                  ).showModal(context);
                                },
                                text: controller.selectedAmount.value.isEmpty
                                    ? 'Selected Area'
                                    : '${controller.selectedCity.value} - ${controller.selectedAmount.value}',
                                // Updated to show "City: Amount"
                                btnColor: ColorName.white,
                                fontWeight: FontWeight.normal,
                                fontColor: ColorName.gray410,
                                borderColor: ColorName.gray70,
                                fontSize: 12.sp,
                                borderRadius: BorderRadius.circular(10.r)),
                          ],
                        ),
                  10.height,
                  Obx(
                    () => controller.errorMessage.isEmpty
                        ? 0.width
                        : AppTextStyle(
                            text: controller.errorMessage.value,
                            color: Colors.red,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                  )
                ],
              );
            }
          }),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: globalButton(
          text: 'Save',
          onTap: () {
            if (controller.labelTextController.text.isNotEmpty &&
                controller.nameTextController.text.isNotEmpty &&
                controller.phoneTextController.text.isNotEmpty &&
                controller.emailTextController.text.isNotEmpty &&
                controller.cityTextController.text.isNotEmpty &&
                controller.districtTextController.text.isNotEmpty &&
                controller.areaTextController.text.isNotEmpty &&
                controller.charge.value.isNotEmpty &&
                controller.addressTextController.text.isNotEmpty) {
              if (controller.editingAddressID != null) {
                // Update existing address
                controller.updateShippingAddress(
                  addressID: controller.editingAddressID!,
                  label: controller.labelTextController.text,
                  name: controller.nameTextController.text,
                  email: controller.emailTextController.text,
                  phone: controller.phoneTextController.text,
                  city: controller.cityTextController.text,
                  district: controller.districtTextController.text,
                  area: controller.areaTextController.text,
                  deliveryCharge: controller
                              .deliveryCharge.value.deliveryChargeType
                              .toString() ==
                          'order_wise'
                      ? controller.charge.value
                      : controller.selectedAmount.toString(),
                  address: controller.addressTextController.text,
                );
              } else {
                // Add new address
                controller.addShippingAddress(
                  label: controller.labelTextController.text,
                  name: controller.nameTextController.text,
                  email: controller.emailTextController.text,
                  phone: controller.phoneTextController.text,
                  city: controller.cityTextController.text,
                  district: controller.districtTextController.text,
                  area: controller.areaTextController.text,
                  deliveryCharge: controller
                              .deliveryCharge.value.deliveryChargeType
                              .toString() ==
                          'order_wise'
                      ? controller.charge.value
                      : controller.selectedAmount.toString(),
                  address: controller.addressTextController.text,
                );
              }
              controller.errorMessage.value = " ";
              Get.back();
            } else {
              controller.errorMessage.value = "Please enter required feeds";
            }
            return;
          },
        ),
      ),
    );
  }
}
