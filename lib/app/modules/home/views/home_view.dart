import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shop_villa/app/modules/home/widgets/brands.dart';
import 'package:shop_villa/app/modules/home/widgets/caroselslider/dot_indicatior.dart';
import 'package:shop_villa/app/modules/home/widgets/collection_list.dart';
import 'package:shop_villa/app/modules/home/widgets/flash_sales.dart';
import 'package:shop_villa/app/modules/home/widgets/new_arrivals.dart';
import 'package:shop_villa/app/modules/home/widgets/shoppingcatagorilist.dart';
import 'package:shop_villa/app/modules/home/widgets/trending_product.dart';
import 'package:shop_villa/app/routes/app_pages.dart';
import 'package:shop_villa/app/services/local_store_config.dart';
import 'package:shop_villa/appConfig.dart';
import 'package:shop_villa/gen/assets.gen.dart';
import 'package:shop_villa/gen/colors.gen.dart';
import 'package:shop_villa/global/app_text_style.dart';
import 'package:shop_villa/global/shimmer_loading.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import '../../../../global/badges_widget.dart';
import '../../../../global/alert_dialogs/flash_alert_dialogs.dart';
import '../../../../helper/helper_utils.dart';
import '../../categories/controllers/categories_controller.dart';
import '../../mainpage/controllers/mainpage_controller.dart';
import '../../../../global/awesome_dialog_login.dart';
import '../controllers/home_controller.dart';
import '../widgets/caroselslider/banner.dart';
import '../widgets/flat_n_heels.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    if (!controller.isShowAlert.value) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (HiveService.box != null && !HiveService.getAlertShowed()) {
          if (controller.alert.value != null) {
            FlashAlertDialogs.orderOffAlert(
              context: context,
              alert: controller.alert.value!,
            );
          }
        }
      });
      controller.isShowAlert.value = true;
    }

    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        surfaceTintColor: ColorName.bgColor,
        leading: GestureDetector(
            onTap: () {
              final mainController = Get.find<MainPageController>();
              mainController.scaffoldKey.currentState?.openDrawer();
            },
            child: Center(
              child: SvgPicture.asset(
                Assets.icons.menuIcon,
                height: 20.h,
                width: 20.w,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.7),
                  BlendMode.srcIn,
                ),
              ),
            )),
        title: GestureDetector(
          onTap: () {
            // HomePageAlerts.orderOffAlert(context: context, alert: controller.alert.value);
          },
          child: InkWell(
            onTap: () {
              controller.fetchDashboardUserCount();
            },
            child: Image.asset(
              AppConfig.appLogo,
              height: 25,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          Obx(() {
            return badgeWidget(
              count: controller.totalCartedCount.value,
              icon: Icons.shopping_cart_outlined,
              onTap: () async {
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
            );
          }),
          SizedBox(
            width: 7.w,
          ),
          Obx(
            () => badgeWidget(
              count: controller.totalNotificationCount.value,
              onTap: () {
                if (HelperUtils.isLogin) {
                  // Fetch data after the build completes
                  Get.toNamed(Routes.NOTIFICATION);
                } else {
                  // Show dialog after the build completes
                  DialogUtils.showWarningDialog(
                    dismissOnBackKeyPress: false,
                    dismissOnTouchOutside: true,
                    context: Get.context!,
                    title: 'You are UnAuthenticated',
                    description: 'Please Log In',
                    onOkPressed: () {
                      Get.toNamed(Routes.LOGIN);
                    },
                  );
                }
              },
              icon: MdiIcons.bellOutline,
            ),
          ),
          SizedBox(
            width: 7.w,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Container(
              height: 45.h,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 9,
                    offset: Offset(0, 2),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: TextField(
                onTap: () {
                  Get.toNamed(Routes.SEARCHING);
                },
                readOnly: true,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    size: 22,
                  ),
                  hintText: 'Search'.tr,
                  hintStyle: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            15.height,

            ///                    Categories List
            Container(
              padding: EdgeInsets.all(5.r),
              margin: EdgeInsets.only(right: 2.w),
              height: 140.h,
              decoration: BoxDecoration(
                  color: ColorName.white,
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 1,
                        offset: Offset(1, 1))
                  ]),
              child: Obx(() {
                if (controller.isCategoryLoading.value == 0) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          AppTextStyle(
                            text: 'Categories',
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              final CategoriesController categoriesController =
                                  Get.put(CategoriesController());
                              categoriesController.fetchSubCategories(
                                categoryId: categoriesController
                                    .selectedCategoryId.value,
                              );
                              Get.toNamed(Routes.CATEGORIES);
                            },
                            child: Row(
                              children: [
                                AppTextStyle(
                                  text: 'View All',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                const Icon(
                                  Icons.arrow_forward,
                                  size: 22,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      3.height,
                      const Expanded(child: ShoppingCategoryList()),
                    ],
                  );
                } else if (controller.isCategoryLoading.value == 1) {
                  return shimmerLoadingWidget(
                      height: 55.h, width: Get.width, borderRadius: 15.r);
                } else {
                  return 0.height;
                }
              }),
            ),
            10.height,
            Obx(() {
              return Column(
                children: [
                  controller.isBannerLoading.value == 0
                      ? const Banners()
                      : controller.isBannerLoading.value == 1
                          ? Padding(
                              padding: EdgeInsets.all(10.r),
                              child: shimmerLoadingWidget(
                                  height: 0.18.sh,
                                  width: Get.width,
                                  borderRadius: 15.r),
                            )
                          : 0.height,
                  controller.isBannerLoading.value == 0
                      ? const DotIndicator()
                      : controller.isBannerLoading.value == 1
                          ? shimmerLoadingWidget(height: 5.h, width: 100.w)
                          : 0.height,
                  controller.isFlashSalesLoading.value == 0
                      ? const FlashSalesHome()
                      : controller.isFlashSalesLoading.value == 1
                          ? shimmerLoadingListHorizontalWidget()
                          : 0.height,
                  15.height,
                  // controller.isSpecialOffersLoading.value == 0
                  //     ? const SpecialOfferHome()
                  //     : controller.isSpecialOffersLoading.value == 1
                  //         ? Padding(
                  //             padding: EdgeInsets.all(10.r),
                  //             child: shimmerLoadingWidget(
                  //                 height: 100.h,
                  //                 width: Get.width,
                  //                 borderRadius: 15.r),
                  //           )
                  //         : 0.height,
                  15.height,
                  controller.isNewArrivalsLoading.value == 0
                      ? const NewArrivalsHome()
                      : controller.isNewArrivalsLoading.value == 1
                          ? shimmerLoadingListHorizontalWidget()
                          : 0.height,
                  5.height,
                  controller.isCategoryLoading.value == 0
                      ? const FlatHeels()
                      : controller.isCategoryLoading.value == 1
                          ? shimmerLoadingWidget(
                              height: 130.h,
                              width: Get.width,
                              borderRadius: 20.r)
                          : 0.height,
                  5.height,
                  controller.isTrendingProductsLoading.value == 0
                      ? const TrendingProductHome()
                      : controller.isTrendingProductsLoading.value == 1
                          ? shimmerLoadingListHorizontalWidget()
                          : 0.height,
                  5.height,
                  controller.isBrandsLoading.value == false
                      ? const Brands()
                      : shimmerLoadingListHorizontalWidget(),
                  5.height,
                  controller.isCollectionLoading.value == false
                      ? const Collections()
                      : shimmerLoadingListHorizontalWidget(),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
