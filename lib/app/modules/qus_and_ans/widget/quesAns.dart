import 'package:comment_tree/comment_tree.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/models/q&a/q&aGetModel.dart';
import 'package:shop_villa/app/modules/products/productDetails/controllers/product_details_controller.dart';
import 'package:shop_villa/gen/assets.gen.dart';
import 'package:shop_villa/global/loading_animation_widget.dart';
import 'package:shop_villa/global/parse_dateAndTime.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';

import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/cached_network_image_builder.dart';

class QusAns extends StatelessWidget {
  const QusAns({super.key, this.physics});
  final ScrollPhysics? physics;
  @override
  Widget build(BuildContext context) {
    final productDetailsController = Get.find<ProductDetailsController>();
    return Obx(() {
      if (productDetailsController.isLoadingQalist.value) {
        return loadingAnimationWidget();
      } else if (productDetailsController.qusAnsList.isEmpty) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.images.ques, height: 120.h,width: 130.w,),
            5.height,
            Center(
              child: AppTextStyle(
                text: 'No Q&A Found',
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
          ],
        );
      } else {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: productDetailsController.qusAnsList.length,
            physics: physics ?? const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, item) {
              final QusAnsGetList qusAnsGetList =
                  productDetailsController.qusAnsList[item];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CommentTreeWidget<Comment, Comment>(
                      Comment(
                        avatar: 'null',
                        userName: 'null',
                        content: qusAnsGetList.question!,
                      ),
                      qusAnsGetList.reply!.map((reply) {
                        return Comment(
                          avatar: 'null',
                          userName: 'null',
                          content: reply.answer!,
                        );
                      }).toList(),
                      treeThemeData: const TreeThemeData(
                          lineColor: ColorName.gray410, lineWidth: 2),
                      avatarRoot: (context, data) => PreferredSize(
                        preferredSize: Size.fromRadius(18.r),
                        child: circularImage(
                            imgUrl: qusAnsGetList.user!.image!,
                            radius: 20.r,
                            imgRadius: 50.r,
                            imgWidth: 40.w,
                            imgHeight: 40
                                .h), // cachedImageHelper(imgurl: GetImageUrl.url(), imgWidth: 30.w, imgHeight: 30.h),
                      ),
                      avatarChild: (context, data) => PreferredSize(
                        preferredSize: Size.fromRadius(12.r),
                        child: circularImage(
                            imgUrl: qusAnsGetList.admin!.image!,
                            radius: 15.r,
                            imgRadius: 50.r,
                            imgWidth: 30.w,
                            imgHeight: 30.h),
                      ),
                      contentChild: (context, data) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextStyle(
                              text: data.content!,
                              fontSize: 12.sp,
                              textAlign: TextAlign.start,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppTextStyle(
                                  text:
                                      '${qusAnsGetList.admin!.name!.capitalize} |',
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                  color: ColorName.gray410,
                                ),
                                5.width,
                                AppTextStyle(
                                  text: DateTimeUtils.formatTimeAgo(qusAnsGetList
                                      .reply!
                                      .firstWhere((reply) =>
                                          reply.answer == data.content)
                                      .createdAt!
                                      .toString()),
                                  fontSize: 10.sp,
                                  color: ColorName.gray410,
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                      contentRoot: (context, data) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextStyle(
                              text: qusAnsGetList.question!,
                              fontSize: 12.sp,
                              textAlign: TextAlign.start,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppTextStyle(
                                  text:
                                      '${qusAnsGetList.user!.name!.capitalize} |',
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                  color: ColorName.gray410,
                                ),
                                5.width,
                                AppTextStyle(
                                  text: DateTimeUtils.formatTimeAgo(
                                      qusAnsGetList.createdAt!.toString()),
                                  fontSize: 10.sp,
                                  color: ColorName.gray410,
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }
    });
  }
}
