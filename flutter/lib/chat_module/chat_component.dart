import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/abstracts/module/yes_module.dart';
import 'package:tourists/chat_module/chat_routes.dart';

import 'ui/screens/chat_page/chat_page.dart';

@provide
class ChatComponent extends YesModule{
  ChatPage _chatPage;

  ChatComponent(this._chatPage);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      ChatRoutes.chatRoute: (context) => _chatPage,
    };
  }
}