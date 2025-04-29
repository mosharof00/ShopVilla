import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String senderId;
  final String receiverId;
  final String message;
  final Timestamp timestamp;

  ChatMessage({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
    };
  }

  static ChatMessage fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    // Safely access the fields and provide default values if necessary
    final senderId = data['senderId'] ?? '';
    final receiverId = data['receiverId'] ?? '';
    final message = data['message'] ?? '';
    final timestamp = data['timestamp'] ?? Timestamp.now(); // Default to current time if null

    return ChatMessage(
      senderId: senderId,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
    );
  }
}
