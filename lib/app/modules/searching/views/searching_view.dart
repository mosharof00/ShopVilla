import 'package:chip_list/chip_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop_villa/gen/assets.gen.dart';
import 'package:shop_villa/gen/colors.gen.dart';
import 'package:shop_villa/global/app_input_textformfield.dart';
import 'package:shop_villa/global/app_text_style.dart';
import 'package:shop_villa/global/global_snackbar.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import '../controllers/searching_controller.dart';

class SearchingView extends GetView<SearchingController> {
  const SearchingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(Get.context!).requestFocus(controller.focusNode);
    });
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        // leading: InkWell(
        //     onTap: () {
        //       productsController.isFromSearch.value = false;
        //       productsController.isEndPage.value = false;
        //       productsController.searchedText.value = "";
        //       productsController.fetchProducts();
        //       Get.toNamed(Routes.PRODUCTS);
        //     },
        //     child: const Icon(Icons.arrow_back)),
        titleSpacing: 0,
        title: Container(
          height: 35.h,
          decoration: BoxDecoration(
              color: ColorName.white,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 1,
                    offset: Offset(1, 1.5))
              ]),
          child: AppInputTextFormField(
              controller: controller.textEditingController,
              focusNode: controller.focusNode,
              onFieldSubmitted: (value) {
                if (controller.textEditingController.text.isNotEmpty) {
                  controller.fetchProduct();
                }
                if (controller.textEditingController.text.isEmpty) {
                  globalSnackBar(
                      title: "Alert", message: "Please ender any keyword");
                }
              },
              // keyboardType: TextInputType.,
              fillColor: ColorName.white,
              borderRadius: 10.r,
              contentPadding: EdgeInsets.only(bottom: 0, left: 8.w),
              hintText: 'Search anything',
              focusedBorderColor: ColorName.primaryColor,
              suffixIcon: InkWell(
                  onTap: () {
                    controller.textEditingController.clear();
                  },
                  child: SvgPicture.asset(
                    Assets.icons.crossIcon,
                    height: 15.h,
                    width: 15.w,
                    colorFilter:
                        const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                  ))),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {
              if (controller.textEditingController.text.isNotEmpty) {
                controller.fetchProduct();
              }
              if (controller.textEditingController.text.isEmpty) {
                globalSnackBar(
                    title: "Alert", message: "Please ender any keyword");
                return;
              } else {
                controller.addToSearchHistoryList(
                    controller.textEditingController.text.toString());
              }
            },
            child: AppTextStyle(
              text: 'Search',
              color: ColorName.primaryColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextStyle(
                text: "Search History",
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
              Obx(
                () => ChipList(
                  listOfChipNames: controller.searchHistoryList
                      .map((f) => f.toString())
                      .toList(),
                  activeBgColorList: const [ColorName.white],
                  inactiveBgColorList: const [ColorName.white],
                  activeTextColorList: const [ColorName.gray410],
                  inactiveTextColorList: const [ColorName.gray410],
                  activeBorderColorList: const [ColorName.gray410],
                  inactiveBorderColorList: const [ColorName.gray410],
                  listOfChipIndicesCurrentlySelected: [
                    controller.currentIndex.value
                  ],
                  checkmarkColor: Colors.transparent,
                  shouldWrap: true,
                  supportsMultiSelect: true,
                  extraOnToggle: (val) {
                    controller.textEditingController.text =
                        controller.searchHistoryList[val];
                    controller.fetchProduct();

                  },
                ),
              ),
              30.height,
            ],
          ),
        ),
      ),
    );
  }
}

// Widget viewAll({
//   required VoidCallback? onTap,
//   double? height,
//   double? width,
//   Color? borderColor,
//   Color? textColor,
//   Color? iconColor,
// }) {
//   return InkWell(
//     onTap: onTap,
//     child: Container(
//       width: width ?? 100.w,
//       height: height ?? 35.h,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(30),
//         border: Border.all(color: borderColor ?? ColorName.white),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: AppTextStyle(
//               text: 'View All',
//               fontSize: 13.sp,
//               color: textColor ?? ColorName.white,
//             ),
//           ),
//           SizedBox(
//             width: 5.w,
//           ),
//           Icon(
//             Icons.arrow_forward,
//             color: iconColor ?? ColorName.white,
//             size: 22,
//           ),
//         ],
//       ),
//     ),
//   );
// }
