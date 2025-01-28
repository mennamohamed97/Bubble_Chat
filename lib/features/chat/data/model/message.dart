import 'package:my_chat/core/utililes/constants.dart';

class Message {
  final String message;
  final String id;
  Message(this.message, this.id);

  factory Message.fromJson(Map<String, dynamic> jsonData) {
    return Message(
      jsonData[kMessage] ?? '',
      jsonData['id'] ?? '',
    );
  }
}
