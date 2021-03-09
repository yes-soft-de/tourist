import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/abstracts/module/yes_module.dart';
import 'package:tourists/module_search/search_routes.dart';
import 'package:tourists/module_search/ui/screen/search_screen/search_screen.dart';

@provide
class SearchModule extends YesModule {
  final SearchScreen _searchScreen;

  SearchModule(this._searchScreen);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      SearchRoutes.ROUTE_SEARCH: (context) => _searchScreen,
    };
  }

}