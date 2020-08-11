import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/abstracts/module/yes_module.dart';
import 'package:tourists/ui/guide/guide_info/guide_info.dart';
import 'package:tourists/ui/guide/guide_profile/guide_profile.dart';

import 'guide_routes.dart';

@provide
class GuideHomeModule extends YesModule{
  GuideLoginScreen _guideLoginScreen;
  GuideHomeScreen _guideHomeScreen;
  GuideInfoScreen _guideInfoScreen;
  GuideProfileScreen _guideProfileScreen;

  Map<String, WidgetBuilder> _guideRoutes;

  GuideHomeModule(
      this._guideLoginScreen,
      this._guideHomeScreen,
      this._guideInfoScreen,
      this._guideProfileScreen) {
    _guideRoutes = {
      GuideHomeRoutes.guideLogin: (context) => _guideLoginScreen,
      GuideHomeRoutes.guideHome: (context) => _guideHomeScreen,
      GuideHomeRoutes.guideRegister: (context) => _guideInfoScreen,
      GuideHomeRoutes.guideProfileCreate: (context) => _guideProfileScreen
    };
  }

  Map<String, WidgetBuilder> getRoutes() {
    return _guideRoutes;
  }
}
