import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/abstracts/module/yes_module.dart';
import 'package:tourists/guide_authorization_module/guide_authorization_routes.dart';
import 'package:tourists/guide_authorization_module/ui/screens/guide_login/guide_login.dart';
import 'package:tourists/guide_authorization_module/ui/screens/guide_profile/guide_profile.dart';

@provide
class GuideAuthorizationModule extends YesModule {
  final GuideLoginScreen _guideLoginScreen;
  final GuideProfileScreen _guideProfileScreen;

  GuideAuthorizationModule(this._guideProfileScreen, this._guideLoginScreen);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      GuideAuthorizationRoutes.guideLogin: (context) => _guideLoginScreen,
      GuideAuthorizationRoutes.guideUpdateProfile: (context) => _guideProfileScreen
    };
  }
}