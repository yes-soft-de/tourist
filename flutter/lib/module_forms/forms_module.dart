import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/abstracts/module/yes_module.dart';
import 'package:tourists/module_authorization/login_selector_module/ui/screens/account_type_selector/login_type_selector.dart';
import 'package:tourists/module_forms/forms_routes.dart';
import 'package:tourists/utils/auth_guard/auth_gard.dart';

import 'user_orders_module/ui/screens/request_guide/request_guide_screen.dart';

@provide
class FormsModule extends YesModule {
  final RequestGuideScreen _requestGuideScreen;
  final LoginTypeSelectorScreen _loginTypeSelectorScreen;
  final AuthGuard _authGuard;

  FormsModule(
      this._requestGuideScreen, this._authGuard, this._loginTypeSelectorScreen);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      FormsRoutes.requestGuideForm: (context) => FutureBuilder(
            future: _authGuard.isLoggedIn(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.data == true) {
                return _requestGuideScreen;
              }

              return _loginTypeSelectorScreen;
            },
          )
    };
  }
}
