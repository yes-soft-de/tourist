import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_orders/bloc/orders_list_bloc/orders_list_bloc.dart';
import 'package:tourists/module_orders/model/order/order_model.dart';
import 'package:tourists/module_orders/ui/widget/order_item/order_item.dart';

@provide
class OrdersListScreen extends StatefulWidget {
  final OrdersListBloc _bloc;

  OrdersListScreen(this._bloc);

  @override
  State<StatefulWidget> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrdersListScreen> {
  final PageController _pageController = PageController();
  int activePosition = 0;
  List<OrderModel> ordersList;
  int currentStatus = OrdersListBloc.STATUS_CODE_INIT;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String currentUserId;

  @override
  Widget build(BuildContext context) {
    widget._bloc.ordersStream.listen((event) async {
      currentStatus = event.first;

      if (currentStatus == OrdersListBloc.STATUS_CODE_LOAD_SUCCESS) {
        ordersList = event.last;
        FirebaseUser user = await _auth.currentUser;
        currentUserId = user.uid;
      }

      if (this.mounted) {
        setState(() {});
      }
    });

    switch (currentStatus) {
      case OrdersListBloc.STATUS_CODE_INIT:
        widget._bloc.getOrdersList();
        return _getLoadingUI();
      case OrdersListBloc.STATUS_CODE_LOADING:
        return _getLoadingUI();
      case OrdersListBloc.STATUS_CODE_LOAD_SUCCESS:
        return _getSuccessUI();
      default:
        return _getErrorUI();
    }
  }

  Widget _getSuccessUI() {
    List<Widget> pageLayout = [];
    pageLayout.add(Container(
      height: 36,
    ));
    // region Header
    pageLayout.add(_getFilterBar());
    // endregion

    ordersList.forEach((element) {
      print(element.status);
    });

    // Here we have all the payments that is sent from the user.
    ListView sentOrders = _getSentOrdersList();
    ListView pendingPaymentOrders = _getPendingPaymentList();
    ListView onGoing = _getOnGoingOrdersList();
    ListView done = _getFinishedOrdersList();

    PageView orderPages = PageView(
      controller: _pageController,
      onPageChanged: (position) {
        activePosition = position;
        setState(() {});
      },
      children: <Widget>[sentOrders, pendingPaymentOrders, onGoing, done],
    );

    pageLayout.add(Expanded(
      child: orderPages,
    ));

    return Scaffold(
        body: WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return;
      },
      child: Flex(
        direction: Axis.vertical,
        children: pageLayout,
      ),
    ));
  }

  Scaffold _getErrorUI() {
    return Scaffold(
      body: Center(
        child: Text('Undefined State?!! ' + currentStatus.toString()),
      ),
    );
  }

  Scaffold _getLoadingUI() {
    return Scaffold(
        body: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text('Loading'), CircularProgressIndicator()],
        ),
      ],
    ));
  }

  Widget _getFilterBar() {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                activePosition = 0;
                _pageController.jumpToPage(0);
                setState(() {});
              },
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    S.of(context).sentPending,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: activePosition == 0
                            ? Colors.greenAccent
                            : Colors.black),
                  )),
            )),
        Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                activePosition = 1;
                _pageController.jumpToPage(1);
                setState(() {});
              },
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    S.of(context).pendingPayment,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: activePosition == 1
                            ? Colors.greenAccent
                            : Colors.black),
                  )),
            )),
        Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                activePosition = 2;
                _pageController.jumpToPage(2);
                setState(() {});
              },
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    S.of(context).payedOnGoing,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: activePosition == 2
                            ? Colors.greenAccent
                            : Colors.black),
                  )),
            )),
        Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                activePosition = 3;
                _pageController.jumpToPage(3);
                setState(() {});
              },
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    S.of(context).finishedOrders,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: activePosition == 3
                            ? Colors.greenAccent
                            : Colors.black),
                  )),
            )),
      ],
    );
  }

  Widget _getSentOrdersList() {
    if (ordersList == null) {
      return ListView(
        children: <Widget>[
          Center(
            child: Text('Empty List'),
          ),
        ],
      );
    }
    List<Widget> ordersWidgetList = [];
    ordersList.forEach((element) {
      if (element.status == 'waitingPayment') {
        ordersWidgetList.add(OrderItemWidget(
          element,
          canPay: currentUserId == element.touristUserID,
        ));
      }
    });
    return ListView(
      children: ordersWidgetList.isNotEmpty
          ? ordersWidgetList
          : <Widget>[Center(child: Text('Empty List'))],
    );
  }

  Widget _getPendingPaymentList() {
    if (ordersList == null) {
      return ListView(
        children: <Widget>[
          Center(
            child: Text('Empty List'),
          ),
        ],
      );
    }
    List<Widget> ordersWidgetList = [];
    ordersList.forEach((element) {
      if (element.status == 'pending') {
        ordersWidgetList.add(OrderItemWidget(
          element,
          canPay: currentUserId == element.touristUserID,
          onPayOrder: (order) {
            widget._bloc.payOrder(order);
          },
          onAcceptOrder: (order) {
            widget._bloc.payOrder(order);
          },
        ));
      }
    });
    return ListView(
      children: ordersWidgetList.isNotEmpty
          ? ordersWidgetList
          : <Widget>[Center(child: Text('Empty List'))],
    );
  }

  Widget _getOnGoingOrdersList() {
    if (ordersList == null) {
      return ListView(
        children: <Widget>[
          Center(
            child: Text('Empty List'),
          ),
        ],
      );
    }
    List<Widget> ordersWidgetList = [];
    ordersList.forEach((element) {
      if (element.status == 'onGoing') {
        ordersWidgetList.add(OrderItemWidget(
          element,
          canPay: currentUserId == element.touristUserID,
        ));
      }
    });
    return ListView(
      children: ordersWidgetList.isNotEmpty
          ? ordersWidgetList
          : <Widget>[Center(child: Text('Empty List'))],
    );
  }

  Widget _getFinishedOrdersList() {
    if (ordersList == null) {
      return ListView(
        children: <Widget>[
          Center(
            child: Text('Empty List'),
          ),
        ],
      );
    }
    List<Widget> ordersWidgetList = [];
    ordersList.forEach((element) {
      if (element.status == 'finished') {
        ordersWidgetList.add(OrderItemWidget(
          element,
          canPay: currentUserId == element.touristUserID,
        ));
      }
    });
    return ListView(
      children: ordersWidgetList.isNotEmpty
          ? ordersWidgetList
          : <Widget>[Center(child: Text('Empty List'))],
    );
  }
}
