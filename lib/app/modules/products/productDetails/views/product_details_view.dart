import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_add_to_cart_button/flutter_add_to_cart_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:rating_summary/rating_summary.dart';
import 'package:badges/badges.dart' as badges;
import 'package:share_plus/share_plus.dart';
import 'package:shop_villa/app/modules/home/controllers/home_controller.dart';
import 'package:shop_villa/app/modules/profile/controllers/profile_controller.dart';
import 'package:shop_villa/app/repository/api_endpoint.dart';
import 'package:shop_villa/global/loading_animation_widget.dart';
import 'package:shop_villa/global/shimmer_loading.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import 'package:shop_villa/helper/appbar_title.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../global/app_text_style.dart';
import '../../../../../global/app_text_style_over_flow.dart';
import '../../../../../global/awesome_alert_dialog.dart';
import '../../../../../global/label_with_title_view_all.dart';
import '../../../../../global/methods/get_currency.dart';
import '../../../../../helper/helper_utils.dart';
import '../../../../../helper/product_layout.dart';
import '../../../../../helper/select_color.dart';
import '../../../../../helper/select_variation.dart';
import '../../../../models/coupon/coupon_get_model.dart';
import '../../../../models/product/porduct_model_api.dart';
import '../../../../models/product_details/product_details_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../cart/controllers/cart_controller.dart';
import '../../../my_order/widgets/product_labels.dart';
import '../../../promos_vouchers/controllers/promos_vouchers_controller.dart';
import '../../../promos_vouchers/widget/promos_list.dart';
import '../../../qus_and_ans/widget/quesAns.dart';
import '../../controllers/products_controller.dart';
import '../../widget/product_rating.dart';
import '../controllers/product_details_controller.dart';
import '../../../../../global/awesome_dialog_login.dart';
import '../widget/product_details.dart';
import '../widget/product_qty.dart';
import '../widget/product_reviews.dart';
import '../widget/show_product_image.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  const ProductDetailsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final promosController = Get.put(PromosVouchersController());
    final cartController = Get.put(CartController());
    final HomeController homeController = Get.find();
    final profileController = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        surfaceTintColor: ColorName.bgColor,
        title: appbarTitle(text: 'Product Details'),
        centerTitle: true,
        actions: [
          /// Cart Button
          Obx(
            () => badges.Badge(
              position: badges.BadgePosition.topEnd(top: -5, end: -2),
              showBadge: true,
              ignorePointer: false,
              onTap: () {},
              badgeContent: AppTextStyle(
                text: homeController.totalCartedCount.value.toString(),
                color: ColorName.white,
              ),
              badgeAnimation: const badges.BadgeAnimation.slide(
                animationDuration: Duration(seconds: 1),
                colorChangeAnimationDuration: Duration(seconds: 1),
                loopAnimation: false,
                curve: Curves.fastOutSlowIn,
                colorChangeAnimationCurve: Curves.easeInCubic,
              ),
              badgeStyle: badges.BadgeStyle(
                shape: badges.BadgeShape.circle,
                badgeColor: Colors.blue,
                padding: const EdgeInsets.all(5),
                borderRadius: BorderRadius.circular(4),
                badgeGradient: const badges.BadgeGradient.linear(
                  colors: [ColorName.gradientStart, ColorName.gradientEnd],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                elevation: 0,
              ),
              child: IconButton(
                onPressed: () {
                  if (HelperUtils.isLogin) {
                    Get.toNamed(Routes.CART);
                    return;
                  } else {
                    DialogUtils.showWarningDialog(
                      dismissOnBackKeyPress: false,
                      dismissOnTouchOutside: true,
                      context: Get.context!,
                      title: 'You are Unauthenticated',
                      description: 'Please Log In',
                      onOkPressed: () {
                        Get.toNamed(Routes.LOGIN);
                      },
                    );
                    return;
                  }
                },
                icon: const Icon(
                  Icons.shopping_cart_rounded,
                  size: 30,
                ),
              ),
            ),
          ),
          5.width,
        ],
      ),
      body: Obx(() {
        if (controller.product.value.data == null) {
          // Log.i(controller.product.value.data.toString());
          return Center(
            child: LoadingAnimationWidget.stretchedDots(
                size: 40, color: ColorName.primaryColor),
          );
        } else {
          final ProductDetailsData productDetails =
              controller.product.value.data!;
          return SingleChildScrollView(
            controller: controller.scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero(
                  //   tag: productDetails.id!,
                  //   child:
                  ProductImage(
                    productIndex: productDetails,
                  ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: AppTextStyle(
                      text: productDetails.productName!,
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      color: ColorName.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                    ),
                  ),
                  5.height,
                  Obx(() {
                    int sizeId = productDetails
                        .productvariations![controller.colorSelectedIndex.value]
                        .sizes![controller.sizeSelectedIndex.value]
                        .id!;
                    var size = productDetails.sizes!
                        .firstWhere((size) => size.id == sizeId);
                    return Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: AppTextStyle(
                            text: GetCurrency.concatWithCurrency(
                                size.salePrice.toString(),
                                GetCurrency.currencySymbol),
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                          ),
                        ),
                        size.regularPrice != size.salePrice
                            ? Obx(() {
                                return Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, left: 10.0),
                                      child: AppTextStyle(
                                        text: GetCurrency.concatWithCurrency(
                                            size.regularPrice.toString(),
                                            GetCurrency.currencySymbol),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.sp,
                                        decoration: TextDecoration.lineThrough,
                                        color: ColorName.gray410,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, left: 10.0),
                                      child: ProductLabels(
                                        text:
                                            '${controller.getDiscountPerchantage(size.regularPrice!.toInt(), size.discount!.toInt()).ceil().toString()} % Off',
                                        width: 55,
                                        height: 20,
                                        containerColor: ColorName.yellowOcher,
                                      ),
                                    ),
                                  ],
                                );
                              })
                            : const SizedBox.shrink(),
                        const Spacer(),
                        Obx(
                          () {
                            final isWishListed = homeController
                                .wishListedProductId
                                .contains(productDetails.id);
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: HelperUtils.isLogin
                                      ? () {
                                          if (isWishListed) {
                                            homeController.removeToWishlist(
                                                productId: productDetails.id!);
                                          } else {
                                            homeController.addToWishlist(
                                                productId: productDetails.id!,
                                                productVariationId:
                                                    productDetails
                                                        .productvariations![0]
                                                        .id!,
                                                productSizeId: productDetails
                                                    .sizes![0].id!);
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
                                  child: SvgPicture.asset(
                                    isWishListed
                                        ? Assets.icons.fillFav
                                        : Assets.icons.outlinFav,
                                    colorFilter: ColorFilter.mode(
                                        isWishListed
                                            ? ColorName.crimsonRed
                                            : ColorName.gray410,
                                        BlendMode.srcIn),
                                    height: 25.h,
                                    width: 25.w,
                                  ),
                                ),
                                15.width,
                                InkWell(
                                  onTap: () {
                                    Share.share(' Check out this product\n'
                                        '${productDetails.productName}\n'
                                        'Visit this link to buy this product\n'
                                        '${ApiEndpoint.domainUrl}/product/details/${productDetails.productName!.replaceAll(' ', '-')}');
                                  },
                                  child: SvgPicture.asset(
                                    Assets.icons.share,
                                    height: 25.h,
                                    width: 25.w,
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ],
                    );
                  }),
                  20.height,
                  promosController.promosList.isEmpty
                      ? const SizedBox.shrink()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleWithViewAllWidget(
                              onTap: () {
                                Get.toNamed(Routes.PROMOS_VOUCHERS);
                              },
                              title: 'Promos & Vouchers',
                              textAlign: TextAlign.start,
                              titlefontSize: 17.sp,
                              viewAllFontWeight: FontWeight.w600,
                              viewAllFontSize: 14.sp,
                              btnColor: ColorName.primaryColor,
                              paddingLeft: 0,
                            ),
                            5.height,
                            SizedBox(
                              height: 100.h,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.horizontal,
                                itemCount: promosController.promosList.length,
                                itemBuilder: (context, item) {
                                  final Promos promo =
                                      promosController.promosList[item];
                                  return PromosList(
                                    promo: promo,
                                    item: item,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                  5.height,
                  SelectColors(product: productDetails),
                  10.height,
                  Obx(() {
                    controller.colorSelectedIndex.value;
                    return SelectVariation(
                      product: productDetails,
                    );
                  }),
                  10.height,
                  AppTextStyle(
                    text: 'Product Details',
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  10.height,
                  ProductDetails(productDetails: productDetails),
                  8.height,
                  // ReadMoreText(
                  //   productDetails.productDescription == null
                  //       ? ''
                  //       :
                  //   trimMode: TrimMode.Line,
                  //   trimLines: 2,
                  //   colorClickableText: ColorName.primaryColor,
                  //   trimCollapsedText: 'see more',
                  //   trimExpandedText: 'see less',
                  //   style:
                  //       TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
                  //   moreStyle:
                  //       TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  // ),
                  HtmlWidget(
                    productDetails.productDescription!,
                    renderMode: RenderMode.column,
                    textStyle: TextStyle(fontSize: 12.sp),
                  ),
                  10.height,
                  TitleWithViewAllWidget(
                    onTap: () {
                      Get.to(
                        () => AllRatingView(
                          product: productDetails,
                        ),
                      );
                    },
                    title: 'Rating & Reviews',
                    viewAllFontWeight: FontWeight.w600,
                    titlefontSize: 16.sp,
                    viewAllFontSize: 14.sp,
                    paddingLeft: 0,
                    btnColor: ColorName.primaryColor,
                  ),
                  10.height,
                  Obx(() {
                    if (controller.isLoadingReviews.value) {
                      return loadingAnimationWidget();
                    } else if (controller.reviewList.isEmpty) {
                      return SizedBox(
                        height: 150.h,
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              Assets.images.reviewSvg,
                              width: 110,
                              height: 90,
                            ),
                            3.height,
                            Center(
                                child: AppTextStyle(
                              text: 'No Reviews Found',
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                            )),
                          ],
                        ),
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RatingSummary(
                            counter: controller.reviewList.length,
                            average: controller.reviewAvg.value.isNaN ||
                                    controller.reviewAvg.value.isInfinite
                                ? 0.0
                                : controller.reviewAvg.value,
                            showAverage: true,
                            counterFiveStars: 50,
                            counterFourStars: 40,
                            counterThreeStars: 30,
                            counterTwoStars: 20,
                            counterOneStars: 10,
                            color: ColorName.yellowOcher,
                            averageStyle: TextStyle(
                                fontSize: 35.sp, fontWeight: FontWeight.w800),
                          ),
                          10.height,
                          ProductReviews(
                            product: productDetails,
                          ),
                        ],
                      );
                    }
                  }),
                  TitleWithViewAllWidget(
                    title: 'Q&A',
                    titlefontSize: 16.sp,
                    viewAllFontSize: 14.sp,
                    btnColor: ColorName.primaryColor,
                    paddingLeft: 0,
                    onTap: () {
                      Get.toNamed(Routes.QUS_AND_ANS,
                          arguments: productDetails.id);
                    },
                  ),
                  SizedBox(
                    height: 155.h,
                    child: const QusAns(
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  ),
                  10.height,

                  ///        'You may also like'  ///

                  Obx(() {
                    if (controller.isSimilarProductLoading.value == false &&
                        controller.similarProductList.isNotEmpty) {
                      return Column(
                        children: [
                          TitleWithViewAllWidget(
                            title: 'You may also like',
                            paddingLeft: 0,
                            titlefontSize: 16.sp,
                            viewAllFontSize: 14.sp,
                            btnColor: ColorName.primaryColor,
                            onTap: () {
                              final ProductsController productController =
                                  Get.put(ProductsController());
                              productController.appBarTitle.value = 'For You';
                              productController.categoryID.value =
                                  controller.categoryId.value;
                              productController.subCategoryID.value =
                                  controller.subCategoryId.value;
                              productController.currentPage.value = 1;
                              productController.productList.value =
                                  controller.similarProductList;
                              productController.isLoading.value = 0;
                              productController.isFromSearch.value = false;
                              Get.toNamed(Routes.PRODUCTS);
                            },
                          ),
                          10.height,
                          SizedBox(
                            height: 290.h,
                            width: Get.width,
                            child: AnimationLimiter(
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: controller.similarProductList.length,
                                itemBuilder: (context, item) {
                                  final ProductData products =
                                      controller.similarProductList[item];
                                  return AnimationConfiguration.staggeredList(
                                    position: item,
                                    duration: const Duration(milliseconds: 500),
                                    child: SlideAnimation(
                                      verticalOffset: 50,
                                      child: FadeInAnimation(
                                        child: ProductLayout(
                                          product: products,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    } else if (controller.isSimilarProductLoading.value ==
                        true) {
                      return shimmerLoadingListHorizontalWidget();
                    } else {
                      return 0.height;
                    }
                  })
                ],
              ),
            ),
          );
        }
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Obx(
          () {
            if (controller.product.value.data == null) {
              return const SizedBox.shrink();
            } else {
              final ProductDetailsData productDetails =
                  controller.product.value.data!;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (HelperUtils.isLogin) {
                        Get.toNamed(
                          Routes.CHATS,
                          arguments: {
                            'uniqueId': profileController.adminInfo[0].uniqueId,
                            'productDetails': controller.product.value.data,
                          },
                        );
                      } else {
                        DialogUtils.showWarningDialog(
                          dismissOnBackKeyPress: false,
                          dismissOnTouchOutside: true,
                          context: Get.context!,
                          title: 'You are Unauthenticated',
                          description: 'Please Log In',
                          onOkPressed: () {
                            Get.toNamed(Routes.LOGIN);
                          },
                        );
                        return;
                      }
                    },
                    child: SvgPicture.asset(
                      Assets.images.chatBubble,
                      height: 25.h,
                      width: 25.w,
                    ),
                  ),
                  5.width,
                  ProductQty(
                    stock: productDetails.totalStock!,
                  ),
                  10.width,
                  Obx(() {
                    var con = cartController.stateId.obs;
                    return SizedBox(
                      height: 45.h,
                      width: 180.w,
                      child: AddToCartButton(
                        trolley: const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.shopping_cart_rounded,
                            color: ColorName.white,
                            size: 30,
                          ),
                        ),
                        text: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: AppTextStyleOverFlow(
                            text: 'Add to Cart',
                            fontSize: 14.sp,
                            color: ColorName.white,
                            maxLines: 1,
                          ),
                        ),
                        check: SizedBox(
                          height: 48.h,
                          width: 48.w,
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(24),
                        backgroundColor: ColorName.primaryColor,
                        onPressed: (AddToCartButtonStateId id) {
                          if (HelperUtils.isLogin) {
                            if (id == AddToCartButtonStateId.idle) {
                              con.value = AddToCartButtonStateId.loading;
                              cartController.updateStateId(
                                  AddToCartButtonStateId.loading);
                              Future.delayed(const Duration(seconds: 2), () {
                                con.value = AddToCartButtonStateId.idle;
                                cartController
                                    .updateStateId(AddToCartButtonStateId.idle);
                                cartController.postCart(
                                  productID: productDetails.id!,
                                  varientID: controller.selectedVarientID.value,
                                  qty: controller.productQty.value.toInt(),
                                  sizeID: controller.selectedSizeID.value,
                                );
                                Future.delayed(const Duration(seconds: 2));
                                awesomeAlertDialog(
                                  context,
                                  DialogType.success,
                                  'Awesome! Product Carted',
                                  'Want to Continue Shopping',
                                  'Go to Cart',
                                  () {
                                    Get.toNamed(Routes.CART);
                                  },
                                  'Continue',
                                  () {},
                                  false,
                                );
                              });
                            }
                          } else {
                            // User is not logged in
                            if (id == AddToCartButtonStateId.idle) {
                              con.value = AddToCartButtonStateId.loading;
                              cartController.updateStateId(
                                  AddToCartButtonStateId.loading);
                              Future.delayed(const Duration(seconds: 2), () {
                                con.value = AddToCartButtonStateId.idle;
                                cartController
                                    .updateStateId(AddToCartButtonStateId.idle);
                                DialogUtils.showWarningDialog(
                                  dismissOnBackKeyPress: false,
                                  dismissOnTouchOutside: true,
                                  context: Get.context!,
                                  title: 'Awesome! Want to Cart this Product!',
                                  description: 'Please Log In',
                                  onOkPressed: () {
                                    Get.toNamed(Routes.LOGIN);
                                  },
                                );
                              });
                            }
                          }
                        },
                        stateId: con.value,
                      ),
                    );
                  }),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
