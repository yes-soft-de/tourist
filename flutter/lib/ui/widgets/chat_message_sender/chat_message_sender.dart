import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatMessageSender extends StatelessWidget {
  final Function onSendPressed;
  final TextEditingController _chatMessageController = TextEditingController();

  ChatMessageSender({@required this.onSendPressed});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextFormField(
            controller: _chatMessageController,
          ),
          GestureDetector(
            onTap: sendMessage(),
            child: Container(
              color: Colors.greenAccent,
              child: Icon(Icons.send),
            ),
          )
        ],
      ),
    );
  }

  sendMessage() {
    onSendPressed(_chatMessageController.text);
    _chatMessageController.clear();
  }
}
