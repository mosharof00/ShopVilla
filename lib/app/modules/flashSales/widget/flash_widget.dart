import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/models/product/porduct_model_api.dart';
import 'package:shop_villa/app/modules/flashSales/widget/perchentage.dart';
import 'package:shop_villa/gen/colors.gen.dart';
import 'package:shop_villa/global/app_text_style.dart';
import 'package:shop_villa/global/app_text_style_over_flow.dart';
import 'package:shop_villa/global/methods/get_image_url.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../global/methods/get_currency.dart';
import '../../../../global/shimmer_loading.dart';
import '../../../routes/app_pages.dart';
import '../../products/productDetails/controllers/product_details_controller.dart';

class FlashWidget extends StatelessWidget {
  const FlashWidget({super.key, required this.product, required this.item});
  final ProductData product;
  final int item;
  // final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          Routes.PRODUCT_DETAILS,
          arguments: {
            'productID': product.id,
          },
          preventDuplicates: false,
        );
        Get.put(ProductDetailsController()).getProductDetails(product.id!);
      },
      child: SizedBox(
        width: Get.width / 2.w,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: ColorName.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.r),
                        topLeft: Radius.circular(20.r)),
                    child: CachedNetworkImage(
                        height: 170.h,
                        width: Get.width / 2.w, // change for staggered widget
                        imageUrl: GetImageUrl.url(
                            product.productvariations![0].image!),
                        fit: BoxFit.fill,
                        placeholder: (context, url) => shimmerLoadingWidget(
                            height: 170.h, width: Get.width / 2.w),
                        errorWidget: (context, url, error) => SvgPicture.asset(
                              Assets.images.errorThumbnail,
                              width: Get.width, // Keep consistent sizing
                            )),
                  ),
                  product.sizes![0].regularPrice != product.sizes![0].salePrice
                      ? Positioned(
                          top: 10,
                          left: 10,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: ColorName.yellowOcher,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: AppTextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                text:
                                    '${GetPercentage.percent(regularPrice: product.sizes![0].regularPrice!, salePrice: product.sizes![0].salePrice!).toInt()}%',
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.r, left: 8.r, right: 8.r),
                child: AppTextStyleOverFlow(
                  text: product.productName!,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.r, right: 8.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppTextStyle(
                      text: GetCurrency.concatWithCurrency(
                        product.sizes![0].salePrice.toString(),
                        GetCurrency.currencySymbol,
                      ),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    8.width,
                    AppTextStyle(
                      text: GetCurrency.concatWithCurrency(
                        product.sizes![0].regularPrice.toString(),
                        GetCurrency.currencySymbol,
                      ),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.lineThrough,
                      color: ColorName.gray410,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.r, left: 8.r, right: 8.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppTextStyle(
                        text: "${product.sold} ${'sold'.tr}",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: ColorName.gray410),
                    product.reviewsAvgRating == 0.0
                        ? const SizedBox.shrink()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.star,
                                color: ColorName.amber,
                                size: 15.r,
                              ),
                              2.width,
                              AppTextStyle(
                                  text: product.reviewsAvgRating.toString(),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600),
                            ],
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
