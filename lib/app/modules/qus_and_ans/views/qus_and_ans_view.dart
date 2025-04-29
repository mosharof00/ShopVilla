import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shop_villa/app/modules/qus_and_ans/widget/quesAns.dart';
import 'package:shop_villa/gen/colors.gen.dart';
import 'package:shop_villa/global/app_text_style.dart';
import 'package:shop_villa/global/searchbar_global.dart';
import 'package:shop_villa/helper/appbar_title.dart';

import '../../../services/local_store_config.dart';
import '../controllers/qus_and_ans_controller.dart';

class QusAndAnsView extends GetView<QusAndAnsController> {
  const QusAndAnsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final productID = Get.arguments;
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        surfaceTintColor: ColorName.bgColor,
        title: appbarTitle(text: 'Q&A'),
        centerTitle: true,
      ),
      body: const QusAns(),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 8.0,
          left: 8.0,
          right: 8.0,
        ),
        child: InputFieldWithSendButton(
          onTap: () async {
            final userID = await HiveService.getUserID();
            if (userID != null &&
                controller.textEditingController.text.isNotEmpty) {
              controller.qaUserQus(
                  userID: userID.toString(),
                  productID: productID.toString(),
                  qus: controller.textEditingController.text);
            } else {
              const ToastCard(
                title: AppTextStyle(text: 'Question'),
                subtitle: AppTextStyle(
                  text: 'No UserID Found',
                ),
              );
            }
          },
          textEditingController: controller.textEditingController,
          prefixIcon: Icons.question_answer,
          icon: MdiIcons.send,
        ),
      ),
    );
  }
}
