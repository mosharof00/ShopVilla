import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_villa/gen/colors.gen.dart';

import '../../../../appConfig.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.navigateToMainPage();
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      body: Center(
          child: Image.asset(
            AppConfig.appLogo,
        fit: BoxFit.cover,
      )),
    );
  }
}
