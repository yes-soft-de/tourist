import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/abstracts/module/yes_module.dart';
import 'package:tourists/module_settings/settings_routes.dart';
import 'package:tourists/module_settings/ui/settings/settings.dart';

@provide
class SettingsModule extends YesModule {
  final SettingsScreen _settingsScreen;

  SettingsModule(this._settingsScreen);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {SettingsRoute.settingsRoutes: (context) => _settingsScreen};
  }
}
