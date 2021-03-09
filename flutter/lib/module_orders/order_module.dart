import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/abstracts/module/yes_module.dart';
import 'package:tourists/module_orders/orders_routes.dart';

import 'ui/screen/orders_list/order_list_screen.dart';

@provide
class OrderModule extends YesModule {
  final OrdersListScreen _ordersListScreen;

  OrderModule(this._ordersListScreen);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      OrdersRoutes.ordersList: (context) => _ordersListScreen
    };
  }
}
