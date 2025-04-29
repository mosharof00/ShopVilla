import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shop_villa/app/models/product/porduct_model_api.dart';
import 'package:shop_villa/helper/product_layout.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key, this.productList,});

  final List<dynamic>? productList;
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: productList!.length,
        itemBuilder: (context, item) {
          final ProductData products = productList![item];
          return AnimationConfiguration.staggeredList(
            position: item,
            duration: const Duration(milliseconds: 500),
            child: SlideAnimation(
              verticalOffset: 50,
              child: FadeInAnimation(
                child: ProductLayout(
                  product: products,
                ),
              ),
            )
          );
        },
      ),
    );
  }
}
