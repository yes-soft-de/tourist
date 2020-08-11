import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/abstracts/module/yes_module.dart';
import 'package:tourists/guide_home_module/ui/screens/guide_home/guide_home.dart';

import 'guide_routes.dart';

@provide
class GuideHomeModule extends YesModule {
  final GuideHomeScreen _guideHomeScreen;

  Map<String, WidgetBuilder> _guideRoutes;

  GuideHomeModule(
    this._guideHomeScreen,
  ) {
    _guideRoutes = {GuideHomeRoutes.guideHome: (context) => _guideHomeScreen};
  }

  Map<String, WidgetBuilder> getRoutes() {
    return _guideRoutes;
  }
}
