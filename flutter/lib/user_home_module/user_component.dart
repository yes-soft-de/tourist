import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/abstracts/module/yes_module.dart';
import 'package:tourists/user_home_module/ui/screens/home/home.dart';
import 'package:tourists/user_home_module/user_home_routes.dart';

@provide
class UserModule extends YesModule {
  final HomeScreen _homeScreen;
  final RequestGuideScreen _orderGuideScreen;

  Map<String, WidgetBuilder> _userRoutes;

  UserModule(
      this._homeScreen,
      this._orderGuideScreen);

  Map<String, WidgetBuilder> getRoutes() {
    return {
      UserHomeRoutes.requestGuide: (context) => _orderGuideScreen,
      UserHomeRoutes.home: (context) => _homeScreen
    };
  }
}
