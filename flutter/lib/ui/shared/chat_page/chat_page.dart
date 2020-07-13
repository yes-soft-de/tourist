import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/bloc/chat_page/chat_page.bloc.dart';
import 'package:tourists/models/chat/chat_model.dart';
import 'package:tourists/ui/widgets/chat_message_sender/chat_message_sender.dart';

@provide
class ChatPage extends StatefulWidget {
  final ChatPageBloc _chatPageBloc;

  ChatPage(this._chatPageBloc);

  @override
  State<StatefulWidget> createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  List<ChatModel> _chatMessagesList;
  int currentState = ChatPageBloc.STATUS_CODE_INIT;

  @override
  Widget build(BuildContext context) {
    if (currentState == ChatPageBloc.STATUS_CODE_INIT)
      widget._chatPageBloc.getMessages("123456789");

    widget._chatPageBloc.chatBlocStream.listen((event) {
      currentState = event.first;
      if (event.first == ChatPageBloc.STATUS_CODE_GOT_DATA) {
        _chatMessagesList = event.last;
        setState(() {});
      }
    });

    if (_chatMessagesList != null) {
      _chatMessagesList.forEach((chat) {
        log(chat.msg);
      });
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            bottom: 56,
            child: Container(),
          ),
//          Positioned(
//            bottom: 56,
//            child: ChatMessageSender(
//              onSendPressed: sendMessage,
//            ),
//          )
        ],
      ),
    );
  }

  sendMessage(String msg) {
    print("Send Message is Pressed");
  }
}
