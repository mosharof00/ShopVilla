import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shop_villa/app/services/local_store_config.dart';
import '../../../../appConfig.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../routes/app_pages.dart';
import '../controllers/onboard_page_controller.dart';

class OnboardPageView extends GetView<OnboardPageController> {
  const OnboardPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: IntroductionScreen(
          globalBackgroundColor: ColorName.white,
          scrollPhysics: const BouncingScrollPhysics(),
          pages: [
            PageViewModel(
              titleWidget: SizedBox(
                width: 250.w,
                child: Image.asset(
                  AppConfig.appLogo,
                  fit: BoxFit.contain,
                  height: 80.h,
                  // width: 50.w,
                ),
              ),
              bodyWidget: Text(
                'Tired of the same? Upgrade your game! Download shop_villa and join the fashion fame.'.tr,
                textAlign: TextAlign.center,
                style: GoogleFonts.amaranth(
                  textStyle: TextStyle(
                    color: ColorName.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              image: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Image.asset(
                    Assets.images.fashion.path,
                    height: Get.height,
                    width: Get.width,
                  ),
                ),
              ),
            ),
            PageViewModel(
              titleWidget: AppTextStyle(
                text: 'Wished Items',
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
              ),
              bodyWidget: Text(
                'Spotted something you love? Wishlist it and let it know you\'re interested'.tr,
                textAlign: TextAlign.center,
                style: GoogleFonts.amaranth(
                  textStyle: TextStyle(
                    color: ColorName.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              image: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Image.asset(
                    Assets.images.wishlistGif.path,
                    height: Get.height,
                    width: Get.width,
                  ),
                ),
              ),
            ),
            PageViewModel(
              titleWidget: AppTextStyle(
                text: 'Flash Sales',
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
              ),
              bodyWidget: Text(
                'Lightning Deals! Don\'t blink or these hot styles will vanish faster than your chance to say "shop_villa!" ⚡️'.tr,
                textAlign: TextAlign.center,
                style: GoogleFonts.amaranth(
                  textStyle: TextStyle(
                    color: ColorName.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              image: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Image.asset(
                    Assets.images.flashsale.path,
                    height: Get.height,
                    width: Get.width,
                  ),
                ),
              ),
            ),
            PageViewModel(
              titleWidget: AppTextStyle(
                text: 'Add to Cart',
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
              ),
              bodyWidget: Text(
                'Found something oh-so-fine? Click "Add to Cart" and make it shine! ✨'.tr,
                textAlign: TextAlign.center,
                style: GoogleFonts.amaranth(
                  textStyle: TextStyle(
                    color: ColorName.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              image: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Image.asset(
                    Assets.images.addtocart.path,
                    height: Get.height,
                    width: Get.width,
                  ),
                ),
              ),
            ),
            PageViewModel(
              titleWidget: AppTextStyle(
                text: 'Exciting Deals',
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
              ),
              bodyWidget: Text(
                'Lightning speed, amazing savings! Shop shop_villa\'s hot deals and checkout in a snap. Time to treat yourself!'.tr,
                textAlign: TextAlign.center,
                style: GoogleFonts.amaranth(
                  textStyle: TextStyle(
                    color: ColorName.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              image: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Image.asset(
                    Assets.images.deals.path,
                    height: Get.height,
                    width: Get.width,
                  ),
                ),
              ),
            ),
            PageViewModel(
              titleWidget: AppTextStyle(
                text: 'Leave a Review',
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
              ),
              bodyWidget: Text(
                'Did this item live up to the hype? Share your thoughts and unlock exclusive shop_villa rewards!'.tr,
                textAlign: TextAlign.center,
                style: GoogleFonts.amaranth(
                  textStyle: TextStyle(
                    color: ColorName.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              image: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Image.asset(
                    Assets.images.reviewGif.path,
                    height: Get.height,
                    width: Get.width,
                  ),
                ),
              ),
            ),
          ],
          onDone: () {
            HiveService.setOnBoardShowed(true);
            Get.offNamed(Routes.MAINPAGE);
          },
          onSkip: () {
            HiveService.setOnBoardShowed(true);
            Get.offNamed(Routes.MAINPAGE);
          },
          showSkipButton: true,
          skip: AppTextStyle(
            text: 'Skip',
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            color: ColorName.onPrimary,
          ),
          next: const Icon(
            Icons.arrow_forward,
            color: ColorName.onPrimary,
          ),
          done: AppTextStyle(
            text: 'Done',
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            color: ColorName.onPrimary,
          ),
          dotsDecorator: DotsDecorator(
            size: const Size.square(5),
            activeSize: const Size(20, 10),
            color: ColorName.gray410,
            activeColor: ColorName.onPrimary,
            spacing: const EdgeInsets.symmetric(horizontal: 3),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
      ),
    );
  }
}
