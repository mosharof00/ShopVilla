
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/models/product/porduct_model_api.dart';
import 'package:shop_villa/app/modules/flashSales/controllers/flash_sales_controller.dart';
import 'package:shop_villa/helper/helper_utils.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../routes/app_pages.dart';
import '../../flashSales/widget/flash_widget.dart';
import '../controllers/home_controller.dart';

class FlashSalesHome extends StatelessWidget {
  const FlashSalesHome({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Container(
      height: 332.h,
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: Colors.teal.shade50,
      ),
      child: Padding(
        padding:  EdgeInsets.all(8.0.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppTextStyle(
                      text: 'Flash Sales',
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorName.black,
                    ),
                    // SizedBox(
                    //   width: 5.w,
                    // ),
                    // Container(
                    //   padding: const EdgeInsets.only(left: 5, right: 5),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(5),
                    //     color: ColorName.black,
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       const Icon(
                    //         Icons.timer,
                    //         color: ColorName.yellowOcher,
                    //         size: 15,
                    //       ),
                    //       2.width,
                    //       TimerCountdown(
                    //         spacerWidth: 3,
                    //         timeTextStyle: TextStyle(
                    //           fontWeight: FontWeight.w400,
                    //           fontSize: 10.sp,
                    //           color: ColorName.yellow,
                    //         ),
                    //         colonsTextStyle: TextStyle(
                    //           color: ColorName.yellowOcher,
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 14.sp,
                    //         ),
                    //         enableDescriptions: false,
                    //         format: CountDownTimerFormat.hoursMinutesSeconds,
                    //         endTime: DateTime.now().add(
                    //           const Duration(
                    //             days: 1,
                    //             hours: 00,
                    //             minutes: 01,
                    //             seconds: 05,
                    //           ),
                    //         ),
                    //         onEnd: () {
                    //           if (kDebugMode) {
                    //             print("Timer finished");
                    //           }
                    //         },
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        FlashSalesController flashSalesController =
                            Get.put(FlashSalesController());
                        flashSalesController.flashSalesList.value =
                            controller.flashSalesList;
                        flashSalesController.flashSaleCurrentPage.value = 1;
                        flashSalesController.selectedFilterTypeName.value =
                            HelperUtils.flashSales;
                        Get.toNamed(Routes.FLASH_SALES);
                      },
                      child: Row(
                        children: [
                          AppTextStyle(
                            text: 'View All',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            size: 22,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.flashSalesList.length,
                itemBuilder: (context, index) {
                  final ProductData product =
                  controller.flashSalesList[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8, right: 10),
                    child: Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(20.r),
                        child: FlashWidget(
                          product: product,
                          item: index,
                        )),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
