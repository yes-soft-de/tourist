import 'package:inject/inject.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

@provide
class ChatPageBloc {
  static const STATUS_CODE_INIT = 1588;
  static const STATUS_CODE_EMPTY_LIST = 1589;
  static const STATUS_CODE_GOT_DATA = 1590;

  // We Should get the UUID of the ChatRoom, as such we should request the data here
  getMessages(String chatRoomID) {
    Firestore.instance.collection('chat_rooms').document(chatRoomID).snapshots().listen((event) {
        print(event.toString());
    });
  }
}