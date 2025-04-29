import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:shop_villa/global/parse_dateAndTime.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../global/cached_network_image_builder.dart';
import '../../../../models/Reviews/review_get_model.dart';
import '../../../../models/product_details/product_details_model.dart';
import '../../widget/product_rating.dart';
import '../controllers/product_details_controller.dart';

class ProductReviews extends StatelessWidget {
  const ProductReviews({super.key, required this.product});
  final ProductDetailsData product;
  @override
  Widget build(BuildContext context) {
    final productDetailsController = Get.put(ProductDetailsController());
    return SizedBox(
      height: 200.h,
      child: ListView.builder(
        itemCount: productDetailsController.reviewList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final GetReviews review = productDetailsController.reviewList[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      circularImage(
                          radius: 20.r,
                          imgUrl: review.user!.image!,
                          imgRadius: 50,
                          imgHeight: 50.h,
                          imgWidth: 50.w),
                      10.width,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(review.userName!.capitalize!,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600)),
                          Text(
                              DateTimeUtils.parseDate(
                                  review.user!.updatedAt!.toString()),
                              style: TextStyle(
                                  fontSize: 12.sp, color: ColorName.gray410)),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: ColorName.amber, size: 20),
                      Text(review.rating.toString(),
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ),
              10.height,
              if (review.text != null)
                Align(
                  alignment: Alignment.centerLeft,
                  child: ReadMoreText(
                    review.text!,
                    trimMode: TrimMode.Line,
                    trimLines: 2,
                    colorClickableText: ColorName.primaryColor,
                    trimCollapsedText: 'See more',
                    trimExpandedText: 'See less',
                    moreStyle:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              SizedBox(
                height: review.image != null ? 100.h : 0.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 1,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: review.image == null
                          ? const SizedBox.shrink()
                          : RatingImageView(
                              product: review,
                              index: index,
                            ),
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
