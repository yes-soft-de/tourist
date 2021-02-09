import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/abstracts/module/yes_module.dart';
import 'package:tourists/module_authorization/authorization_routes.dart';
import 'package:tourists/module_authorization/guide_authorization_module/guide_authorization_module.dart';
import 'package:tourists/module_authorization/login_selector_module/ui/screens/account_type_selector/login_type_selector.dart';
import 'package:tourists/module_authorization/login_selector_module/ui/screens/logout/logout.dart';
import 'package:tourists/module_authorization/user_authorization_module/user_auth.dart';

@provide
class AuthorizationModule extends YesModule {
  final GuideAuthorizationModule _guideAuthorizationModule;
  final UserAuthorizationModule _userAuthorizationModule;
  final LoginTypeSelectorScreen _loginTypeSelectorScreen;
  final LogoutScreen _logoutScreen;

  AuthorizationModule(this._userAuthorizationModule, this._logoutScreen,
      this._guideAuthorizationModule, this._loginTypeSelectorScreen);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    Map<String, WidgetBuilder> routesMap = {};
    routesMap.addAll(_guideAuthorizationModule.getRoutes());
    routesMap.addAll(_userAuthorizationModule.getRoutes());
    routesMap.addAll({
      AuthorizationRoutes.loginTypeSelector: (context) =>
          _loginTypeSelectorScreen,
      AuthorizationRoutes.logout: (context) => _logoutScreen
    });

    return routesMap;
  }
}