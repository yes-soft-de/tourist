import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/abstracts/module/yes_module.dart';
import 'package:tourists/module_authorization/authorization_routes.dart';
import 'package:tourists/module_authorization/guide_authorization_module/guide_authorization_module.dart';
import 'package:tourists/module_authorization/user_authorization_module/user_auth.dart';
import 'package:tourists/module_authorization/login_selector_module/ui/screens/account_type_selector/login_type_selector.dart';

@provide
class AuthorizationModule extends YesModule {

  GuideAuthorizationModule _guideAuthorizationModule;
  UserAuthorizationModule _userAuthorizationModule;
  LoginTypeSelectorScreen _loginTypeSelectorScreen;

  AuthorizationModule(this._userAuthorizationModule,
      this._guideAuthorizationModule, this._loginTypeSelectorScreen);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    Map<String, WidgetBuilder> routesMap = {};
    routesMap.addAll(_guideAuthorizationModule.getRoutes());
    routesMap.addAll(_userAuthorizationModule.getRoutes());
    routesMap.addAll({
      AuthorizationRoutes.loginTypeSelector: (
          context) => _loginTypeSelectorScreen
    });

    return routesMap;
  }
}