import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/components/shared/shared_routes.dart';
import 'package:tourists/ui/shared/chat_page/chat_page.dart';

@provide
class SharedComponent {
  ChatPage _chatPage;

  Map<String, WidgetBuilder> _guideRoutes;

  SharedComponent(this._chatPage) {
    _guideRoutes = {
      SharedRoutes.chatRoute: (context) => _chatPage,
    };
  }

  Map<String, WidgetBuilder> getRoutes() {
    return _guideRoutes;
  }
}