// ignore: unused_import
import 'dart:convert';
import 'package:chat_app_two/models/message.dart';
import 'package:chat_app_two/view/cubits/chat_cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../component/chat_buble.dart';
import '../constant.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  static String id = 'ChatPage';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = ScrollController();

  String? message;

  /*use in text field*/
  TextEditingController controller = TextEditingController();

  List<Message> messagesList = [];

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    /*data or something come when the data changed in firebase(using to real time changes)*/

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        /*Remove arrow back*/
        backgroundColor: KPrimaryColor,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              KLogo,
              height: 55,
            ),
            const Text(
              'chat',
              style: TextStyle(fontFamily: 'Pacifico'),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            /*take a available area*/
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatSuccess) {
                  messagesList = state.messages;
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    return messagesList[index].id == email
                        ? ChatBuble(
                            messagebuble: messagesList[index],
                          )
                        : ChatBubleForFrind(messagebuble: messagesList[index]);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                message = value;
              },
              onSubmitted: (value) {
                BlocProvider.of<ChatCubit>(context)
                    .sendMessage(message: message!, email: email);
                controller.clear();
                _controller.animateTo(
                  // _controller.position.maxScrollExtent,
                  0,
                  duration: Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                );
              },
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Send Message',
                suffixIcon: IconButton(
                  onPressed: () {
                    BlocProvider.of<ChatCubit>(context)
                        .sendMessage(message: message!, email: email);
                    controller.clear();
                    _controller.animateTo(
                      // _controller.position.maxScrollExtent,
                      0,
                      duration: Duration(seconds: 1),
                      curve: Curves.fastOutSlowIn,
                    );
                    // setState(() {});
                    // messages.add({'messages': send});
                    controller.clear();
                  },
                  icon: const Icon(
                    Icons.send,
                    color: KPrimaryColor,
                  ),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: KPrimaryColor)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
