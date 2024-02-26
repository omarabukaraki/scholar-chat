import 'package:chat_app_two/constant.dart';

class Message {
  final String message;
  final String id;

  Message(this.message, this.id);

  factory Message.fromJson(jsonData) {
    return Message(jsonData[Kmessage], jsonData['id']);
  }
}
