import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shop_villa/app/models/order%20place/user_orderlist_post_model.dart';
import 'package:shop_villa/app/modules/my_order/controllers/my_order_controller.dart';
import 'package:shop_villa/app/modules/my_order/widgets/delivery_status.dart';
import 'package:shop_villa/app/modules/profile/controllers/profile_controller.dart';
import 'package:shop_villa/app/routes/app_pages.dart';
import 'package:shop_villa/gen/colors.gen.dart';
import 'package:shop_villa/global/app_text_style.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';

class TrackOrder extends GetView<MyOrderController> {
  const TrackOrder({super.key, required this.myOrder});

  final MyOrder myOrder;

  @override
  Widget build(BuildContext context) {
    final activeStep = controller.getActiveStep(myOrder.status!);
    final profileController = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: ColorName.bgColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorName.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      5.height,
                      EasyStepper(
                        showTitle: false,
                        lineStyle: const LineStyle(
                          lineType: LineType.dotted,
                          unreachedLineColor: ColorName.gray70,
                          activeLineColor: ColorName.green,
                          finishedLineColor: ColorName.green,
                          lineThickness: 1.5,
                          lineSpace: 3,
                          unreachedLineType: LineType.dotted,
                        ),
                        alignment: Alignment.center,
                        activeStep: controller.getActiveStep(myOrder.status!),
                        stepShape: StepShape.circle,
                        stepBorderRadius: 32,
                        borderThickness: 2,
                        stepRadius: 28,
                        finishedStepBorderType: BorderType.dotted,
                        finishedStepBorderColor: Colors.grey,
                        finishedStepTextColor: Colors.black,
                        finishedStepBackgroundColor: ColorName.green,
                        stepAnimationCurve: Curves.bounceInOut,
                        activeStepIconColor: Colors.white,
                        unreachedStepBackgroundColor: ColorName.gray70,
                        unreachedStepTextColor: ColorName.gray70,
                        unreachedStepBorderColor: ColorName.gray70,
                        activeStepBorderColor: ColorName.green,
                        activeStepBackgroundColor: ColorName.green,
                        activeStepBorderType: BorderType.normal,
                        steps: [
                          EasyStep(
                            icon: Icon(
                              MdiIcons.packageVariantClosed,
                              color: ColorName.white,
                            ),
                          ),
                          EasyStep(
                            icon: Icon(
                              MdiIcons.packageVariantClosedCheck,
                              color: ColorName.white,
                            ),
                          ),
                          EasyStep(
                            icon: Icon(
                              MdiIcons.truckOutline,
                              color: ColorName.white,
                            ),
                          ),
                          EasyStep(
                            icon: Icon(
                              MdiIcons.packageVariant,
                              color: ColorName.white,
                            ),
                          ),
                        ],
                      ),
                      AppTextStyle(
                        text:
                            '${'Order has been'.tr} ${controller.statusDesc(activeStep)}',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      5.height,
                    ],
                  ),
                ),
              ),
              10.height,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorName.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      10.height,
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: AppTextStyle(
                          text: 'Delivery Status',
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ),
                      10.height,
                      Container(
                        height: 1,
                        width: Get.width,
                        color: Colors.pink.shade50,
                      ),
                      10.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EasyStepper(
                            showTitle: false,
                            lineStyle: const LineStyle(
                              lineType: LineType.dotted,
                              unreachedLineColor: ColorName.gray70,
                              activeLineColor: ColorName.green,
                              finishedLineColor: ColorName.green,
                              lineThickness: 1.5,
                              lineSpace: 3,
                              lineLength: 60,
                              unreachedLineType: LineType.dashed,
                            ),
                            alignment: Alignment.centerLeft,
                            activeStep: activeStep,
                            direction: Axis.vertical,
                            stepShape: StepShape.circle,
                            stepBorderRadius: 0,
                            borderThickness: 3,
                            stepRadius: 28,
                            finishedStepBorderType: BorderType.normal,
                            finishedStepBorderColor: Colors.grey,
                            finishedStepTextColor: Colors.black,
                            finishedStepBackgroundColor: ColorName.green,
                            stepAnimationCurve: Curves.bounceIn,
                            activeStepIconColor: Colors.black,
                            unreachedStepBackgroundColor: ColorName.gray70,
                            unreachedStepTextColor: ColorName.gray70,
                            unreachedStepBorderColor: ColorName.gray70,
                            activeStepBorderColor: ColorName.gray410,
                            activeStepBackgroundColor: ColorName.green,
                            activeStepBorderType: BorderType.normal,
                            steps: [
                              EasyStep(
                                customStep: controller.activeStep.value >= 1
                                    ? LoadingAnimationWidget.beat(
                                        size: 40,
                                        color: ColorName.white,
                                      )
                                    : const Icon(
                                        Icons.check_circle,
                                        color: ColorName.white,
                                      ),
                              ),
                              EasyStep(
                                customStep: controller.activeStep.value >= 2
                                    ? LoadingAnimationWidget.beat(
                                        size: 40,
                                        color: ColorName.white,
                                      )
                                    : const Icon(
                                        Icons.check_circle,
                                        color: ColorName.white,
                                      ),
                              ),
                              EasyStep(
                                customStep: controller.activeStep.value >= 3
                                    ? LoadingAnimationWidget.beat(
                                        size: 40,
                                        color: ColorName.white,
                                      )
                                    : const Icon(
                                        Icons.check_circle,
                                        color: ColorName.white,
                                      ),
                              ),
                              EasyStep(
                                customStep: controller.activeStep.value >= 4
                                    ? LoadingAnimationWidget.beat(
                                        size: 40,
                                        color: ColorName.white,
                                      )
                                    : const Icon(
                                        Icons.check_circle,
                                        color: ColorName.white,
                                      ),
                              ),
                            ],
                            onStepReached: (index) {
                              controller.activeStep.value = index;
                            },
                          ),
                          const DeliveryStatus(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Obx(() {
        final uniqueID = profileController.adminInfo[0].uniqueId!;
        return SpeedDial(
          closeDialOnPop: false,
          mini: false,
          backgroundColor: ColorName.green,
          icon: MdiIcons.messageTextOutline,
          iconTheme: const IconThemeData(color: ColorName.white),
          activeIcon: Icons.close,
          spacing: 5,
          openCloseDial: controller.isDialOpen,
          children: [
            SpeedDialChild(
              onTap: () {},
              label: 'Chat with CustomerCare'.tr,
              labelStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
              shape: const CircleBorder(),
              child: Container(
                height: 50.h,
                width: 50.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorName.green,
                ),
                child: IconButton(
                  onPressed: () {
                    Get.back();
                    Get.toNamed(Routes.CHATS, arguments: uniqueID);
                  },
                  icon: Icon(MdiIcons.account, color: ColorName.white),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
