import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa/gen/colors.gen.dart';
import 'package:shop_villa/global/app_text_style.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import 'package:shop_villa/helper/appbar_title.dart';
import '../../../../../global/methods/get_image_url.dart';
import '../../../../models/payment_method/payment_method.dart';
import '../controllers/payment_methods_controller.dart';

class PaymentMethodsView extends GetView<PaymentMethodsController> {
  const PaymentMethodsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        title: appbarTitle(text: 'Payment Methods'),
        surfaceTintColor: ColorName.bgColor,
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Get.toNamed(Routes.ADD_NEW_PAYMENT);
        //       },
        //       icon: const Icon(Icons.add))
        // ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: controller.paymentTypeList.length,
                itemBuilder: (context, index) {
                  final PaymentType payment = controller.paymentTypeList[index];
                  return Padding(
                    padding: EdgeInsets.only(
                        left: 10.w, right: 10.w, top: 10.h, bottom: 15.h),
                    child: InkWell(
                      onTap: () {
                        controller.paymentSelectIndex.value = index;
                        Get.back();
                      },
                      child: Obx(() {
                        final bool isSelected =
                            controller.paymentSelectIndex.value == index;
                        return Material(
                          elevation: isSelected ? 5 : 0,
                          borderRadius: BorderRadius.circular(10.r),
                          child: Container(
                            height: 75.h,
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: ColorName.white,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                10.width,

                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(GetImageUrl.url(payment.image!)),
                                    radius: 30.r,
                                  ),
                                ),
                                const Spacer(),
                                AppTextStyle(
                                  text: payment.status!,
                                  color: isSelected
                                      ? ColorName.primaryColor
                                      : ColorName.black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
