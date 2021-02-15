import 'package:flutter/material.dart';
import 'package:tourists/abstracts/module/yes_module.dart';
import 'package:tourists/module_search/search_routes.dart';

class SearchModule extends YesModule {
  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      SearchRoutes.ROUTE_SEARCH: (context) => Scaffold()
    };
  }

}