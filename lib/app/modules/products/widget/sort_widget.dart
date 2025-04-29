import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/modules/products/controllers/products_controller.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import 'package:shop_villa/helper/log_printer.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/filter_sort_widget.dart';
import '../../../../global/global_button.dart';
import '../../../../global/global_snackbar.dart';
import '../../../models/product/sort_filter__list_model.dart';
import '../../home/controllers/home_controller.dart';

class SortWidget extends StatelessWidget {
  const SortWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final productsController = Get.put(ProductsController());
    return Obx(() => SortFilter(
          text: 'Sort',
          filterIcon: false,
          textColor: productsController.isSorted.value
              ? ColorName.primaryColor
              : Colors.black,
          iconColor: productsController.isSorted.value
              ? ColorName.primaryColor
              : Colors.black,
          onTap: () {
            showModalBottomSheet(
              backgroundColor: ColorName.white,
              context: context,
              useSafeArea: true,
              builder: (BuildContext context) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: 15.w,
                    right: 15.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      5.height,
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 2.h,
                          width: 35.w,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      10.height,
                      Align(
                          alignment: Alignment.topCenter,
                          child: AppTextStyle(
                            text: 'Sort',
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w700,
                          )),
                      10.height,
                      Container(
                        height: 1.h,
                        width: Get.width,
                        color: Colors.grey.shade300,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: Get.find<HomeController>().sortList.length,
                        itemBuilder: (context, index) {
                          final Sort sort =
                              Get.find<HomeController>().sortList[index];
                          return Obx(() {
                            return RadioListTile(
                              value: index,
                              groupValue:
                                  productsController.selectedSortIndex.value,
                              onChanged: (value) {
                                productsController.selectedSortIndex.value =
                                    value as int;
                                productsController.selectedSortName.value =
                                    sort.value!;
                              },
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppTextStyle(
                                    text: sort.status!,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                              activeColor: ColorName.primaryColor,
                            );
                          });
                        },
                      ),
                      10.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          globalButton(
                            onTap: () {
                              ///   Reset Sort onTap Button
                              productsController.resetSortData();
                              if (productsController.isFromSearch.value) {
                                productsController.fetchSearchProduct(
                                    text:
                                        productsController.searchedText.value);
                                Get.back();
                              } else {
                                productsController.selectedFilterTypeName
                                    .value = productsController.initialType;
                                productsController.fetchProducts();
                                Get.back();
                              }
                            },
                            text: 'Reset',
                            width: 150.w,
                            shadowColor: Colors.transparent,
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Colors.grey, Colors.grey.shade400],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: globalButton(
                              onTap: () {
                                ///  fetching sorted  product
                                if (productsController
                                    .selectedSortName.value.isEmpty) {
                                  globalSnackBar(
                                      title: 'Alert!',
                                      message:
                                          'Please select an filter option');
                                } else {
                                  Log.i(
                                      "Selected variation is: ${productsController.selectedSizeName.value}  & ID is : ${productsController.selectedFilterSizeID.value}");
                                  if (productsController.isFromSearch.value) {
                                    productsController.isSorted.value = true;
                                    productsController.fetchSearchProduct(
                                        text: productsController
                                            .searchedText.value);
                                    Get.back();
                                  } else {
                                    productsController.isSorted.value = true;
                                    productsController.fetchProducts();
                                    Get.back();
                                  }
                                }
                              },
                              text: 'Apply',
                              shadowColor: Colors.transparent,
                              width: 150.w,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          },
        ));
  }
}
