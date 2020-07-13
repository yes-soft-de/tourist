import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/bloc/chat_page/chat_page.bloc.dart';
import 'package:tourists/ui/widgets/chat_message_sender/chat_message_sender.dart';

@provide
class ChatPage extends StatefulWidget {
  final ChatPageBloc _chatPageBloc;

  ChatPage(this._chatPageBloc);

  @override
  State<StatefulWidget> createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    widget._chatPageBloc.getMessages("123456789");

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            bottom: 56,
            child: ListView(
              // TODO: Messages Here
            ),
          ),
          Positioned(
            bottom: 56,
            child: ChatMessageSender(
              onSendPressed: sendMessage,
            ),
          )
        ],
      ),
    );
  }

  sendMessage(String msg) {
    print("Send Message is Pressed");
  }
}
