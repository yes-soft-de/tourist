import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/abstracts/module/yes_module.dart';
import 'package:tourists/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:tourists/module_forms/forms_routes.dart';
import 'package:tourists/utils/auth_guard/auth_gard.dart';

import 'user_orders_module/ui/screens/request_guide/request_guide_screen.dart';

@provide
class FormsModule extends YesModule {
  final RequestGuideScreen _requestGuideScreen;
  final LoginScreen _loginScreen;

  FormsModule(this._requestGuideScreen, this._loginScreen);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      FormsRoutes.requestGuideForm: (context) => _requestGuideScreen
    };
  }
}
