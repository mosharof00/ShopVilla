import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../gen/colors.gen.dart';
import '../../controllers/home_controller.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Obx(() {
      if (controller.sliderList.isNotEmpty) {
        return DotsIndicator(
          dotsCount: controller.sliderList.length,
          position: controller.currentDotedIndex.value.toDouble(),
          decorator: DotsDecorator(
              activeColor: ColorName.onPrimary,
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              activeSize: const Size.square(12)),
          onTap: (index) {
            controller.currentDotedIndex.value = index;
            controller.carouselController1
                .animateToPage(controller.currentDotedIndex.value);
          },
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
