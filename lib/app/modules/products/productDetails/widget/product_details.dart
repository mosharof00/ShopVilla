import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_villa/app/modules/my_order/widgets/product_labels.dart';
import 'package:shop_villa/global/sizedbox_extension.dart';
import '../../../../models/product_details/product_details_model.dart';

String capitalizeAndReplace(String? value) {
  if (value == null) return '';
  String capitalized = value.toUpperCase(); // Assuming you have a capitalize method
  return capitalized.replaceAll('_', ' ');
}

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.productDetails});

  final ProductDetailsData productDetails;

  @override
  Widget build(BuildContext context) {
    final List<Widget> labelsList = [
      if (productDetails.type != null)
        labels(
          text: 'Type : ${capitalizeAndReplace(productDetails.type)}',
          fontWeight: FontWeight.normal,
          fontSize: 12.sp,
        ),
      if (productDetails.gander != null)
        labels(
          text: 'Gender : ${capitalizeAndReplace(productDetails.gander)}',
          fontWeight: FontWeight.normal,
          fontSize: 12.sp,
        ),
      if (productDetails.productSku != null)
        labels(
          text: 'SKU : ${capitalizeAndReplace(productDetails.productSku)}',
          fontWeight: FontWeight.normal,
          fontSize: 12.sp,
        ),
      if (productDetails.totalStock != null)
        labels(
          text: 'Stock : ${productDetails.totalStock.toString()}',
          fontWeight: FontWeight.normal,
          fontSize: 12.sp,
        ),
      if (productDetails.shippingType != null)
        labels(
          text: 'Shipping Type : ${capitalizeAndReplace(productDetails.shippingType)}',
          fontWeight: FontWeight.normal,
          fontSize: 12.sp,
        ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final label in labelsList) ...[
          label,
          5.height,
        ],
      ],
    );
  }
}
