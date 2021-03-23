import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tourists/module_forms/user_orders_module/ui/screens/request_guide/request_guide_screen.dart';
import 'package:tourists/module_forms/user_orders_module/ui/states/request_guide_form.dart';
import 'package:tourists/module_orders/orders_routes.dart';

class RequestGuideFormStateSuccess extends RequestGuideFormState {
  RequestGuideFormStateSuccess(RequestGuideScreen screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Request Success!',
          textAlign: TextAlign.center,
        ),
        IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersRoutes.ordersList);
            }),
      ],
    );
  }
}
