import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/managers/chat/chat_manager.dart';
import 'package:tourists/models/chat/chat_model.dart';
import 'package:tourists/persistence/sharedpref/shared_preferences_helper.dart';

@provide
class ChatService {
  ChatManager _chatManager;
  SharedPreferencesHelper _preferencesHelper;

  ChatService(this._chatManager, this._preferencesHelper);

  // This is Real Time, That is Why I went this way
  PublishSubject<List<ChatModel>> _chatPublishSubject = new PublishSubject();
  Stream<List<ChatModel>> get chatMessagesStream => _chatPublishSubject.stream;

  requestMessages(String chatRoomID) async {
    _chatManager.getMessages(chatRoomID).listen((event) {
      List<ChatModel> chatMessagesList = [];
      event.documents.forEach((element) {
        log(element.data.keys.toString());
        chatMessagesList.add(new ChatModel.fromJson(element.data));
      });

      _chatPublishSubject.add(chatMessagesList);
    });
  }

  sendMessage(String chatRoomID, String msg) {
    _preferencesHelper.getUserUID().then((uid) {
       ChatModel model = new ChatModel(msg: msg, sender: uid, sentDate: DateTime.now().toIso8601String());
       _chatManager.sendMessage(chatRoomID, model);
    });
  }

  dispose() {
    _chatPublishSubject.close();
  }
}
