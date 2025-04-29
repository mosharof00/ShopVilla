
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/modules/promos_vouchers/widget/promos_list.dart';
import 'package:shop_villa/gen/colors.gen.dart';
import 'package:shop_villa/global/app_input_textformfield.dart';
import 'package:shop_villa/global/app_linear_gradient.dart';
import 'package:shop_villa/global/app_text_style.dart';
import 'package:shop_villa/global/global_button.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import 'package:shop_villa/helper/appbar_title.dart';
import '../controllers/promos_vouchers_controller.dart';

class PromosVouchersView extends GetView<PromosVouchersController> {
  const PromosVouchersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        title: appbarTitle(text: 'Promos & Vouchers'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: ColorName.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    3.height,
                    AppTextStyle(
                      text: 'Have a Promo Code?',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    5.height,
                    Container(
                      width: Get.width,
                      height: 1,
                      color: Colors.pink.shade100,
                    ),
                    10.height,
                    Row(
                      children: [
                        Expanded(
                            child: AppInputTextFormField(
                          controller: controller.codeTextEditor,
                          hintText: 'Enter Code Here',
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                        )),
                        10.width,
                        globalButton(
                            onTap: () {
                              controller.codeTextEditor.value.text.isNotEmpty
                                  ? controller.applyPromos(
                                      code: controller.codeTextEditor.text)
                                  : Get.snackbar(
                                      'Promos', 'Please Enter your Code');
                            },
                            text: 'Redeem',
                            width: Get.width / 3,
                            height: 40,
                            gradient: appSecondLinearGradient(),
                            shadowColor: Colors.transparent,
                            blurRadius: 0,
                            fontSize: 14.sp,
                            borderRadius: BorderRadius.circular(18)),
                        5.width,
                      ],
                    ),
                    10.height,
                  ],
                ),
              ),
            ),
            Obx(() {
              return Expanded(
                child: ListView.builder(
                  itemCount: controller.promosList.length,
                  itemBuilder: (context, item) {
                    final promo = controller.promosList[item];
                    return PromosList(
                      promo: promo,
                      item: item,
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
