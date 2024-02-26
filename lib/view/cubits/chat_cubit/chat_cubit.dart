import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../constant.dart';
import '../../../models/message.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages =
      FirebaseFirestore.instance.collection(KmessagesCollections);
  void sendMessage({
    required String message,
    required String email,
  }) {
    messages.add({
      Kmessage: message,
      KcreatedAt: DateTime.now().toString(),
      'id': email,
    });
  }

  void getMessage() {
    messages.orderBy(KcreatedAt, descending: true).snapshots().listen((event) {
      List<Message> messagesList = [];
      for (var doc in event.docs) {
        messagesList.add(Message.fromJson(doc));
      }
      emit(ChatSuccess(messages: messagesList));
    });
  }
}
