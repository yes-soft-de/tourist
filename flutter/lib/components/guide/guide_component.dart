import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/ui/guide/guide_home/guide_home.dart';
import 'package:tourists/ui/guide/guide_info/guide_info.dart';
import 'package:tourists/ui/guide/guide_login/guide_login.dart';
import 'package:tourists/ui/guide/guide_profile/guide_profile.dart';

import 'guide_routes.dart';

@provide
class GuideComponent {
  GuideLoginScreen _guideLoginScreen;
  GuideHomeScreen _guideHomeScreen;
  GuideInfoScreen _guideInfoScreen;
  GuideProfileScreen _guideProfileScreen;

  Map<String, WidgetBuilder> _guideRoutes;

  GuideComponent(
      this._guideLoginScreen,
      this._guideHomeScreen,
      this._guideInfoScreen,
      this._guideProfileScreen) {
    _guideRoutes = {
      GuideRoutes.guideLogin: (context) => _guideLoginScreen,
      GuideRoutes.guideHome: (context) => _guideHomeScreen,
      GuideRoutes.guideRegister: (context) => _guideInfoScreen,
      GuideRoutes.guideProfileCreate: (context) => _guideProfileScreen
    };
  }

  Map<String, WidgetBuilder> getRoutes() {
    return _guideRoutes;
  }
}
