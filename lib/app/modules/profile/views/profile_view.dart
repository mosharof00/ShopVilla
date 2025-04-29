import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/modules/home/controllers/home_controller.dart';
import 'package:shop_villa/app/modules/profile/editProfile/controllers/edit_profile_controller.dart';
import 'package:shop_villa/app/modules/register/controllers/register_controller.dart';
import 'package:shop_villa/app/routes/app_pages.dart';
import 'package:shop_villa/gen/assets.gen.dart';
import 'package:shop_villa/gen/colors.gen.dart';
import 'package:shop_villa/global/app_text_style.dart';
import 'package:shop_villa/global/loading_animation_widget.dart';
import 'package:shop_villa/global/methods/get_image_url.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import 'package:shop_villa/helper/log_printer.dart';
import '../../../../global/shimmer_loading.dart';
import '../../../../helper/helper_utils.dart';
import '../controllers/profile_controller.dart';
import '../widgets/logout_bottomsheet.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerController = Get.put(RegisterController());
    Get.lazyPut(() => ProfileController());
    Log.i("token: ${HelperUtils.token}");
    controller.onInit();
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      body: Obx(() {
        if(controller.adminInfo.isEmpty && controller.profileDetails.value.data == null){
          return Center(child: loadingAnimationWidget());
        } else {
          final profile = controller.profileDetails.value.data;
          return Column(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    30.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        15.width,
                        Get.currentRoute != '/profile'
                            ? const AppTextStyle(
                          text: '',
                        )
                            : InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.arrow_back,
                          ),
                        ),
                      ],
                    ),
                    SafeArea(
                      child: FadeIn(
                        delay: const Duration(milliseconds: 400),
                        duration: const Duration(milliseconds: 700),
                        animate: true,
                        child: Container(
                          height: 170.h,
                          width: 170.w,
                          decoration: BoxDecoration(
                            color: ColorName.primaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                            border: Border(
                              left: BorderSide(
                                color: ColorName.primaryColor.withOpacity(0.2),
                                width: 2.w,
                              ),
                              right: BorderSide(
                                color: ColorName.primaryColor.withOpacity(0.2),
                                width: 2.w,
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: ColorName.gradientStart.withOpacity(0.1),
                                blurRadius: 2,
                                spreadRadius: 10,
                              )
                            ],
                          ),
                          child: controller.profileDetails.value.data == null
                              ? shimmerLoadingCircularWidget()
                              : Center(
                            child: Container(
                              height: 140.h,
                              width: 140.w,
                              decoration: BoxDecoration(
                                color:
                                ColorName.primaryColor.withOpacity(0.2),
                                shape: BoxShape.circle,
                                border: Border(
                                  left: BorderSide(
                                    color: ColorName.primaryColor
                                        .withOpacity(0.2),
                                    width: 2.w,
                                  ),
                                  right: BorderSide(
                                    color: ColorName.primaryColor
                                        .withOpacity(0.2),
                                    width: 2.w,
                                  ),
                                ),
                              ),
                              child: Obx(() {
                                controller.profileDetails.value;
                                return Center(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                    GetImageUrl.url(profile!.image!),
                                    imageBuilder:
                                        (context, imageProvider) =>
                                        Container(
                                          width: 110.0.w,
                                          height: 110.0.h,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.grey,
                                                offset:
                                                Offset(0.0, 1.0), //(x,y)
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
                                            height: 110.0.h,
                                            width: 110.0.w),
                                    errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                    ),
                    20.height,
                    Obx(() {
                      controller.profileDetails.value;
                      return AppTextStyle(
                        text: controller.profileDetails.value.data == null
                            ? 'Username'
                            : profile!.name!,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      );
                    }),
                    Obx(() {
                      controller.profileDetails.value;
                      return AppTextStyle(
                        text: controller.profileDetails.value.data == null
                            ? 'User@mail.com'
                            : profile!.email!,
                        color: Colors.grey,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      );
                    }),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: Get.width,
                  padding: EdgeInsets.only(top: 30.h, left: 20.w, right: 20.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.r),
                        topLeft: Radius.circular(40.r)),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 0)
                        // spreadRadius: 2,
                      )
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        profileOptions(
                            onTap: () {
                              Get.put(EditProfileController())
                                  .setProfileForEditing(profile!);
                              Get.toNamed(Routes.EDIT_PROFILE)?.then((_) {
                                controller.getProfileDetails();
                              });
                            },
                            text: "Edit Profile",
                            svgIcon: Assets.icons.userOutlineIcon),
                        profileOptions(
                          onTap: () {
                            Get.toNamed(
                              Routes.CHATS,
                              arguments: {
                                'uniqueId': controller.adminInfo[0].uniqueId,
                              },
                            );
                          },
                          text: "Chat Support",
                          svgIcon: Assets.images.support,
                        ),
                        profileOptions(
                            onTap: () {
                              Get.toNamed(Routes.WISHLIST);
                            },
                            text: "Wishlist",
                            svgIcon: Assets.icons.loveOutlineIcon),
                        profileOptions(
                            onTap: () {
                              Get.toNamed(Routes.PAYMENT_METHODS);
                            },
                            text: "Payment Methods",
                            svgIcon: Assets.icons.paymentMethodsIcon),
                        profileOptions(
                            onTap: () {
                              Get.toNamed(Routes.PROMOS_VOUCHERS);
                            },
                            text: "Promos & Vouchers",
                            svgIcon: Assets.icons.vouchersIcon),
                        // profileOptions(
                        //     onTap: () {
                        //       Get.toNamed(Routes.ACCOUNT_AND_SECURITY);
                        //     },
                        //     text: "Account & Security",
                        //     icon: Assets.icons.securityIcon),
                        profileOptions(
                            onTap: () {
                              Get.toNamed(Routes.MY_ORDER);
                            },
                            text: "Order History",
                            svgIcon: Assets.icons.historyIcon),
                        profileOptions(
                            onTap: () {
                              Get.toNamed(Routes.SETTINGS);
                            },
                            text: "Settings",
                            svgIcon: Assets.icons.settingIcon),
                        // profileOptions(
                        //     onTap: () {
                        //       Get.toNamed(Routes.NOTIFICATIONS);
                        //     },
                        //     text: "Notifications",
                        //     icon: Assets.icons.notificationsIcon),
                        profileOptions(
                            onTap: () {
                              Get.toNamed(Routes.HELP_AND_SUPPORT);
                            },
                            text: "Help & Supports",
                            svgIcon: Assets.icons.helpConterIcon),
                        profileOptions(
                          onTap: HelperUtils.isLogin
                              ? () {
                            LogOutBottomSheet.show(context, () {
                              if (registerController.user.value !=
                                  null) // for google signIN
                                  {
                                Navigator.pop(context);
                                registerController.auth.signOut();
                              } else {
                                Navigator.pop(context);
                                Get.find<HomeController>().logOut();
                              }
                              Get.offAllNamed(Routes.LOGIN);
                            }, () {
                              Get.back();
                            });
                          }
                              : () {
                            Navigator.pop(context);
                            Get.toNamed(Routes.REGISTER);
                          },
                          text: HelperUtils.isLogin ? "LogOut" : "LogIn",
                          textColor:
                          HelperUtils.isLogin ? Colors.red : ColorName.green,
                          svgIcon: Assets.icons.logoutIcon,
                          iconColor:
                          HelperUtils.isLogin ? Colors.red : ColorName.green,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}

Widget profileOptions({
  required VoidCallback onTap,
  required String text,
  required String svgIcon,
  Color? textColor,
  Color? iconColor,
  double? iconHeight,
  double? iconWidth,
}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 25.h),
    child: InkWell(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(
            svgIcon,
            height: 17.h,
            width: 17.w,
            colorFilter:
                ColorFilter.mode(iconColor ?? Colors.black, BlendMode.srcIn),
          ),
          20.width,
          AppTextStyle(
            text: text,
            color: textColor ?? Colors.black,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios_sharp,
            size: 17.sp,
          )
        ],
      ),
    ),
  );
}
