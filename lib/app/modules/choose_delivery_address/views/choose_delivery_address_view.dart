import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/modules/choose_delivery_address/add_delivery_address/controllers/add_delivery_address_controller.dart';
import 'package:shop_villa/app/routes/app_pages.dart';
import 'package:shop_villa/gen/colors.gen.dart';
import 'package:shop_villa/global/global_button.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import 'package:shop_villa/helper/appbar_title.dart';
import '../../../../global/app_text_style.dart';
import '../controllers/choose_delivery_address_controller.dart';

class ChooseDeliveryAddressView
    extends GetView<ChooseDeliveryAddressController> {
  const ChooseDeliveryAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        title: appbarTitle(text: 'Delivery Address'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              AddDeliveryAddressController addressController =
                  Get.put(AddDeliveryAddressController());
              addressController.clearForm();
              Get.toNamed(Routes.ADD_DELIVERY_ADDRESS);
            },
            icon: const Icon(Icons.add),
          ),
          5.width,
        ],
      ),
      body: Obx(
        () {
          if (controller.addressList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppTextStyle(
                    text: 'No Address Found',
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  20.height,
                  globalButton(
                      height: 35.h,
                      width: 150.w,
                      onTap: () {
                        AddDeliveryAddressController addressController =
                            Get.put(AddDeliveryAddressController());
                        addressController.clearForm();
                        Get.toNamed(Routes.ADD_DELIVERY_ADDRESS)!.then((_) {
                          controller.getAddressList();
                        });
                      },
                      text: 'Add Address',
                    fontSize: 14.sp
                  )
                ],
              ),
            );
          } else {
            return Obx(() {
              return ListView.builder(
                itemCount: controller.addressList.length,
                itemBuilder: (context, item) {
                  final address = controller.addressList[item];
                  final isSelected =
                      controller.selectedAddressId.value == address.id;
                  return GestureDetector(
                    onTap: () {
                      controller.selectAddress(address.id!);
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        // height: 150,
                        decoration: BoxDecoration(
                          color: ColorName.white,
                          border: Border.all(
                            color: isSelected
                                ? ColorName.primaryColor
                                : ColorName.white,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 3,
                              offset: Offset(2, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  AppTextStyle(
                                    text: address.label ?? ' ',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.sp,
                                    textAlign: TextAlign.start,
                                  ),
                                  10.width,
                                  const Spacer(),
                                  PopupMenuButton(
                                    surfaceTintColor: Colors.white,
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.edit_location_alt_rounded,
                                              color: ColorName.gray410,
                                            ),
                                            5.width,
                                            AppTextStyle(
                                              text: "Edit",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          Get.put(AddDeliveryAddressController())
                                              .setAddressForEditing(address);
                                          Get.toNamed(
                                              Routes.ADD_DELIVERY_ADDRESS);
                                        },
                                      ),
                                      PopupMenuItem(
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.delete_outline_rounded,
                                              color: ColorName.gray410,
                                            ),
                                            5.width,
                                            AppTextStyle(
                                              text: "Delete",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          controller.deleteAddress(address.id!);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              7.height,
                              Container(
                                width: Get.width,
                                height: 1.h,
                                color: Colors.pink.shade50,
                              ),
                              2.height,
                              AppTextStyle(
                                text: 'Name : ${address.name}',
                                fontSize: 14.sp,
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.w500,
                              ),
                              3.height,
                              AppTextStyle(
                                text: 'Phone : ${address.phone}',
                                fontSize: 14.sp,
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.w500,
                              ),
                              3.height,
                              AppTextStyle(
                                textAlign: TextAlign.start,
                                text: 'Email : ${address.email}',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              3.height,
                              AppTextStyle(
                                text: 'Address : ${address.address}',
                                fontSize: 14.sp,
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            });
          }
        },
      ),
    );
  }
}
