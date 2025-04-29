import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/modules/home/controllers/home_controller.dart';
import 'package:shop_villa/app/modules/profile/controllers/profile_controller.dart';
import 'package:shop_villa/app/modules/register/controllers/register_controller.dart';
import 'package:shop_villa/app/repository/api_endpoint.dart';
import 'package:shop_villa/app/routes/app_pages.dart';
import 'package:shop_villa/gen/assets.gen.dart';
import 'package:shop_villa/global/app_text_style.dart';
import 'package:shop_villa/global/methods/get_image_url.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import 'package:shop_villa/helper/helper_utils.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/awesome_dialog_login.dart';
import '../../../../global/custom_bottom_navbar.dart';
import '../../../../global/shimmer_loading.dart';
import '../../profile/widgets/logout_bottomsheet.dart';
import '../controllers/mainpage_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class MainPageView extends GetView<MainPageController> {
  const MainPageView({super.key});

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    final mainPageController = Get.put(MainPageController());
    final registerController =
        Get.put(RegisterController()); // Use Get.find to get the instance
    final profileController = Get.put(ProfileController());

    return Scaffold(
      key: controller.scaffoldKey,
      drawer: Drawer(
        backgroundColor: ColorName.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SafeArea(
                top: false,
                child: SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: Stack(children: [
                    Positioned(
                      bottom: 430.h,
                      left: -170.w,
                      child: Container(
                        height: 460.h,
                        width: 460.w,
                        decoration: BoxDecoration(
                            color: ColorName.primaryColor.withOpacity(0.1),
                            shape: BoxShape.circle),
                        child: Stack(children: [
                          Center(
                            child: Container(
                              height: 360.h,
                              width: 360.w,
                              decoration: BoxDecoration(
                                  color:
                                      ColorName.primaryColor.withOpacity(0.1),
                                  shape: BoxShape.circle),
                            ),
                          ),
                          Center(
                            child: Container(
                              height: 250.h,
                              width: 250.w,
                              decoration: BoxDecoration(
                                  color:
                                      ColorName.primaryColor.withOpacity(0.1),
                                  shape: BoxShape.circle),
                              child: Center(
                                child: Obx(() {
                                  String imageUrl;
                                  if (registerController.user.value != null) {
                                    // Check if Google Sign-In user has a photoURL
                                    if (registerController
                                                .user.value!.photoURL !=
                                            null &&
                                        registerController
                                            .user.value!.photoURL!.isNotEmpty) {
                                      imageUrl = registerController
                                          .user.value!.photoURL!;
                                    } else {
                                      // Log to check if the photoURL is null or empty
                                      debugPrint(
                                          'Google user photoURL is null or empty');
                                      imageUrl =
                                          'https://cdn-icons-png.flaticon.com/512/4128/4128244.png'; // Default image
                                    }
                                  } else if (profileController
                                          .profileDetails.value.data?.image !=
                                      null) {
                                    // Use API image if available
                                    imageUrl = GetImageUrl.url(profileController
                                        .profileDetails.value.data!.image!);
                                  } else {
                                    // Default image if no user is signed in or no image is available
                                    imageUrl =
                                        'https://cdn-icons-png.flaticon.com/512/4128/4128244.png';
                                  }
                                  return CachedNetworkImage(
                                    imageUrl: imageUrl,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      width: 90.0.w,
                                      height: 90.0.h,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(0.0, 1.0),
                                            //(x,y)
                                            blurRadius: 6.0,
                                          ),
                                        ],
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        shimmerLoadingWidget(
                                            borderRadius: 50,
                                            height: 90.0.h,
                                            width: 90.0.w),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                    Positioned(
                      top: 175.h,
                      child: SafeArea(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 20.w, bottom: 30.h),
                              child: Obx(() {
                                if (profileController
                                        .profileDetails.value.data !=
                                    null) {
                                  // If the user is signed in via API, update the values in the controller
                                  final profileData = profileController
                                      .profileDetails.value.data!;
                                  controller.userName.value =
                                      profileData.name!.capitalize ??
                                          controller.userName.value;
                                  controller.userEmail.value =
                                      profileData.email ??
                                          controller.userEmail.value;
                                }

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppTextStyle(
                                      text: controller.userName.value,
                                      color: ColorName.primaryColor,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    AppTextStyle(
                                      text: controller.userEmail.value,
                                      maxLines: 2,
                                      color: ColorName.primaryColor
                                          .withOpacity(0.5),
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                );
                              }),
                            ),
                            drawerPotions(
                              onTap: () {
                                Get.back();
                              },
                              text: "Home",
                              svgIcon: Assets.icons.homeIcon,
                            ),
                            drawerPotions(
                              onTap: !HelperUtils.isLogin
                                  ? () {
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
                                    }
                                  : () {
                                      Get.toNamed(Routes.PROFILE);
                                    },
                              text: "Account",
                              svgIcon: Assets.icons.userIcon,
                            ),
                            drawerPotions(
                                onTap: !HelperUtils.isLogin
                                    ? () {
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
                                      }
                                    : () {
                                        Get.toNamed(Routes.MY_ORDER);
                                      },
                                text: "My Order",
                                svgIcon: Assets.icons.orderFillIcon),
                            drawerPotions(
                              onTap: () {
                                Get.toNamed(Routes.CART);
                              },
                              text: "Cart",
                              svgIcon: Assets.icons.cartFillIcon,
                            ),
                            drawerPotions(
                              onTap: () {
                                Get.toNamed(Routes.PROMOS_VOUCHERS);
                              },
                              text: "Promos & Vouchers",
                              svgIcon: Assets.icons.discountFillIcon,
                            ),
                            drawerPotions(
                              onTap: !HelperUtils.isLogin
                                  ? () {
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
                                    }
                                  : () {
                                      Get.toNamed(Routes.WISHLIST);
                                    },
                              text: "Wishlist",
                              svgIcon: Assets.icons.favouriteIcon,
                            ),
                            drawerPotions(
                              onTap: () {
                                _launchURL(ApiEndpoint.domainUrl);
                              },
                              text: "Contact Us",
                              svgIcon: Assets.icons.callIcon,
                            ),
                            drawerPotions(
                              onTap: HelperUtils.isLogin
                                  ? () {
                                      LogOutBottomSheet.show(context, () {
                                        if (registerController.user.value !=
                                            null) // for google signIN
                                        {
                                          Navigator.pop(context);
                                          registerController.auth.signOut();
                                          Get.find<HomeController>().logOut();
                                          Get.offAllNamed(Routes.LOGIN);
                                        } else {
                                          Navigator.pop(context);
                                          Get.find<HomeController>().logOut();
                                        }
                                      }, () {
                                        Get.back();
                                      });
                                    }
                                  : () {
                                      Navigator.pop(context);
                                      Get.toNamed(Routes.REGISTER);
                                    },
                              text: HelperUtils.isLogin ? "LogOut" : "LogIn",
                              textColor: HelperUtils.isLogin
                                  ? Colors.red
                                  : ColorName.green,
                              svgIcon: Assets.icons.logoutIcon,
                              iconColor: HelperUtils.isLogin
                                  ? Colors.red
                                  : ColorName.green,
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Obx(
            () => BottomBarCreative(
          items: navItems,
          backgroundColor: Colors.white,
          color: Colors.grey,
          colorSelected: ColorName.primaryColor,
          indexSelected: controller.selectedTab.value,
          top: 0,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          highlightStyle: const HighlightStyle(
              sizeLarge: true, isHexagon: true, elevation: 6),
          onTap: (index) => controller.changeTab(index),
        ),
      ),
      body: Obx(
        () => controller.pageList[controller.selectedTab.value],
      ),
    );
  }
}

class BottomBarCreativeItem {
  final Widget icon;
  final String label;

  BottomBarCreativeItem({
    required this.icon,
    required this.label,
  });
}

Widget drawerPotions({
  required String text,
  required String svgIcon,
  VoidCallback? onTap,
  double? iconHeight,
  double? iconWidth,
  Color? iconColor,
  Color? textColor,
}) {
  return Padding(
    padding: EdgeInsets.only(left: 20.w, bottom: 20.h),
    child: InkWell(
      borderRadius: BorderRadius.circular(50.r),
      onTap: onTap ?? () {},
      child: SizedBox(
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgIcon,
              height: iconHeight ?? 16.h,
              width: iconWidth ?? 16.w,
              colorFilter:
                  ColorFilter.mode(iconColor ?? Colors.black, BlendMode.srcIn),
            ),
            25.width,
            AppTextStyle(
              text: text,
              color: textColor ?? Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            )
          ],
        ),
      ),
    ),
  );
}
