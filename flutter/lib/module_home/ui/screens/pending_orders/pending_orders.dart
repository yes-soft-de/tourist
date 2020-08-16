import 'package:flutter/material.dart';
import 'package:tourists/module_orders/model/order/order_model.dart';

class PendingOrdersScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PendingOrdersScreenState();
}

class _PendingOrdersScreenState extends State<PendingOrdersScreen> {
  @override
  Widget build(BuildContext context) {

  }

  _getSuccessUI(List<OrderModel> orders) {
    List<Widget> pageUI = [];

    orders.forEach((element) {
      pageUI.add(Text(element.guidUserID));
    });

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, title: Text('سياح'),),
      body: ListView(
        children: pageUI,
      ),
    );
  }

  _getOrders() {

  }
}