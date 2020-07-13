import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inject/inject.dart';

@provide
class ChatRepository {
  Firestore _firestore = Firestore.instance;

  Stream<QuerySnapshot> requestMessages(String chatRoomID) {
    return _firestore
        .collection('chat_rooms')
        .document(chatRoomID)
        .collection('messages')
        .snapshots();
  }
}
