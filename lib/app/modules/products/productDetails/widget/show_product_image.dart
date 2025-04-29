import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../global/methods/get_image_url.dart';
import '../../../../../global/shimmer_loading.dart';
import '../../../../models/product_details/product_details_model.dart';
import '../controllers/product_details_controller.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({super.key, required this.productIndex});

  final ProductDetailsData productIndex;

  @override
  Widget build(BuildContext context) {
    final height = 35.h;
    final width = 35.w;
    final controller = Get.put(ProductDetailsController());

    return SizedBox(
      height: 320.h,
      child: Stack(
        children: [
          Obx(
            () => Stack(
              children: [
                CarouselSlider.builder(
                    carouselController: controller.carouselController,
                    itemCount: productIndex
                            .productvariations![controller.selectedImage.value]
                            .mullipleImages!
                            .isEmpty
                        ? 1
                        : productIndex
                            .productvariations![controller.selectedImage.value]
                            .mullipleImages!
                            .length,
                    options: CarouselOptions(
                        // aspectRatio: 2,
                        height: 3.sw,
                        viewportFraction: 0.93.r,
                        initialPage: 0,
                        enableInfiniteScroll: false,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.5.r,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index, reason) {
                          controller.currentDotedIndex.value = index;
                        }),
                    itemBuilder: (BuildContext context, int itemIndex,
                        int pageViewIndex) {
                      return Obx(() {
                        if (productIndex
                            .productvariations![controller.selectedImage.value]
                            .mullipleImages!
                            .isNotEmpty) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(15.r),
                            child: CachedNetworkImage(
                              imageUrl: GetImageUrl.url(productIndex
                                  .productvariations![
                                      controller.selectedImage.value]
                                  .mullipleImages![itemIndex]
                                  .imagePath!),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: Get.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit
                                        .fill, // Changed to cover for better scaling
                                  ),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  shimmerLoadingWidget(
                                      height: 300.h, width: Get.width),
                              errorWidget: (context, url, error) => SvgPicture.asset(
                                Assets.images.errorThumbnail,
                                width: Get.width, // Keep consistent sizing
                              ),
                            ),
                          );
                        } else {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(15.r),
                            child: CachedNetworkImage(
                              imageUrl: GetImageUrl.url(productIndex
                                  .productvariations![
                                      controller.selectedImage.value]
                                  .image!),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: Get.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit
                                        .fill, // Changed to cover for better scaling
                                  ),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  shimmerLoadingWidget(
                                      height: 300.h, width: Get.width),
                              errorWidget: (context, url, error) => SvgPicture.asset(
                                Assets.images.errorThumbnail,
                                width: Get.width, // Keep consistent sizing
                              )
                            ),
                          );
                        }
                      });
                    }),
                Positioned(
                  bottom: 10,
                  left: 100,
                  right: 100,
                  child: DotsIndicator(
                    dotsCount: productIndex
                            .productvariations![controller.selectedImage.value]
                            .mullipleImages!
                            .isEmpty
                        ? 1
                        : productIndex
                            .productvariations![controller.selectedImage.value]
                            .mullipleImages!
                            .length,
                    position: controller.currentDotedIndex.value.toDouble(),
                    decorator: DotsDecorator(
                        activeColor: ColorName.primaryColor,
                        activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        activeSize: const Size.square(12)),
                    onTap: (index) {
                      controller.currentDotedIndex.value = index;
                      controller.carouselController
                          .animateToPage(controller.currentDotedIndex.value);
                    },
                  ),
                ),
              ],
            ),
          ),
          ...List.generate(
            productIndex.productvariations!.length,
            (index) {
              final totalHeight = productIndex.productvariations!.length * 50.h;
              final startTop = (320.h / 2) - (totalHeight / 2);
              return Positioned(
                top: startTop + (index * 50.h),
                left: 5,
                child: GestureDetector(
                  onTap: () {
                    controller.selectedImage.value = index;
                    controller.currentDotedIndex.value = 0;
                  },
                  child: Obx(
                    () => SizedBox(
                      height: height,
                      width: width,
                      child: Material(
                        elevation:
                            controller.selectedImage.value == index ? 5 : 0,
                        borderRadius: BorderRadius.circular(10.r),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: controller.selectedImage.value == index
                                  ? Colors.amber
                                  : ColorName.gray70,
                            ),
                            boxShadow: controller.selectedImage.value == index
                                ? [
                                    const BoxShadow(
                                      color: Colors.black,
                                      offset: Offset(1, 1),
                                      blurRadius: 3,
                                    ),
                                  ]
                                : [],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: CachedNetworkImage(
                              imageUrl: GetImageUrl.url(productIndex
                                  .productvariations![index].image!),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  shimmerLoadingWidget(
                                      height: 35.h, width: 35.w),
                              errorWidget: (context, url, error) => SvgPicture.asset(
                                Assets.images.errorThumbnail,
                                width: Get.width, // Keep consistent sizing
                              )
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
