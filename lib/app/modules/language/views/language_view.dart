import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../services/local_store_config.dart';
import '../controllers/language_controller.dart';

class LanguageView extends GetView<LanguageController> {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back_ios),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: AppTextStyle(
                    text: "Language",
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 50,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          String selectedKey = controller
                                  .languageList[controller.selectIndex.value]
                              ['keys'];
                          controller.selectedLanguageKey.value = selectedKey;
                          controller.language.value = controller
                              .selectedLanguageKey.value
                              .split('_')[0];
                          controller.country.value = controller
                              .selectedLanguageKey.value
                              .split('_')[1];
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Obx(
                () {
                  return ListView.builder(
                    itemCount: controller.languageList.length,
                    itemBuilder: (context, index) {
                      final language = controller.languageList[index];
                      return GestureDetector(
                        onTap: () {
                          Get.updateLocale(Locale(
                              language["keys"].split('_')[0],
                              language["keys"].split('_')[1]));
                          HiveService.setLanguage(language["keys"]);
                          controller.selectIndex.value = index;
                        },
                        child: Obx(
                          () {
                            return Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: controller.selectIndex.value == index
                                    ? Border.all(color: Colors.blue)
                                    : Border.all(color: Colors.grey.shade300),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        language["flagURL"],
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      AppTextStyle(
                                        text: language["name"],
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  AppTextStyle(
                                    text: language['language'],
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
