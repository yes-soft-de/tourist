import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/abstracts/module/yes_module.dart';
import 'package:tourists/chat_module/chat_routes.dart';

import 'ui/screens/chat_page/chat_page.dart';

@provide
class ChatModule extends YesModule{
  ChatPage _chatPage;

  ChatModule(this._chatPage);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      ChatRoutes.chatRoute: (context) => _chatPage,
    };
  }
}