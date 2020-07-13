import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/managers/chat/chat_manager.dart';
import 'package:tourists/models/chat/chat_model.dart';

@provide
class ChatService {
  ChatManager _chatManager;
  ChatService(this._chatManager);

  // This is Real Time, That is Why I went this way
  PublishSubject<List<ChatModel>> _chatPublishSubject = new PublishSubject();
  Stream<List<ChatModel>> get chatMessagesStream => _chatPublishSubject.stream;

  requestMessages(String chatRoomID) async {
    _chatManager.getMessages(chatRoomID).listen((event) {
      List<ChatModel> chatMessagesList = [];
      event.documents.forEach((element) {
        chatMessagesList.add(new ChatModel.fromJson(element.data));
      });

      _chatPublishSubject.add(chatMessagesList);
    });
  }

  dispose() {
    _chatPublishSubject.close();
  }
}
