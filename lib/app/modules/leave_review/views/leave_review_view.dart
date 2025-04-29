import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shop_villa/app/models/order%20place/user_orderlist_post_model.dart';
import 'package:shop_villa/app/modules/leave_review/widget/leaveareview_textfield.dart';
import 'package:shop_villa/gen/colors.gen.dart';
import 'package:shop_villa/global/global_button.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/app_text_style_over_flow.dart';
import '../../../../global/bottomSheet/custom_bottom_sheet.dart';
import '../../../../global/cached_network_image_builder.dart';
import '../controllers/leave_review_controller.dart';

class LeaveReviewView extends GetView<LeaveReviewController> {
  const LeaveReviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const AppTextStyle(text: 'Leave a Review'),
        centerTitle: true,
        backgroundColor: ColorName.bgColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.myOrder.orderproducts!.length,
                itemBuilder: (context, item) {
                  final Orderproduct orderProduct =
                      controller.myOrder.orderproducts![item];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: ColorName.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Product Info Section
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: cachedImageHelper(
                                  radius: 15.r,
                                  imgurl: orderProduct.productvariation!.image!,
                                  imgHeight: 120.h,
                                  imgWidth: 120.w,
                                  shimmerHeight: 150,
                                ),
                              ),
                              10.width,
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppTextStyleOverFlow(
                                      text: orderProduct.productName!,
                                      maxLines: 2,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                    ),
                                    Row(
                                      children: [
                                        AppTextStyle(
                                          text: '${'Price'.tr} :',
                                          fontSize: 12.sp,
                                        ),
                                        5.width,
                                        AppTextStyle(
                                          text: '৳ ${orderProduct.price}',
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                                    // Rating Section
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppTextStyle(
                                          text: 'Rate your Order',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.sp,
                                        ),
                                        Row(
                                          children: [
                                            Obx(() {
                                              return Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: controller
                                                              .isRatingValid[
                                                                  item]
                                                              .value
                                                          ? Colors.transparent
                                                          : Colors
                                                              .red, // Highlight if invalid
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.r)),
                                                child: RatingBar.builder(
                                                  initialRating: controller
                                                      .ratings[item].value,
                                                  minRating: 0,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  unratedColor:
                                                      ColorName.gray70,
                                                  itemSize: 25,
                                                  itemCount: 5,
                                                  itemPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 4.0),
                                                  itemBuilder: (context, _) =>
                                                      Icon(
                                                    MdiIcons.star,
                                                    color: Colors.orange,
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                    controller.ratings[item]
                                                        .value = rating;
                                                  },
                                                ),
                                              );
                                            }),
                                            5.width,
                                            Obx(() {
                                              return AppTextStyle(
                                                text: controller
                                                    .ratings[item].value
                                                    .toString(),
                                                color: ColorName.yellowOcher,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14.sp,
                                              );
                                            }),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // Review and Image Section
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: ColorName.white,
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppTextStyle(
                                        text: 'Leave a Review',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15.sp,
                                        textAlign: TextAlign.start,
                                      ),
                                      10.height,
                                      LeaveReviewTextField(
                                        controller.reviewController[item],
                                        item,
                                      ),
                                      5.height,
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Obx(() => Row(
                                              children: [
                                                Obx(() => Container(
                                                      height: 50.h,
                                                      width: 50.w,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: controller
                                                                    .selectedImages[
                                                                        item]
                                                                    .value !=
                                                                null
                                                            ? DecorationImage(
                                                                image: FileImage(
                                                                    File(controller
                                                                        .selectedImages[
                                                                            item]
                                                                        .value!
                                                                        .path)),
                                                                fit: BoxFit
                                                                    .cover,
                                                              )
                                                            : null,
                                                      ),
                                                      child: Container(
                                                        height: 20.h,
                                                        width: 20.w,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              ColorName.gray70,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Obx(() {
                                                          return GestureDetector(
                                                            onTap: () {
                                                              customBottomSheet(
                                                                context:
                                                                    context,
                                                                onTap1: () {
                                                                  controller
                                                                      .getProfileImageFromFile(
                                                                          item);
                                                                  Get.back();
                                                                },
                                                                svgIcon1: Assets
                                                                    .icons
                                                                    .fileIcon,
                                                                text1: 'File',
                                                                onTap2: () {
                                                                  controller
                                                                      .getProfileImageFromCamera(
                                                                          item);
                                                                  Get.back();
                                                                },
                                                                svgIcon2: Assets
                                                                    .icons
                                                                    .cameraIcon,
                                                                text2: 'Camera',
                                                              );
                                                            },
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                border:
                                                                    Border.all(
                                                                  color: controller
                                                                              .selectedImages[
                                                                                  item]
                                                                              .value ==
                                                                          null
                                                                      ? Colors
                                                                          .transparent
                                                                      : ColorName
                                                                          .green,
                                                                ),
                                                              ),
                                                              child:  Icon(
                                                                MdiIcons.camera,
                                                                size: 30,
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                      ),
                                                    )),
                                                controller.selectedImages[item]
                                                            .value !=
                                                        null
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 10.0),
                                                        child: CircleAvatar(
                                                          radius: 28,
                                                          backgroundImage:
                                                              FileImage(
                                                            File(
                                                              controller
                                                                  .selectedImages[
                                                                      item]
                                                                  .value!
                                                                  .path,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : const SizedBox.shrink()
                                              ],
                                            )),
                                      ),
                                      8.height,
                                      globalButton(
                                        onTap: () {
                                          if (controller.validateInputs(item)) {
                                            controller.addReview(
                                              productID: orderProduct.productId!,
                                              text: controller.reviewController[item].text,
                                              rating: controller.ratings[item].value,
                                              file: controller.selectedImages[item].value?.path, // Image path or null
                                            );
                                            Get.back();
                                          } else {
                                            Get.snackbar('Leave a review', 'Fill all required fields');
                                          }
                                        },

                                        text: 'Submit Review',
                                        borderRadius: BorderRadius.circular(15),
                                        shadowColor: Colors.transparent,
                                        height: 35.h,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
