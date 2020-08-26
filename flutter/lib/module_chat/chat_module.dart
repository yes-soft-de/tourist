import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/abstracts/module/yes_module.dart';
import 'package:tourists/module_authorization/login_selector_module/ui/screens/account_type_selector/login_type_selector.dart';
import 'package:tourists/utils/auth_guard/auth_gard.dart';

import 'chat_routes.dart';
import 'ui/screens/chat_page/chat_page.dart';

@provide
class ChatModule extends YesModule {
  final ChatPage _chatPage;
  final AuthGuard _authGuard;
  final LoginTypeSelectorScreen _loginTypeSelectorScreen;

  ChatModule(this._chatPage, this._authGuard, this._loginTypeSelectorScreen);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      ChatRoutes.chatRoute: (context) => FutureBuilder(
            future: _authGuard.isLoggedIn(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.data == true) {
                return _chatPage;
              }

              return _loginTypeSelectorScreen;
            },
          ),
    };
  }
}
