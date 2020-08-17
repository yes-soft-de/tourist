import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/abstracts/module/yes_module.dart';
import 'package:tourists/module_splash/ui/screen/splash_screen.dart';
import 'package:tourists/module_splash/ui/splash_routes.dart';

@provide
class SplashModule extends YesModule {
  SplashScreen _splashScreen;

  SplashModule(this._splashScreen);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {SplashRoutes.splash: (context) => _splashScreen};
  }
}
