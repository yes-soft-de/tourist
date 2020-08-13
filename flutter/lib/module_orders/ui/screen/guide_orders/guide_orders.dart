import 'package:flutter/material.dart';
import 'package:tourists/generated/l10n.dart';

class GuideOrders extends StatefulWidget {
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
        title: Text(S
            .of(context)
            .orders),
      ),
      body: PageView(),
    );
  }

  Widget _getAvailableOrders() {
    return ListView(
      children: <Widget>[],
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
