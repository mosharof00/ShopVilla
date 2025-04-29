import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa/app/modules/profile/controllers/profile_controller.dart';
import 'package:shop_villa/app/services/local_store_config.dart';
import 'package:shop_villa/app/services/pushNotificationService.dart';
import 'package:shop_villa/helper/helper_utils.dart';
import 'package:shop_villa/helper/log_printer.dart';
import '../../../../../helper/firebase_db_service.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../global/app_text_style.dart';
import '../../../../global/cached_network_image_builder.dart';
import '../../../models/product_details/product_details_model.dart';
import '../controllers/chats_controller.dart';

Widget buildTextComposer(
    {required VoidCallback onTypingStarted,
    required VoidCallback onTypingEnded}) {
  bool isTyping = false;
  final controller = Get.put(ChatsController());
  void handleTypingStatusChange(bool typing) {
    if (typing != isTyping) {
      isTyping = typing;
      if (isTyping) {
        onTypingStarted();
      } else {
        onTypingEnded();
      }
    }
  }

  return Container(
    padding: const EdgeInsets.only(bottom: 20.0),
    margin: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Column(
      children: [
        controller.productDetails.value.productName != null
            ? ListTile(
                minLeadingWidth: 0,
                leading: cachedImageHelper(
                  radius: 10,
                  imgurl: controller
                      .productDetails.value.productvariations![0].image!,
                  imgWidth: 40.w,
                  imgHeight: 40.h,
                ),
                title: AppTextStyle(
                  text: 'Chat with us',
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  fontSize: 12.sp,
                  color: ColorName.black,
                  fontWeight: FontWeight.w700,
                ),
                subtitle: AppTextStyle(
                  text: controller.productDetails.value.productName!,
                  maxLines: 1,
                  fontSize: 13.sp,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w500,
                ),
              )
            : const SizedBox.shrink(),
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: controller.textController,
                onChanged: (String text) {
                  handleTypingStatusChange(text.isNotEmpty);
                },
                maxLines: 3,
                minLines: 1,
                //onSubmitted: _handleSubmitted,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  // suffixIcon: SpeedDial(
                  //   elevation: 0,
                  //   buttonSize: Size(10.w, 10.h),
                  //   closeDialOnPop: false,
                  //   backgroundColor: ColorName.white,
                  //   children: <SpeedDialChild>[
                  //     SpeedDialChild(
                  //       child: Icon(MdiIcons.image, size: 10,),
                  //       foregroundColor: Colors.white,
                  //       backgroundColor: ColorName.primaryColor,
                  //       shape: const CircleBorder(),
                  //       labelStyle: GoogleFonts.nanumGothic(
                  //           fontSize: 12.sp, fontWeight: FontWeight.w600),
                  //       label: 'Image'.tr,
                  //       onTap: () {
                  //         controller.getFile();
                  //       },
                  //     ),
                  //     SpeedDialChild(
                  //       elevation: 0,
                  //       child: Icon(MdiIcons.microphone),
                  //       foregroundColor: Colors.white,
                  //       backgroundColor: ColorName.primaryColor,
                  //       shape: const CircleBorder(),
                  //       label: 'Audio'.tr,
                  //       labelStyle: GoogleFonts.nanumGothic(
                  //           fontSize: 12.sp, fontWeight: FontWeight.w600),
                  //       onTap: () {
                  //       },
                  //     ),
                  //     //  Your other SpeedDialChildren go here.
                  //   ],
                  //   child: Icon(
                  //     MdiIcons.paperclip,
                  //     size: 25,
                  //   ),
                  // ),
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: ColorName.primaryColor, width: 1.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 0.1),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  hintText: "Send a message",
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.send,
                color: ColorName.primaryColor,
              ),
              onPressed: (){
                if (controller.productDetails.value.productName != null) {
                  handleSubmitted(
                    '${controller.productDetails.value.productName}\n\n${controller.textController.text}',
                  );
                  controller.productDetails.value = ProductDetailsData();
                } else {
                  handleSubmitted(controller.textController.text);
                }
              },
            ),
          ],
        ),
      ],
    ),
  );
}

void handleSubmitted(String text) async {
  final controller = Get.find<ChatsController>();
  final profileController = Get.find<ProfileController>();

  // Clear the text field
  controller.textController.clear();
  // Retrieve recipient's document
  final otherUserDoc = await FirebaseFirestore.instance
      .collection('users')
      .doc(controller.otherUserID.value.toString())
      .get();

  // Retrieve current user's document
  final currentUserDoc = await FirebaseFirestore.instance
      .collection('users')
      .doc(controller.currentUserID.value.toString())
      .get();

  // Send message using FirebaseDBService
  FirebaseDBService.sendMessage(
    controller.currentUserID.value.toString(),
    controller.otherUserID.value.toString(),
    FILETYPE.text.name,
    msg: text,
    currentUserName: profileController.profileDetails.value.data!.name,
  );

  // Get device token
  final currentDeviceToken = HelperUtils.firebaseToken;

  // Get user ID from HiveService
  final userID = (await HiveService.getUserID()).toString();

  // Check if current user document exists; if not, create it
  if (!currentUserDoc.exists) {
    await FirebaseFirestore.instance.collection('users').doc(userID).set({
      'email': profileController.profileDetails.value.data!.email,
      'name': profileController.profileDetails.value.data!.name,
      'id': profileController.profileDetails.value.data!.id,
      'device_token': currentDeviceToken,
    });
  }

  // If recipient's document exists, send push notification
  if (otherUserDoc.exists) {
    final otherUserDeviceToken = otherUserDoc['device_token'];
    final currentUserName = profileController.profileDetails.value.data!.name;
    if (otherUserDeviceToken != null) {
      await PushNotificationService.sendNotificationToSelectedDriver(
        deviceToken: otherUserDeviceToken,
        context: Get.context!,
        currentUserName: currentUserName!,
        currentUserMsg: text,
      );
    }
  } else {
    Log.e('User document does not exist');
  }
}
