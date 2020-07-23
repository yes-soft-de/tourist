import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/ui/guide/guide_home/guide_home.dart';
import 'package:tourists/ui/guide/guide_login/guide_login.dart';

import 'guide_routes.dart';

@provide
class GuideComponent {
  GuideLoginScreen _guideLoginScreen;
  GuideHomeScreen _guideHomeScreen;

  Map<String, WidgetBuilder> _guideRoutes;

  GuideComponent(this._guideLoginScreen, this._guideHomeScreen) {
    _guideRoutes = {
      GuideRoutes.guideLogin: (context) => _guideLoginScreen,
      GuideRoutes.guideHome: (context) => _guideHomeScreen
    };
  }

  Map<String, WidgetBuilder> getRoutes() {
    return _guideRoutes;
  }
}