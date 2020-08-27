import 'package:flutter/material.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_orders/bloc/guide_orders_list/guide_orders_list.dart';
import 'package:tourists/module_orders/model/order/order_model.dart';
import 'package:tourists/module_orders/ui/widget/order_item/order_item.dart';

class PendingPaymentOrders extends StatefulWidget {
  final GuideOrdersListBloc bloc;

  PendingPaymentOrders(this.bloc);

  @override
  State<StatefulWidget> createState() => _PendingPaymentOrdersState();
}

class _PendingPaymentOrdersState extends State<PendingPaymentOrders> {
  int activeList = 0;
  int currentStatus = GuideOrdersListBloc.STATUS_CODE_INIT;
  List<OrderModel> ordersList;

  @override
  Widget build(BuildContext context) {
    widget.bloc.stateStream.listen((event) {
      currentStatus = event[GuideOrdersListBloc.KEY_STATUS];

      if (currentStatus == GuideOrdersListBloc.STATUS_CODE_LOAD_SUCCESS) {
        ordersList = event[GuideOrdersListBloc.KEY_PAYLOAD];
      }

      if (this.mounted) setState(() {});
    });

    switch (currentStatus) {
      case GuideOrdersListBloc.STATUS_CODE_LOADING:
        return _getLoadingUI();
      case GuideOrdersListBloc.STATUS_CODE_LOAD_SUCCESS:
        return _getSuccessUI();
      case GuideOrdersListBloc.STATUS_CODE_INIT:
        widget.bloc.getAvailableOrders();
        return _getLoadingUI();
      case GuideOrdersListBloc.STATUS_CODE_ORDER_UPDATED:
        widget.bloc.getAvailableOrders();
        return _getLoadingUI();
      default:
        return _getErrorScreen();
    }
  }

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

  Widget _getLoadingUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [CircularProgressIndicator(), Text(S.of(context).loading)],
    );
  }

  Widget _getErrorScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(S.of(context).error_fetching_data),
        RaisedButton(
          onPressed: () {
            widget.bloc.getAvailableOrders();
          },
          child: Text(S.of(context).reload),
        )
      ],
    );
  }

  Widget _getAvailableOrders() {
    List<Widget> orderCards = [];

    if (ordersList != null) {
      ordersList.forEach((order) {
        if (order.status == 'pendingPayment') {
          orderCards.add(OrderItemWidget(order, onPayOrder: (order) {
            widget.bloc.payOrder(order);
          }));
        }
      });
    }

    return ListView(
      children: orderCards,
    );
  }
}
