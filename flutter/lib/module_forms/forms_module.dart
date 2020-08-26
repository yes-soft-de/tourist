import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/abstracts/module/yes_module.dart';
import 'package:tourists/module_authorization/user_authorization_module/ui/screens/login/login.dart';
import 'package:tourists/module_forms/forms_routes.dart';
import 'package:tourists/utils/auth_guard/auth_gard.dart';

import 'user_orders_module/ui/screens/request_guide/request_guide_screen.dart';

@provide
class FormsModule extends YesModule {
  final RequestGuideScreen _requestGuideScreen;
  final AuthGuard _authGuard;
  final LoginScreen _loginScreen;

  FormsModule(this._requestGuideScreen, this._authGuard, this._loginScreen);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      FormsRoutes.requestGuideForm: (context) => FutureBuilder(
            future: _authGuard.isLoggedIn(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.data == true) {
                return _requestGuideScreen;
              }

              return _loginScreen;
            },
          )
    };
  }
}
