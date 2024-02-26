import 'package:chat_app_two/models/message.dart';
import 'package:flutter/material.dart';
import '../constant.dart';

class ChatBuble extends StatelessWidget {
  ChatBuble({super.key, required this.messagebuble});

  final Message messagebuble;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
          margin: const EdgeInsets.only(bottom: 10, left: 8, right: 8, top: 4),
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              color: KPrimaryColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                messagebuble.message,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.left,
              ),
            ],
          )),
    );
  }
}

class ChatBubleForFrind extends StatelessWidget {
  const ChatBubleForFrind({super.key, required this.messagebuble});

  final Message messagebuble;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
              color: Color(0xff006D84)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                messagebuble.message,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.left,
              ),
            ],
          )),
    );
  }
}
