import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../gen/colors.gen.dart';

Widget shimmerLoadingWidget(
    {double? height, double? width, double? borderRadius}) {
  return SizedBox(
    width: width ?? 100.0,
    height: height ?? 100.0,
    child: Shimmer.fromColors(
        baseColor: ColorName.primaryColor.withOpacity(0.1),
        highlightColor: Colors.white,
        child: Container(
            decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
        ))),
  );
}

Widget shimmerLoadingCircularWidget({double? height, double? width}) {
  return SizedBox(
    width: width ?? 100.0,
    height: height ?? 100.0,
    child: Shimmer.fromColors(
        baseColor: ColorName.primaryColor.withOpacity(0.1),
        highlightColor: Colors.white,
        child: Container(
            decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ))),
  );
}

Widget shimmerLoadingListVerticalWidget() {
  return Shimmer.fromColors(
    baseColor: Colors.black54,
    highlightColor: Colors.white,
    child: ListView.builder(
      itemBuilder: (_, __) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          color: Colors.white,
          height: 100,
        ),
      ),
      itemCount: 6,
    ),
  );
}

Widget shimmerLoadingListHorizontalWidget({double? height, double? width}) {
  return SizedBox(
    height: 280.h,
    width: Get.width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 20.h,
            left: 10.w,
            right: 10.w,
          ),
          child: shimmerLoadingWidget(
              height: 30.h, width: Get.width, borderRadius: 10.r),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 6,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) => Padding(
              padding: EdgeInsets.all(10.r),
              child: shimmerLoadingWidget(
                  width: width ?? Get.width / 2.2.w,
                  height: height ?? 270.h,
                  borderRadius: 20.r),
            ),
          ),
        ),
      ],
    ),
  );
}
