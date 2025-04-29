import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_scroll_to_top/flutter_scroll_to_top.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_villa/app/models/wishlist_model/wish_list_model.dart';
import 'package:shop_villa/app/modules/home/controllers/home_controller.dart';
import 'package:shop_villa/gen/assets.gen.dart';
import 'package:shop_villa/global/methods/get_currency.dart';
import 'package:shop_villa/global/methods/get_image_url.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import 'package:shop_villa/helper/appbar_title.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/app_text_style_over_flow.dart';
import '../../../../global/awesome_dialog_login.dart';
import '../../../../global/shimmer_loading.dart';
import '../../../../helper/helper_utils.dart';
import '../../../routes/app_pages.dart';
import '../../products/productDetails/controllers/product_details_controller.dart';
import '../controllers/wishlist_controller.dart';

class WishlistView extends GetView<WishlistController> {
  const WishlistView({super.key});
  @override
  Widget build(BuildContext context) {
    WishlistController controller = Get.put(WishlistController());
    final HomeController homeController = Get.put(HomeController());
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        title: appbarTitle(text: 'Wishlist'),
        leading: IconButton(
            onPressed: () {
              Get.delete<WishlistController>();
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_sharp)),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value == true) {
          return Center(
            child: LoadingAnimationWidget.stretchedDots(
              size: 40,
              color: ColorName.primaryColor,
            ),
          );
        } else if (homeController.wishlist.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SvgPicture.asset(
                    Assets.images.wishlistSvg,
                    height: 180.h,
                    width: Get.width,
                  ),
                ),
              ),
              20.height,
              Text(
                'No Wished Items!'.tr,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: ColorName.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          );
        } else {
          return AnimationLimiter(
            child: ScrollWrapper(
                promptAlignment: Alignment.bottomRight,
                enabledAtOffset: 100,
                alwaysVisibleAtOffset: true,
                promptTheme: const PromptButtonTheme(color: ColorName.gray410),
                builder: (context, properties) => Obx(() =>
                    MasonryGridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 0.0,
                      crossAxisSpacing: 0.0,
                      itemCount: homeController.wishlist.length,
                      itemBuilder: (BuildContext context, int index) {
                        final WishListData wishListedProduct =
                            homeController.wishlist[index];
                        final isWishListed = homeController.wishListedProductId
                            .contains(wishListedProduct.productId);
                        return InkWell(
                          onTap: () {
                            Get.toNamed(
                              Routes.PRODUCT_DETAILS,
                              arguments: {
                                'productID': wishListedProduct.productId,
                              },
                              preventDuplicates: false,
                            );
                            Get.put(ProductDetailsController())
                                .getProductDetails(
                                    wishListedProduct.productId!);
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
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                  topRight:
                                                      Radius.circular(20.r),
                                                  topLeft:
                                                      Radius.circular(20.r)),
                                              child: CachedNetworkImage(
                                                height: 180.h,
                                                width: Get.width /
                                                    1.8.w, // change for staggered widget
                                                imageUrl: GetImageUrl.url(
                                                    wishListedProduct.image!),
                                                fit: BoxFit.fill,
                                                placeholder: (context, url) =>
                                                    shimmerLoadingWidget(
                                                  height: 180.h,
                                                  width: Get.width / 1.9.w,
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        SvgPicture.asset(
                                                          Assets.images.errorThumbnail,
                                                          width: Get.width, // Keep consistent sizing
                                                        ),
                                              ),
                                            ),
                                            // ),
                                            Positioned(
                                              top: 10.h,
                                              right: 10.w,
                                              child: InkWell(
                                                  onTap: HelperUtils.isLogin
                                                      ? () {
                                                          if (homeController
                                                              .wishListedProductId
                                                              .contains(
                                                                  wishListedProduct
                                                                      .productId)) {
                                                            homeController
                                                                .removeToWishlist(
                                                                    productId:
                                                                        wishListedProduct
                                                                            .productId!);
                                                          }
                                                        }
                                                      : () {
                                                          DialogUtils
                                                              .showWarningDialog(
                                                            dismissOnBackKeyPress:
                                                                false,
                                                            dismissOnTouchOutside:
                                                                true,
                                                            context:
                                                                Get.context!,
                                                            title:
                                                                'Want to Wishlist this Item',
                                                            description:
                                                                'Please Log In',
                                                            onOkPressed: () {
                                                              Get.toNamed(
                                                                  Routes.LOGIN);
                                                            },
                                                          );
                                                        },
                                                  child: Icon(
                                                    homeController
                                                            .wishListedProductId
                                                            .contains(
                                                                wishListedProduct
                                                                    .productId)
                                                        ? Icons.favorite
                                                        : Icons.favorite,
                                                    color: homeController
                                                            .wishListedProductId
                                                            .contains(
                                                                wishListedProduct
                                                                    .productId)
                                                        ? ColorName.crimsonRed
                                                        : ColorName.gray70,
                                                  )),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 8.r, left: 8.r),
                                          child: AppTextStyleOverFlow(
                                            text:
                                                wishListedProduct.productName!,
                                            maxLines: 1,
                                            textAlign: TextAlign.start,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10.r),
                                                child: Row(
                                                  children: [
                                                    AppTextStyle(
                                                      text: GetCurrency.concatWithCurrency(wishListedProduct.salePrice!.toString(), GetCurrency.currencySymbol),
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w600,
                                                      maxLines: 1,
                                                    ),
                                                    5.width,
                                                    wishListedProduct.regularPrice == wishListedProduct.salePrice
                                                        ? const SizedBox.shrink()
                                                        : AppTextStyle(
                                                      text: GetCurrency.concatWithCurrency(wishListedProduct.regularPrice!.toString(), GetCurrency.currencySymbol),
                                                      fontSize: 12.sp,
                                                      fontWeight: FontWeight.w600,
                                                      decoration: TextDecoration.lineThrough,
                                                      color: ColorName.gray410,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Spacer(),
                                              wishListedProduct.rating
                                                          .toString() ==
                                                      '0.0'
                                                  ? const SizedBox.shrink()
                                                  : Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Icon(
                                                          Icons.star,
                                                          color:
                                                              ColorName.amber,
                                                          size: 15,
                                                        ),
                                                        2.width,
                                                        AppTextStyle(
                                                            text:
                                                                wishListedProduct
                                                                    .rating!
                                                                    .toString(),
                                                            fontSize: 13.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
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
                      },
                    ))),
          );
        }
      }),
    );
  }
}
