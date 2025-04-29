import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_villa/helper/log_printer.dart';

enum FBAtt {
  messageID,
  senderId,
  text,
  imageUrl,
  fileUrl,
  msgType,
  isFileUploading,
  msgSeen,
  msgDeleteFrom,
  isReplyMsg,
  isReactMsg,
  reactPeople,
  replayMsg,
  replayMsgIndex,
  replayFileType,
  replayFileUrl,
  timestamp,
  chats,
  messages,
  user,
  isOnline,
  deviceToken,
  blocklist,
  isBlock,
  whoGiveBlocked
}

enum FILETYPE {
  text,
  image,
  audio,
  video,
  doc,
  pdf,
}

class FirebaseDBService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static List<DocumentSnapshot<Object?>> messages = const [];

  static sendMessage(
    String currentUserID,
    String otherUserID,
    String msgType, {
    List<String>? imageUrl,
    bool isFileUploading = false,
    bool isReplyMsg = false,
    String? replyMsg,
    int replayMsgIndex = 0,
    bool isReactMsg = false,
    List<Object>? rectPerson,
    List<String>? userID,
    String? replyFileUrl,
    String? replyFileType,
    String? fileUrl,
    String? msg,
    String? currentUserName,
  }) async {
    String childChatId = getChatId(currentUserID, otherUserID);
    UniqueKey key = UniqueKey();
    String messageID =
        "${childChatId}_${DateTime.now().microsecondsSinceEpoch}_${key.toString()}";
    final message = {
      FBAtt.messageID.name: messageID,
      FBAtt.senderId.name: currentUserID,
      FBAtt.text.name:
          msgType != FILETYPE.text.name ? "$msgType sent" : msg!.trim(),
      FBAtt.imageUrl.name: imageUrl,
      FBAtt.fileUrl.name: fileUrl,
      FBAtt.msgType.name: msgType, // message type text,image,doc,file,link etc
      FBAtt.isFileUploading.name: isFileUploading,
      FBAtt.msgSeen.name: false,
      FBAtt.msgDeleteFrom.name: userID,
      FBAtt.isReplyMsg.name: isReplyMsg, //check msg has is replay or not
      FBAtt.isReactMsg.name: isReactMsg,
      FBAtt.reactPeople.name: rectPerson,
      FBAtt.replayMsg.name: replyMsg,
      FBAtt.replayFileType.name: replyFileType,
      FBAtt.replayFileUrl.name: replyFileUrl,
      FBAtt.replayMsgIndex.name: replayMsgIndex,
      FBAtt.timestamp.name: FieldValue.serverTimestamp(),
    };
    if (isFileUploading) {
      if (msgType == FILETYPE.image.name) {
        FirebaseFirestore.instance
            .collection(FBAtt.chats.name)
            .doc(childChatId)
            .collection(FBAtt.messages.name)
            .doc(messageID)
            .set(message);
        //controller.sentImageAwsServer(selectedImages!, childChatId, messageID);
      }
      if (msgType == FILETYPE.video.name) {
        FirebaseFirestore.instance
            .collection(FBAtt.chats.name)
            .doc(childChatId)
            .collection(FBAtt.messages.name)
            .doc(messageID)
            .set(message);
        // controller.sentVideoAwsServer(fileUrl!, childChatId, messageID);
      }
    } else {
      FirebaseFirestore.instance
          .collection(FBAtt.chats.name)
          .doc(childChatId)
          .collection(FBAtt.messages.name)
          .doc(messageID)
          .set(message);
    }
    if (messages.isEmpty) {
      /// Admin Welcome Message

      UniqueKey key2 = UniqueKey();

      String msgID =
          "${childChatId}_${DateTime.now().microsecondsSinceEpoch}_${key2.toString()}";
      final message2 = {
        FBAtt.messageID.name: msgID,
        FBAtt.senderId.name: otherUserID,
        FBAtt.text.name: msgType != FILETYPE.text.name
            ? "$msgType sent"
            : "Hi $currentUserName, Thank you for messaging us. We are here to help you at every step. If you have a question or complaint, chat with our customer care team 24/7",
        FBAtt.imageUrl.name: imageUrl,
        FBAtt.fileUrl.name: fileUrl,
        FBAtt.msgType.name:
            msgType, // message type text,image,doc,file,link etc
        FBAtt.isFileUploading.name: isFileUploading,
        FBAtt.msgSeen.name: false,
        FBAtt.msgDeleteFrom.name: userID,
        FBAtt.isReplyMsg.name: isReplyMsg, //check msg has is replay or not
        FBAtt.isReactMsg.name: isReactMsg,
        FBAtt.reactPeople.name: rectPerson,
        FBAtt.replayMsg.name: replyMsg,
        FBAtt.replayFileType.name: replyFileType,
        FBAtt.replayFileUrl.name: replyFileUrl,
        FBAtt.replayMsgIndex.name: replayMsgIndex,
        FBAtt.timestamp.name: FieldValue.serverTimestamp(),
      };
      FirebaseFirestore.instance
          .collection(FBAtt.chats.name)
          .doc(childChatId)
          .collection(FBAtt.messages.name)
          .doc(msgID)
          .set(message2);

      //FirstTime insert both conversation
      insertConversationFirstTime(currentUserID, otherUserID,
          msgType != FILETYPE.text.name ? "$msgType sent" : msg!, false);
    } else {
      if (messages.last[FBAtt.msgDeleteFrom.name] == null) {
        updateLastMsgConversation(currentUserID, otherUserID,
            msgType != FILETYPE.text.name ? "$msgType sent" : msg!, false);
      } else {
        if (List<String>.from(messages.last[FBAtt.msgDeleteFrom.name]).contains(
            otherUserID)) //check other person is conversion deleted or not if delete then insert again or update
        {
          insertConversationFirstTime(currentUserID, otherUserID,
              msgType != FILETYPE.text.name ? "$msgType sent" : msg!, false);
        } else {
          updateLastMsgConversation(currentUserID, otherUserID,
              msgType != FILETYPE.text.name ? "$msgType sent" : msg!, false);
        }
      }
    }

    // if (controller.isReplay.value) {
    //   controller.replayResetStateValue();
    // }
    // _scrollToBottom();

    // FirebaseDB.sendNotification(
    //    token == null ? "" :token!,
    //    userName,
    //     msgType != FILETYPE.text.name
    //         ? "$msgType sent"
    //         : _textEditingController.text,
    //    currentUserID,
    //    otherUserID);

    // _textEditingController.clear();

    // if(selectedImages!=null && imageUrl!=)
    //   {
    //     imageUrl!.clear();
    //   }

    // setState(() {
    //   writingState = false;
    // });
    // setTypingStatus(false);
  }

  // void _addUserList(List<DocumentSnapshot<Object?>> list) {
  //   messages = list;
  // }

  // static Stream<List<DocumentSnapshot>> getMessagesStream(String currentUserID, String otherUserID) {
  //   String childChatId = getChatId(currentUserID, otherUserID);
  //
  //   final collection = FirebaseFirestore.instance.collection('chats').doc(childChatId).collection('messages').orderBy('timestamp', descending: true).snapshots();
  //   return collection.map((querySnapshot) {
  //     final filteredDocs = querySnapshot.docs.where((doc) {
  //       if (doc.get(FBAtt.msgDeleteFrom.name) == null) {
  //         return true;
  //       } else {
  //         List<String> deletedUserList = List<String>.from(doc.get(FBAtt.msgDeleteFrom.name));
  //         return !deletedUserList.contains(currentUserID);
  //       }
  //     }).toList();
  //
  //     return filteredDocs;
  //   });
  // }

  static Stream<QuerySnapshot> getMessages(
      String currentUserID, String otherUserID) {
    String childChatId = getChatId(currentUserID, otherUserID);
    return _firestore
        .collection('chats')
        .doc(childChatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  static String getChatId(String currentUserID, String otherUserID) {
    final userIds = [currentUserID, otherUserID];
    userIds.sort();
    return userIds.join('_');
  }

  static Stream<QuerySnapshot> getChatMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots();
  }

  static void insertConversationFirstTime(
      String userID, String otherUserID, String msg, bool msgSeen) {
    final userInfo = {
      "msgSeen": msgSeen,
      "lastMessage": msg,
      "id": otherUserID,
      "senderID": userID, // sender is who write and press send
      "time": FieldValue.serverTimestamp(),
      "inChat": false,
      "isTyping": false,
    };
    FirebaseFirestore.instance
        .collection('conversation')
        .doc(userID)
        .collection(userID)
        .doc(otherUserID)
        .set(userInfo);

    final userInfoOther = {
      "msgSeen": msgSeen,
      "lastMessage": msg,
      "id": userID,
      "senderID": userID,
      "time": FieldValue.serverTimestamp(),
      "inChat": false,
      "isTyping": false,
    };
    FirebaseFirestore.instance
        .collection('conversation')
        .doc(otherUserID)
        .collection(otherUserID)
        .doc(userID)
        .set(userInfoOther);
  }

  static void updateLastMsgConversation(
      String userID, String otherUserID, String msg, bool msgSeen) {
    final userInfo = {
      "msgSeen": msgSeen,
      "lastMessage": msg,
      "id": otherUserID,
      "senderID": userID, // sender is who write and press send
      "time": FieldValue.serverTimestamp(),
      "inChat": false,
      "isTyping": false,
    };
    FirebaseFirestore.instance
        .collection('conversation')
        .doc(userID)
        .collection(userID)
        .doc(otherUserID)
        .update(userInfo);

    final userInfoOther = {
      "msgSeen": msgSeen,
      "lastMessage": msg,
      "id": userID,
      "senderID": userID,
      "time": FieldValue.serverTimestamp(),
      "inChat": false,
      "isTyping": false,
    };
    FirebaseFirestore.instance
        .collection('conversation')
        .doc(otherUserID)
        .collection(otherUserID)
        .doc(userID)
        .update(userInfoOther);
  }

  static void updateTyingStatus(
      String userID, String otherUserID, bool status) async {
    final userInfoOther = {
      "isTyping": status,
    };
    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.update(
          FirebaseFirestore.instance
              .collection('conversation')
              .doc(otherUserID)
              .collection(otherUserID)
              .doc(userID),
          userInfoOther);
    }).onError((error, stackTrace) {});
  }

  static updateOnlineStatus(String userID, bool status) {
    final userInfo = {
      "time": FieldValue.serverTimestamp(),
      "isOnline": status,
    };

    FirebaseFirestore.instance
        .runTransaction((transaction) async {
          transaction.update(
              FirebaseFirestore.instance.collection('user').doc(userID),
              userInfo);
        })
        .onError((error, stackTrace) {})
        .whenComplete(() => print("online status updated..."));
  }

  static Future<void> deleteMessage(String messageId) async {
    await _firestore.collection('messages').doc(messageId).delete();
  }
}
