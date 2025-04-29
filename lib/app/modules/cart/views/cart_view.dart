import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_villa/global/global_snackbar.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import 'package:shop_villa/helper/appbar_title.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/app_text_style_over_flow.dart';
import '../../../../global/cached_network_image_builder.dart';
import '../../../../global/global_button.dart';
import '../../../../global/methods/get_currency.dart';
import '../../../routes/app_pages.dart';
import '../../products/productDetails/controllers/product_details_controller.dart';
import '../../products/productDetails/widget/bottomsheet.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});
  @override
  Widget build(BuildContext context) {
    final productDetailsController = Get.put(ProductDetailsController());
    final controller = Get.put(CartController());

    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        surfaceTintColor: ColorName.bgColor,
        title: appbarTitle(text: 'Cart'),
        centerTitle: true,
        leading: Get.currentRoute == '/mainpage'
            ? const AppTextStyle(
                text: '',
              )
            : InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Icon(Icons.arrow_back),
              ),
      ),
      body: Obx(() {
        if (controller.isCartLoading.value == true) {
          return Center(
            child: LoadingAnimationWidget.stretchedDots(
              size: 40,
              color: ColorName.primaryColor,
            ),
          );
        } else if (controller.cart.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              60.height,
              Center(
                child: SvgPicture.asset(
                  Assets.images.emptycart,
                  height: 250.h,
                  width: 250.w,
                ),
              ),
              20.height,
              Text(
                'No Product Carted!'.tr,
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
          return ListView.builder(
            itemCount: controller.cart.length, //change
            itemBuilder: (context, item) {
              final cart = controller.cart[item];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorName.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        offset: Offset(2, 4),
                        blurRadius: 3,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        cachedImageHelper(
                            imgurl: cart.image!,
                            imgWidth: 110.w,
                            imgHeight: 125.h),
                        10.width,
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextStyleOverFlow(
                                text: cart.productName!,
                                maxLines: 2,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                              ),
                              5.height,
                              cart.productSize != 'No Size'
                                  ? AppTextStyle(
                                      text:
                                          '${'Size'.tr} : ${cart.productSize}',
                                      fontSize: 12.sp,
                                    )
                                  : const SizedBox.shrink(),
                              5.height,
                              AppTextStyle(
                                text: '${'Color'.tr} : ${cart.productColor}',
                                fontSize: 12.sp,
                              ),
                              5.height,
                              AppTextStyle(
                                text: '${'Quantity'.tr} : ${cart.qty}',
                                fontSize: 12.sp,
                              ),
                              5.height,
                              Row(
                                children: [
                                  AppTextStyle(
                                    text: '${'Price'.tr} :',
                                    fontSize: 12.sp,
                                  ),
                                  5.width,
                                  AppTextStyle(
                                    text: GetCurrency.concatWithCurrency(
                                      cart.total.toString().split('.')[0],
                                      GetCurrency.currencySymbol,
                                    ),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        10.width,
                        Column(
                          children: [
                            5.height,
                            GestureDetector(
                              onTap: () async {
                                controller.productID = cart.productId;
                                controller.isLoading.value = true;
                                productDetailsController
                                    .getProductDetails(cart.productId!);
                                while (controller.isLoading.value) {
                                  LoadingAnimationWidget.progressiveDots(
                                      color: ColorName.primaryColor, size: 30);
                                  await Future.delayed(
                                    const Duration(milliseconds: 500),
                                  );
                                }
                                if (controller.product.value.data != null) {
                                  buyBottomSheet(
                                    qty: cart.qty,
                                    context: Get.context!,
                                    product: controller.product.value.data!,
                                    isCart: true,
                                  );
                                }
                              },
                              child: SvgPicture.asset(
                                Assets.images.edit,
                                colorFilter: const ColorFilter.mode(
                                  ColorName.primaryColor,
                                  BlendMode.srcIn,
                                ),
                                height: 20.h,
                                width: 20.w,
                              ),
                            ),
                            20.height,
                            GestureDetector(
                              onTap: () {
                                controller.removeCart(
                                  id: cart.productId!.toInt(),
                                );
                              },
                              child: const Icon(
                                Icons.delete_outline_rounded,
                                color: ColorName.gray410,
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
      bottomNavigationBar: Obx(
        () => controller.cart.isEmpty
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: globalButton(
                  text:
                  '${'Checkout'.tr} (${controller.cart.length}) - ${GetCurrency.concatWithCurrency(
                      controller.cartList.value.data!.total!.split('.')[0],
                      GetCurrency.currencySymbol)}',
                  onTap: () {
                    if (controller.cart.isNotEmpty) {
                      Get.toNamed(Routes.CHECKOUT);
                    } else {
                      globalSnackBar(
                          title: 'Checkout',
                          message: 'Sorry, Cart Some Product');
                    }
                  },
                ),
              ),
      ),
    );
  }
}
