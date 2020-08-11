import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/module_chat/bloc/chat_page/chat_page.bloc.dart';
import 'package:tourists/module_chat/model/chat/chat_model.dart';
import 'package:tourists/module_chat/ui/widget/chat_bubble/chat_bubble.dart';
import 'package:tourists/module_persistence/sharedpref/shared_preferences_helper.dart';

@provide
class ChatPage extends StatefulWidget {
  final ChatPageBloc _chatPageBloc;
  final SharedPreferencesHelper _preferencesHelper;

  ChatPage(this._chatPageBloc, this._preferencesHelper);

  @override
  State<StatefulWidget> createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  List<ChatModel> _chatMessagesList = [];
  int currentState = ChatPageBloc.STATUS_CODE_INIT;

  TextEditingController _msgController = TextEditingController();
  List<ChatBubbleWidget> chatsMessagesWidgets = [];

  @override
  Widget build(BuildContext context) {
    if (currentState == ChatPageBloc.STATUS_CODE_INIT)
      widget._chatPageBloc.getMessages("123456789");

    widget._chatPageBloc.chatBlocStream.listen((event) {
      currentState = event.first;
      if (event.first == ChatPageBloc.STATUS_CODE_GOT_DATA) {
        _chatMessagesList = event.last;
        if (chatsMessagesWidgets.length == _chatMessagesList.length) {
          log("Same Batch Twice");
        } else {
          buildMessagesList(_chatMessagesList).then((value) {
            setState(() {});
          });
        }
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        // direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[Text('Title')],
          ),
          Expanded(
            child: chatsMessagesWidgets != null
                ? ListView(
                    children: chatsMessagesWidgets,
                  )
                : Center(
                    child: Text("Loading"),
                  ),
          ),
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Flexible(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: TextField(
                    decoration: InputDecoration(hintText: 'Start Writing'),
                    controller: _msgController,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    sendMessage();
                  },
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.all(Radius.circular(90))),
                    child: Icon(Icons.send),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> buildMessagesList(List<ChatModel> chatList) async {
    List<ChatBubbleWidget> newMessagesList = [];
    String myId = await widget._preferencesHelper.getUserUID();
    chatList.forEach((element) {
      log("Adding new Item");
      newMessagesList.add(ChatBubbleWidget(
        message: element.msg,
        me: element.sender == myId ? true : false,
        sentDate: DateTime.now(),
      ));
    });
    chatsMessagesWidgets = newMessagesList;
    return;
  }

  sendMessage() {
    log("Sending: " + _msgController.text);
    widget._chatPageBloc.sendMessage("123456789", _msgController.text);
    _msgController.clear();
  }
}
