import 'package:flutter/material.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_orders/bloc/guide_orders_list/guide_orders_list.dart';
import 'package:tourists/module_orders/model/order/order_model.dart';
import 'package:tourists/module_orders/ui/widget/order_item/order_item.dart';

class GuideOrders extends StatefulWidget {
  final GuideOrdersListBloc bloc;

  GuideOrders(this.bloc);

  @override
  State<StatefulWidget> createState() => _GuideOrdersState();
}

class _GuideOrdersState extends State<GuideOrders> {
  int activeList = 0;
  List<OrderModel> ordersList;

  @override
  Widget build(BuildContext context) {}

  Widget _getSuccessUI() {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).orders),
      ),
      body: PageView(
        children: <Widget>[_getAvailableOrders()],
      ),
    );
  }

  Widget _getAvailableOrders() {
    List<Widget> orderCards = [];

    ordersList.forEach((order) {
      orderCards.add(OrderItemWidget(
        order,
        onAcceptOrder: (order) {
          widget.bloc.acceptOrder(order);
        },
      ));
    });

    return ListView(
      children: orderCards,
    );
  }

  Widget _getUIHeader() {
    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              child: Text('Available'),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            child: Text('On Going'),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            child: Text('Done'),
          ),
        ),
      ],
    );
  }
}
