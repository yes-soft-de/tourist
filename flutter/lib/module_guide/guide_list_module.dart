import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/abstracts/module/yes_module.dart';

@provide
class GuideListModule extends YesModule {

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
    };
  }
}