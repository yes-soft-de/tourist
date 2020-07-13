import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inject/inject.dart';
import 'package:tourists/repositories/chat/chat_repository.dart';

@provide
class ChatManager {
  ChatRepository _chatRepository;

  ChatManager(this._chatRepository);

  Stream<QuerySnapshot> getMessages(String chatRoomID) {
    return _chatRepository.requestMessages(chatRoomID);
  }
}