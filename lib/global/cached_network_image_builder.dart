import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_villa/global/shimmer_loading.dart';

import '../gen/assets.gen.dart';
import 'methods/get_image_url.dart';

Widget cachedImageHelper({
  required String imgurl,
  double? shimmerHeight,
  double? shimmerWidth,
  double? imgHeight,
  double? imgWidth,
  double? radius,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(radius ?? 15.r),
    child: CachedNetworkImage(
      imageUrl: GetImageUrl.url(imgurl),
      fit: BoxFit.fill,
      height: imgHeight ?? 100.h,
      width: imgWidth ?? 90.w,
      placeholder: (context, url) => shimmerLoadingWidget(
          height: imgHeight ?? shimmerHeight, width: imgWidth ?? shimmerWidth),
      errorWidget: (context, url, error) => SvgPicture.asset(
        Assets.images.errorThumbnail,
        height: shimmerHeight ?? imgHeight,
        width: shimmerWidth ?? imgWidth,
      ),
    ),
  );
}

Widget circularImage({
  double? radius,
  required String imgUrl,
  double? imgRadius,
  double? imgHeight,
  double? imgWidth,
}) {
  return CircleAvatar(
    radius: radius ?? 20.r,
    child: cachedImageHelper(
      imgurl: imgUrl,
      radius: imgRadius ?? 50.r,
      imgWidth: imgWidth ?? 45.w,
      imgHeight: imgHeight ?? 45.h,
    ),
  );
}
