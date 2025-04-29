import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shop_villa/app/models/coupon/coupon_get_model.dart';
import 'package:shop_villa/app/modules/promos_vouchers/controllers/promos_vouchers_controller.dart';
import 'package:shop_villa/app/modules/promos_vouchers/widget/shape.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/awesome_dialog_login.dart';
import '../../../../global/bottomSheet/cancel_order_bottom_sheet.dart';
import '../../../../global/bottomSheet/success_bottom_sheet.dart';
import '../../../../helper/helper_utils.dart';
import '../../../routes/app_pages.dart';

class PromosList extends StatelessWidget {
  const PromosList({super.key, required this.promo, this.item});

  final Promos promo;
  final int? item;

  @override
  Widget build(BuildContext context) {
    final promoController = Get.put(PromosVouchersController());
    return ClipPath(
      clipper: CustomContainerClipper(),
      child: GestureDetector(
        onTap: HelperUtils.isLogin
            ? () {
                promoController.containerSelect.value = item!;
                Get.currentRoute == '/products/product-details' ? const SizedBox.shrink() :
                cancelOrderBottomSheet(
                    context: context,
                    noOnTap: () {
                      Get.back();
                      successBottomSheet(
                          icons: Icons.cancel,
                          text: 'Promos didn\'t Redeemed',
                          context: context);
                    },
                    yesOnTap: () async {
                      Get.back();
                      promoController.selectPromos(promo.id!, promo.amount!, promo.code.toString());
                      Get.back();
                    },
                    title: 'Want to Use this Promo?',
                    subtitle: 'Are you sure want to use this promo?',
                    description1: '',
                    description2: '',
                    description3: '',
                    yesButtonText: 'Yes',
                    noButtonText: 'No');
              }
            : () {
                DialogUtils.showWarningDialog(
                  dismissOnBackKeyPress: false,
                  dismissOnTouchOutside: true,
                  context: Get.context!,
                  title: 'You have no Order',
                  description: 'Please Log In',
                  onOkPressed: () {
                    Get.toNamed(Routes.LOGIN);
                  },
                );
              },
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10, right: 10),
          child: Container(
            height: 90.h,
            width: 250.w,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                10.width,
                Container(
                  height: 40.h,
                  width: 40.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorName.primaryColor,
                  ),
                  child: Icon(
                    MdiIcons.brightnessPercent,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                10.width,
                // scroll == Axis.horizontal ? 10.width : .width,
                // 5.width,
                DottedBorder(
                  padding: EdgeInsets.zero,
                  dashPattern: const [3],
                  color: ColorName.gray410,
                  child: Container(
                    height: 80.h,
                    width: 0.w,
                    color: Colors.transparent,
                  ),
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppTextStyle(
                      text: promo.code!,
                      fontSize: 14.sp,
                      color: Colors.black,
                      height: 1.5,
                      fontWeight: FontWeight.w600,
                    ),
                    0.height,
                    AppTextStyle(
                      text: "${promo.type}: ${promo.amount!}",
                      fontSize: 11.sp,
                      color: Colors.black,
                      height: 1.5,
                      fontWeight: FontWeight.w600,
                    ),
                    0.height,
                    AppTextStyle(
                      text:
                      "Validity: ${promo.validity!.toString().split(' ')[0]}",
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
    // return GestureDetector(
    //   onTap: () {
    //     promoController.containerSelect.value = item!;
    //     awesomeAlertDialog(
    //       context,
    //       DialogType.question,
    //       'Want to Use this Promo?',
    //       'Are you sure want to use this promo?',
    //       'No',
    //       () {
    //         successBottomSheet(
    //             icons: Icons.cancel,
    //             text: 'Promos didn\'t Redeemed',
    //             context: context);
    //       },
    //       'Yes',
    //       () {
    //         successBottomSheet(
    //             text: 'Promos Redeemed Successfully', context: context);
    //       },
    //     );
    //   },
    //   child: Obx(() {
    //     final isSelected = promoController.containerSelect.value;
    //     final select = isSelected == item;
    //     return SizedBox(
    //       width: 210.w,
    //       child: CouponCard(
    //         firstChild: Container(
    //           // width: 100,
    //           decoration: BoxDecoration(
    //               gradient: appBlueGradient(),
    //               border: select
    //                   ? Border.all(color: ColorName.bgColorWhite)
    //                   : Border.all(color: ColorName.gray70)),
    //           child: Center(
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 const Spacer(),
    //                 AppTextStyle(
    //                   text: 'SALE',
    //                   fontWeight: FontWeight.w500,
    //                   fontSize: 12.sp,
    //                   color: ColorName.white,
    //                 ),
    //                 10.height,
    //                 AppTextStyle(
    //                   text: promo.validity!.toString().split(' ')[0],
    //                   color: ColorName.white,
    //                   fontWeight: FontWeight.w600,
    //                   fontSize: 9.sp,
    //                 ),
    //                 const Spacer(),
    //               ],
    //             ),
    //           ),
    //         ),
    //         border: BorderSide(color: ColorName.black.withOpacity(0.3)),
    //         borderRadius: 10.r,
    //         secondChild: Container(
    //           decoration: BoxDecoration(
    //             gradient: appBlueGradient(),
    //               border: select
    //                   ? Border.all(color: ColorName.bgColorWhite)
    //                   : Border.all(color: ColorName.gray70)),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               10.height,
    //               AppTextStyle(
    //                 text: 'Cupon Code',
    //                 fontSize: 10.sp,
    //                 color: ColorName.white,
    //               ),
    //               2.height,
    //               AppTextStyle(
    //                 text: promo.code!,
    //                 fontSize: 12.sp,
    //                 color: ColorName.white,
    //                 fontWeight: FontWeight.w700,
    //               ),
    //
    //             ],
    //           ),
    //         ),
    //         backgroundColor: ColorName.bgColorWhite,
    //         curveAxis: Axis.vertical,
    //       ),
    //     );
    //   }),
    // );
  }
}
