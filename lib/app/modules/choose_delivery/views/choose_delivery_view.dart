import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa/gen/colors.gen.dart';
import 'package:shop_villa/global/app_text_style.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import '../controllers/choose_delivery_controller.dart';

class ChooseDeliveryView extends GetView<ChooseDeliveryController> {
  const ChooseDeliveryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        title: const AppTextStyle(text: 'Delivery'),
        centerTitle: true,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: controller.logos.length,
        itemBuilder: (context, item) {

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                controller.containerClicks.value = item;
              },
              child: Obx((){
                final isSelected = controller.containerClicks.value;
                final select = isSelected == item;
                final borderColor = select ? Colors.green : Colors.transparent;
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color:
                        borderColor),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        imageUrl: controller.logos[item],
                        imageBuilder: (context, imageProvider) =>
                            Container(
                              width: 80.w,
                              height: 80.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.fill),
                              ),
                            ),
                      ),
                      15.width,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextStyle(
                              text: controller.logosName[item],
                              textAlign: TextAlign.start,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            3.height,
                            AppTextStyle(
                              text: 'Estimated arrival: 23 - 24 April',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: ColorName.gray410,
                            ),
                            3.height,
                            AppTextStyle(
                              text: '100 TK',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: ColorName.onPrimary,
                            )
                          ],
                        ),
                      ),
                      5.width,
                      select ? const Icon(Icons.check, color: Colors.green,) : const SizedBox() ,
                    ],
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
