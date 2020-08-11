import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/abstracts/module/yes_module.dart';
import 'package:tourists/guide_login_module/guide_login_routes.dart';
import 'package:tourists/guide_login_module/ui/screens/guide_login/guide_login.dart';
import 'package:tourists/guide_login_module/ui/screens/guide_profile/guide_profile.dart';

@provide
class GuideLoginModule extends YesModule {
  final GuideLoginScreen _guideLoginScreen;
  final GuideProfileScreen _guideProfileScreen;

  GuideLoginModule(this._guideProfileScreen, this._guideLoginScreen);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      GuideLoginRoutes.guideLogin: (context) => _guideLoginScreen,
      GuideLoginRoutes.guideUpdateProfile: (context) => _guideProfileScreen
    };
  }
}