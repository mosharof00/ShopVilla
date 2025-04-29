import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/modules/home/controllers/home_controller.dart';
import 'package:shop_villa/global/methods/get_image_url.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import '../app/models/product/porduct_model_api.dart';
import '../app/modules/products/controllers/products_controller.dart';
import '../app/modules/products/productDetails/controllers/product_details_controller.dart';
import '../app/routes/app_pages.dart';
import '../gen/assets.gen.dart';
import '../gen/colors.gen.dart';
import '../global/app_text_style.dart';
import '../global/app_text_style_over_flow.dart';
import '../global/awesome_dialog_login.dart';
import '../global/methods/get_currency.dart';
import '../global/shimmer_loading.dart';
import 'helper_utils.dart';

class ProductLayout extends StatelessWidget {
  const ProductLayout({
    super.key,
    required this.product,
    this.height,
    this.index,
  });
  final ProductData product;
  final int? index;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    return InkWell(
      onTap: () {
        Get.toNamed(
          Routes.PRODUCT_DETAILS,
          arguments: {
            'productID': product.id,
          },
          // preventDuplicates: false,
        );
        Get.put(ProductDetailsController()).getProductDetails(product.id!);
      },
      child: Padding(
        padding: EdgeInsets.all(8.r),
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(20.r),
          child: Container(
            width: Get.width / 1.9.w,
            height: 260.h,
            decoration: BoxDecoration(
              color: ColorName.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Obx(
              () {
                final productController = Get.put(ProductsController());
                final price = product
                    .sizes![productController.selectedVariationIndex.value];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        // Hero(
                        // tag: Get.currentRoute == Routes.PRODUCT_DETAILS
                        //     ? "productDetails_${product.id}"
                        //     : product.id!,
                        // child:
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.r),
                              topLeft: Radius.circular(20.r)),
                          child: CachedNetworkImage(
                            height: 180.h,
                            width: Get.width /
                                1.8.w, // change for staggered widget
                            imageUrl: GetImageUrl.url(
                                product.productvariations![0].image!),
                            fit: BoxFit.fill,
                            placeholder: (context, url) => shimmerLoadingWidget(
                              height: 180.h,
                              width: Get.width / 1.9.w,
                            ),
                            errorWidget: (context, url, error) => SvgPicture.asset(
                              Assets.images.errorThumbnail,
                              width: Get.width, // Keep consistent sizing
                            )
                          ),
                        ),
                        // ),
                        Positioned(
                          top: 10.h,
                          right: 10.w,
                          child: InkWell(
                              onTap: HelperUtils.isLogin
                                  ? () {
                                      if (homeController.wishListedProductId
                                          .contains(product.id)) {
                                        homeController.removeToWishlist(
                                            productId: product.id!);
                                      } else {
                                        homeController.addToWishlist(
                                            productId: product.id!,
                                            productVariationId: product
                                                .productvariations![0].id!,
                                            productSizeId:
                                                product.sizes![0].id!);
                                      }
                                    }
                                  : () {
                                      DialogUtils.showWarningDialog(
                                        dismissOnBackKeyPress: false,
                                        dismissOnTouchOutside: true,
                                        context: Get.context!,
                                        title: 'Want to Wishlist this Item',
                                        description: 'Please Log In',
                                        onOkPressed: () {
                                          Get.toNamed(Routes.LOGIN);
                                        },
                                      );
                                    },
                              child: Icon(
                                homeController.wishListedProductId
                                        .contains(product.id)
                                    ? Icons.favorite
                                    : Icons.favorite,
                                color: homeController.wishListedProductId
                                        .contains(product.id)
                                    ? ColorName.crimsonRed
                                    : ColorName.gray70,
                              )),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:8.r,left: 8.r),
                      child: AppTextStyleOverFlow(
                        text: product.productName!,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10.r),
                            child: Row(
                              children: [
                                AppTextStyle(
                                  text: GetCurrency.concatWithCurrency(price.salePrice!.toString(), GetCurrency.currencySymbol),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  maxLines: 1,
                                ),
                                5.width,
                                price.regularPrice == price.salePrice
                                    ? const SizedBox.shrink()
                                    : AppTextStyle(
                                  text: GetCurrency.concatWithCurrency(price.regularPrice!.toString(), GetCurrency.currencySymbol),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.lineThrough,
                                  color: ColorName.gray410,
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          product.reviewsAvgRating.toString() == '0.0'
                              ? const SizedBox.shrink()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: ColorName.amber,
                                      size: 15,
                                    ),
                                    2.width,
                                    AppTextStyle(
                                        text:
                                            product.reviewsAvgRating.toString(),
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600),
                                  ],
                                ),
                          12.width,
                        ],
                      ),
                    ),
                    5.height,
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
