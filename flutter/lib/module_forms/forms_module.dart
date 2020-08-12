import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/abstracts/module/yes_module.dart';
import 'package:tourists/module_forms/forms_routes.dart';

import 'user_orders_module/ui/screens/request_guide/request_guide_screen.dart';

@provide
class FormsModule extends YesModule {
  final RequestGuideScreen _requestGuideScreen;

  FormsModule(this._requestGuideScreen);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {FormsRoutes.requestGuideForm: (context) => _requestGuideScreen};
  }
}
