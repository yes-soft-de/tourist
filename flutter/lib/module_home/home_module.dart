import 'package:flutter/cupertino.dart';
import 'package:inject/inject.dart';
import 'package:tourists/abstracts/module/yes_module.dart';
import 'package:tourists/utils/auth_guard/auth_gard.dart';

import 'home_routes.dart';
import 'ui/screens/guide_home/guide_home.dart';
import 'ui/screens/home/home.dart';

@provide
class HomeModule extends YesModule {
  final HomeScreen _homeScreen;
  final GuideHomeScreen _guideHomeScreen;
  final AuthGuard _authGuard;

  HomeModule(this._guideHomeScreen, this._homeScreen, this._authGuard);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      HomeRoutes.home: (context) => _homeScreen,
      HomeRoutes.guideHome: (context) => _guideHomeScreen,
    };
  }
}
