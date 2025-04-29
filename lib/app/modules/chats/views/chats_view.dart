import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa/gen/colors.gen.dart';
import 'package:shop_villa/global/app_text_style.dart';
import 'package:shop_villa/global/cached_network_image_builder.dart';
import 'package:shop_villa/helper/avatar.dart';
import '../../../../global/app_text_style_over_flow.dart';
import '../../../../global/loading_animation_widget.dart';
import '../../../../helper/firebase_db_service.dart';
import '../controllers/chats_controller.dart';
import '../widget/build_text_composer.dart';
import '../widget/message_bubble.dart';

class ChatsView extends GetView<ChatsController> {
  const ChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          titleSpacing: 0,
          title: Row(
            children: [
              Obx(() {
                return StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(controller.otherUserID.value)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                    if (userSnapshot.hasData && userSnapshot.data != null) {
                      var userData = userSnapshot.data!.data() as Map<
                          String,
                          dynamic>?;
                      if (userData != null && userData.containsKey('name')) {
                        return Row(
                          children: [
                            avatar(height: 35.h, width: 35.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: SizedBox(
                                    width: 0.5.sw,
                                    child: AppTextStyleOverFlow(
                                      text: '${userData['name']}'.capitalize!,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      } else {
                        return const Text("Name field is missing");
                      }
                      // bool isOnline = userSnapshot.data![FBAtt.isOnline.name];
                      // return CircleAvatar(
                      //   backgroundColor: isOnline ? Colors.green : Colors.grey,
                      //   radius: 20.0,
                      //   child: Text(
                      //     userSnapshot.data!['Name'][0].toUpperCase(),
                      //     style: const TextStyle(
                      //       fontSize: 18.0,
                      //     ),
                      //   ),
                      // );
                      return Row(
                        children: [
                          // userSnapshot.data!['image'] == null
                          //     ? CircleAvatar(
                          //         backgroundColor:
                          //             isOnline ? Colors.green : Colors.grey,
                          //         radius: 20.0,
                          //         child: Text(
                          //           userSnapshot.data!['name'][0].toUpperCase(),
                          //           style: const TextStyle(
                          //               fontSize: 18.0,
                          //               overflow: TextOverflow.ellipsis),
                          //           overflow: TextOverflow.ellipsis,
                          //         ),
                          //       )
                          //     : CircleAvatar(
                          //         backgroundImage:
                          //             NetworkImage(userSnapshot.data!['image']),
                          //         radius: 20,
                          //       ),
                          avatar(height: 35.h, width: 35.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                                child: SizedBox(
                                  width: 0.5.sw,
                                  child: AppTextStyleOverFlow(
                                      text: '${userSnapshot.data!['name']}'
                                          .capitalize!,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                              ),

                              /// Typing and online
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(vertical: 2.0),
                              //   child: StreamBuilder<DocumentSnapshot>(
                              //     stream: FirebaseFirestore.instance
                              //         .collection('conversation')
                              //         .doc(controller.currentUserID)
                              //         .collection(controller.currentUserID!)
                              //         .doc(controller.otherUserID)
                              //         .snapshots(),
                              //     builder: (BuildContext context,
                              //         AsyncSnapshot<DocumentSnapshot> snapshot) {
                              //       if (snapshot.hasData && snapshot.data!.exists) {
                              //         bool isTyping = snapshot.data!['isTyping'];
                              //         // bool inChatstatus = snapshot.data!['inChat'];
                              //         //FirebaseDB.inChatstatus = inChatstatus;
                              //
                              //     ///Typing
                              //         // return isTyping
                              //         //     ? Padding(
                              //         //         padding: const EdgeInsets.symmetric(
                              //         //             horizontal: 8.0),
                              //         //         child: Row(
                              //         //           children: [
                              //         //             AppTextStyle(
                              //         //                 text: "Typing...",
                              //         //                 fontSize: 10,
                              //         //                 fontWeight: FontWeight.w700,
                              //         //                 color: Colors.white),
                              //         //           ],
                              //         //         ),
                              //         //       )
                              //         //     : Padding(
                              //         //         padding: const EdgeInsets.symmetric(
                              //         //             horizontal: 8.0),
                              //         //         child: AppTextStyle(
                              //         //             text: isOnline
                              //         //                 ? "Online"
                              //         //                 : "Last seen ${HelperUtils.formatTimestamp(userSnapshot.data!['time'])}",
                              //         //             fontSize: 10,
                              //         //             fontWeight: FontWeight.w700,
                              //         //             color: Colors.white54),
                              //         //       );
                              //       } else {
                              //         return const SizedBox.shrink();
                              //       }
                              //     },
                              //   ),
                              // )
                            ],
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                );
              }),
            ],
          ),
          backgroundColor: Colors.blue,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: ColorName.primaryColor,
            ),
          ),
          actions: <Widget>[
            PopupMenuButton(
              icon: const Icon(Icons.more_vert,
                  color: Colors.white),
              // add this line

              onSelected: (result) {
                if (result == 0) {}
              },

              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              offset: const Offset(0, 45),
              // SET THE (X,Y) POSITION
              iconSize: 30,
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    // Navigator inside PopupMenuItem does not work it pop after push
                    value: 0,
                    child: Text('View profile'),
                  ),
                ];
              },
            )
          ],
        ),
        body: Obx(() {
          if (controller.currentUserID.value != null) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseDBService.getMessages(
                        controller.currentUserID.value.toString(),
                        controller.otherUserID.value.toString()),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: loadingAnimationWidget(),
                        );
                      }
                      var messages = snapshot.data!.docs;
                      FirebaseDBService.messages = messages;
                      List<Widget> messageWidgets = [];
                      for (var message in messages) {
                        final messageText = message[FBAtt.text.name];
                        final messageSender = message[FBAtt.senderId.name];
                        final messageWidget = MessageBubble(
                          sender: messageSender,
                          text: messageText,
                          isMe: messageSender ==
                              controller
                                  .currentUserID
                                  .value, // Assume we're only chatting with one other person
                        );
                        // controller.playSound();
                        messageWidgets.add(messageWidget);
                      }
                      return ListView(
                        reverse: true,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 10.0),
                        children: messageWidgets,
                      );
                    },
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(),
                  child: buildTextComposer(
                    onTypingStarted: () {
                      controller.updateTypingStatus(true);
                    },
                    onTypingEnded: () {
                      controller.updateTypingStatus(false);
                    },
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Column(
                children: [
                  loadingAnimationWidget(),
                  const AppTextStyle(text: 'Waiting for user data...'),
                ],
              ), // Show placeholder while IDs are null
            );
          }
        })
    );
  }
}
