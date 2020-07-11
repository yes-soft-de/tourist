import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/guide/guide_routes.dart';
import 'package:tourists/guide/ui/screens/guide_login/guide_login.dart';

@provide
class GuideComponent {
  GuideLoginScreen _guideLoginScreen;

  Map<String, WidgetBuilder> _guideRoutes;

  GuideComponent(this._guideLoginScreen) {
    _guideRoutes = {
      GuideRoutes.guideLogin: (context) => _guideLoginScreen
    };
  }

  Map<String, WidgetBuilder> getRoutes() {
    return _guideRoutes;
  }
}