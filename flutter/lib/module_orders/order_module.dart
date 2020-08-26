import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/abstracts/module/yes_module.dart';
import 'package:tourists/module_authorization/login_selector_module/ui/screens/account_type_selector/login_type_selector.dart';
import 'package:tourists/module_orders/orders_routes.dart';
import 'package:tourists/utils/auth_guard/auth_gard.dart';

import 'ui/screen/orders_list/order_list_screen.dart';

@provide
class OrderModule extends YesModule {
  OrdersListScreen _ordersListScreen;
  LoginTypeSelectorScreen _loginTypeSelectorScreen;
  AuthGuard _authGuard;

  OrderModule(
      this._ordersListScreen, this._loginTypeSelectorScreen, this._authGuard);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      OrdersRoutes.ordersList: (context) => FutureBuilder(
        future: _authGuard.isLoggedIn(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) return _ordersListScreen;
          }
          return _loginTypeSelectorScreen;
        },
      )
    };
  }
}