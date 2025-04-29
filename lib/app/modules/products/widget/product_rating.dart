import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:rating_summary/rating_summary.dart';
import 'package:readmore/readmore.dart';
import 'package:shop_villa/global/methods/get_image_url.dart';
import 'package:shop_villa/global/parse_dateAndTime.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import 'package:shop_villa/helper/appbar_title.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/cached_network_image_builder.dart';
import '../../../models/Reviews/review_get_model.dart';
import '../../../models/product_details/product_details_model.dart';
import '../../../repository/api_endpoint.dart';
import '../productDetails/controllers/product_details_controller.dart';

class AllRatingView extends StatelessWidget {
  const AllRatingView({super.key, required this.product});

  final ProductDetailsData product;

  @override
  Widget build(BuildContext context) {
    final productDetailsController = Get.put(ProductDetailsController());
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        title: appbarTitle(text: 'Rating & Reviews'),
        centerTitle: true,
        backgroundColor: ColorName.bgColor,
        surfaceTintColor: ColorName.bgColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            AppTextStyle(
                text: product.productName!,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: ColorName.black),
            10.height,
            Obx(() {
              if (productDetailsController.isLoadingReviews.value) {
                return const SizedBox
                    .shrink(); // or any other loading indicator
              }
              if (productDetailsController.reviewList.isEmpty) {
                return Center(
                    child: AppTextStyle(
                  text: 'No Reviews Found',
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ));
              }
              return RatingSummary(
                counter: productDetailsController.reviewList.length,
                average: productDetailsController.reviewAvg.toDouble(),
                showAverage: true,
                counterFiveStars: 50,
                counterFourStars: 40,
                counterThreeStars: 30,
                counterTwoStars: 20,
                counterOneStars: 10,
                color: ColorName.yellowOcher,
                averageStyle:
                    TextStyle(fontSize: 35.sp, fontWeight: FontWeight.w800),
              );
            }),
            10.height,
            Expanded(
              child: ListView.builder(
                  itemCount: productDetailsController.reviewList.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final review = productDetailsController.reviewList[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                circularImage(
                                    radius: 22.r,
                                    imgUrl: review.user!.image!,
                                    imgRadius: 50,
                                    imgHeight: 45.h,
                                    imgWidth: 45.w),
                                10.width,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppTextStyle(
                                      text: review.userName!.capitalize! ?? '',
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    AppTextStyle(
                                      text: DateTimeUtils.formatTimeAgo(
                                          review.user!.updatedAt!.toString()),
                                      fontSize: 12.sp,
                                      color: ColorName.gray410,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: ColorName.yellowOcher,
                                  size: 20,
                                ),
                                AppTextStyle(
                                  text: review.rating.toString(),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            )
                          ],
                        ),
                        10.height,
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ReadMoreText(
                            review.text != null && review.text!.isNotEmpty
                                ? review.text!
                                : '',
                            trimMode: TrimMode.Line,
                            trimLines: 2,
                            colorClickableText: ColorName.primaryColor,
                            trimCollapsedText: 'show more',
                            trimExpandedText: 'show less',
                            moreStyle: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                        10.height,
                        review.image != null && review.image!.isNotEmpty
                            ? Align(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  height: 100.h,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 1,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      if (review.image == null) {
                                        return const SizedBox.shrink();
                                      } else {
                                        return RatingImageView(
                                          product: review,
                                          index: index,
                                        );
                                      }
                                    },
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class RatingImageView extends StatelessWidget {
  const RatingImageView({
    super.key,
    required this.product,
    required this.index,
  });

  final GetReviews product;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InstaImageViewer(
        child: CachedNetworkImage(
          imageUrl: GetImageUrl.url(product.image!),
          imageBuilder: (context, imageProvider) => Container(
            height: 100.h,
            width: 100.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
