import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import '../../app/modules/my_order/controllers/my_order_controller.dart';
import '../../gen/assets.gen.dart';
import '../../gen/colors.gen.dart';
import '../app_text_style.dart';

Future cancelOrderBottomSheet({
  required BuildContext context,
  required VoidCallback noOnTap,
  required VoidCallback yesOnTap,
   VoidCallback? onTapTermsAndConditionTest,
  String? yesButtonText,
  String? noButtonText,
  String? title,
  String? subtitle,
  String? description1,
  String? description2,
  String? description3,
}) {
  return showModalBottomSheet(
    useSafeArea: true,
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            5.height,
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 2.h,
                width: 35.w,
                color: Colors.grey.shade300,
              ),
            ),
            10.height,
            Align(
                alignment: Alignment.topCenter,
                child: AppTextStyle(
                  text: title ?? 'Cancel Order',
                  color: Colors.red,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                )),
            10.height,
            Divider(
              color: Colors.grey.shade300,
            ),
            5.height,
            AppTextStyle(
              text: subtitle ?? 'Are you sure you want to cancel the order?',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            10.height,
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                onEnter: (value){
                  print(value.toString());
                },
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ), // Apply base style
                children: [
                  TextSpan(
                    text: description1 ??
                        "It's okay to change your mind! your payment will be safely refunded."
                            .tr,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap = onTapTermsAndConditionTest ?? (){debugPrint("onTapped TermsAndConditionTest");},
                    text: description2 ?? " Terms & Conditions".tr,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: ColorName.primaryColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  TextSpan(
                    text: description3 ?? 'may apply.'.tr,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            10.height,
            Divider(
              color: Colors.grey.shade300,
            ),
            15.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: noOnTap,
                  child: Container(
                    height: 40.h,
                    width: 150.w,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Center(
                      child: AppTextStyle(
                        text: noButtonText ?? "No, Don't Cancel",
                        color: ColorName.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: yesOnTap,
                  child: Container(
                    height: 40.h,
                    width: 150.w,
                    decoration: BoxDecoration(
                      color: ColorName.primaryColor,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Center(
                      child: AppTextStyle(
                        text: yesButtonText ?? "Yes, Cancel Order",
                        color: ColorName.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            15.height
          ],
        ),
      );
    },
  );
}

Future cancelReasonBottomSheet({
  required BuildContext context,
  required VoidCallback okOnTap,
  required VoidCallback noOnTap,
  String? title,
}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            5.height,
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 2.h,
                width: 35.w,
                color: Colors.grey.shade300,
              ),
            ),
            10.height,
            Align(
              alignment: Alignment.topCenter,
              child: AppTextStyle(
                text: title ?? 'Cancellation Reason',
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            10.height,
            Divider(
              color: Colors.grey.shade300,
            ),
            10.height,
            ListView.builder(
                // physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount:
                    Get.find<MyOrderController>().cancelReasonsList.length,
                itemBuilder: (context, index) {
                  return TextButton(
                      onPressed: () {
                        Get.find<MyOrderController>()
                            .selectedReasonOptionIndex
                            .value = index;
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(() {
                            bool selected = Get.find<MyOrderController>()
                                    .selectedReasonOptionIndex
                                    .value ==
                                index;
                            return selected
                                ? SvgPicture.asset(
                                    Assets.icons.roundFillButtonIcon,
                                    width: 15.w,
                                    height: 15.h,
                                    colorFilter: const ColorFilter.mode(
                                        ColorName.primaryColor,
                                        BlendMode.srcIn),
                                  )
                                : SvgPicture.asset(
                                    Assets.icons.roundOutlineButtonIcon,
                                    width: 15.w,
                                    height: 15.h,
                                    colorFilter: const ColorFilter.mode(
                                        ColorName.black, BlendMode.srcIn),
                                  );
                          }),
                          15.width,
                          Expanded(
                            child: AppTextStyle(
                              text: Get.find<MyOrderController>()
                                  .cancelReasonsList[index],
                              maxLines: 2,
                              textAlign: TextAlign.start,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ));
                }),
            10.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: noOnTap,
                  child: Container(
                    height: 40.h,
                    width: 150.w,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Center(
                      child: AppTextStyle(
                        text: "Cancel",
                        color: ColorName.primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: okOnTap,
                  child: Container(
                    height: 40.h,
                    width: 150.w,
                    decoration: BoxDecoration(
                      color: ColorName.primaryColor,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Center(
                      child: AppTextStyle(
                        text: "Confirm",
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            15.height
          ],
        ),
      );
    },
  );
}
