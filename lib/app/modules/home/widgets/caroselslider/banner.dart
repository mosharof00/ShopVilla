import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_villa/app/models/slider/slider_model.dart';
import 'package:shop_villa/app/modules/home/controllers/home_controller.dart';
import 'package:shop_villa/gen/colors.gen.dart';
import 'package:shop_villa/global/methods/get_currency.dart';
import 'package:shop_villa/global/methods/get_image_url.dart';
import 'package:shop_villa/global/methods/url_launcher.dart';
import '../../../../../global/app_text_style.dart';
import '../../../../../global/shimmer_loading.dart';

class Banners extends StatelessWidget {
  const Banners({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return CarouselSlider.builder(
        carouselController: controller.carouselController1,
        itemCount: controller.sliderList.length,
        options: CarouselOptions(
            // aspectRatio: 2,
            height: 0.18.sh,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.5,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              controller.currentDotedIndex.value = index;
            }),
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          return Obx(() {
            if (controller.sliderList.isNotEmpty) {
              final Sliders slider = controller.sliderList[itemIndex];
              return InkWell(
                onTap: () {
                  UrlLauncher.url(slider.buttonLink!);
                },
                child: CachedNetworkImage(
                  imageUrl: GetImageUrl.url(slider.image!),
                  imageBuilder: (BuildContext context, imageProvider) {
                    return Stack(
                      children: [
                        Container(
                          height: 0.3.sh,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withAlpha(20),
                                  Colors.black.withAlpha(20),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 5.h,
                          left: 6.w,
                          child: SizedBox(
                            width: 0.6.sw,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppTextCustomFont(
                                  text: slider.heading!,
                                  style: GoogleFonts.adventPro(
                                    //adventPro
                                    textStyle: TextStyle(
                                      color: ColorName.white,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w400,
                                      height: 2,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 4.0,
                                          color: Colors.black.withAlpha(150),
                                          offset: const Offset(2.0, 2.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                AppTextCustomFont(
                                  text: slider.desc!,
                                  fontWeight: FontWeight.w700,
                                  style: GoogleFonts.actor(
                                    //aBeeZee
                                    textStyle: TextStyle(
                                      color: ColorName.white,
                                      fontSize: 10.sp,
                                      height: 1.5,
                                      fontWeight: FontWeight.w400,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 4.0,
                                          color: Colors.black.withAlpha(150),
                                          offset: const Offset(2.0, 2.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: AppTextCustomFont(
                                    text: slider.startingAmount == null
                                        ? "Tap for More"
                                        : 'Starting ${GetCurrency.concatWithCurrency(
                                      slider.startingAmount!.split('.')[0],
                                      GetCurrency.currencySymbol,
                                    )}',
                                    fontWeight: FontWeight.w700,
                                    style: GoogleFonts.alexandria(
                                      textStyle: TextStyle(
                                        color: ColorName.white,
                                        fontSize: 10.sp,
                                        height: 5,
                                        fontWeight: FontWeight.w400,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 4.0,
                                            color:
                                                Colors.black.withAlpha(150),
                                            offset: const Offset(2.0, 2.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              );
            } else {
              return shimmerLoadingWidget(height: 0.18.sh, width: Get.width);
            }
          });
        });
  }
}
