import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:tourists/module_orders/bloc/orders_list_bloc.dart';
import 'package:tourists/module_orders/model/order/order_model.dart';
import 'package:tourists/module_orders/ui/widget/order_item/order_item.dart';

@provide
class OrdersListScreen extends StatefulWidget{
  
  final OrdersListBloc _bloc;
  
  OrdersListScreen(this._bloc);
  
  @override
  State<StatefulWidget> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrdersListScreen> {
  PageController _pageController = PageController();
  int activePosition = 0;
  List<OrderModel> ordersList;
  int currentStatus = OrdersListBloc.STATUS_CODE_INIT;

  @override
  Widget build(BuildContext context) {
    if (currentStatus == OrdersListBloc.STATUS_CODE_INIT) {
      widget._bloc.getOrdersList();
    }

    widget._bloc.ordersStream.listen((event) {
      currentStatus = event.first;
      if (currentStatus == OrdersListBloc.STATUS_CODE_LOAD_SUCCESS) {
        ordersList = event.last;
      }
      setState(() {});
    });

    switch (currentStatus) {
      case OrdersListBloc.STATUS_CODE_LOADING:

    }

    if (currentStatus == OrdersListBloc.STATUS_CODE_LOAD_ERROR) {
      return Scaffold(
          body: Center(
            child: Text("Load Error!"),
          ));
    }

    if (currentStatus == OrdersListBloc.STATUS_CODE_INIT) {
      return Scaffold(
          body: Center(
            child: Text("Loading"),
          ));
    }

    if (currentStatus == OrdersListBloc.STATUS_CODE_LOAD_SUCCESS) {
      List<Widget> pageLayout = [];
      pageLayout.add(Container(
        height: 36,
      ));
      // region Header
      Flex widgetHeader = Flex(
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
                      'Sent / Pending',
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
                      'Pending Payment',
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
                      'Payed / On going',
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
                      'Finished Orders',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: activePosition == 3
                              ? Colors.greenAccent
                              : Colors.black),
                    )),
              )),
        ],
      );
      pageLayout.add(widgetHeader);
      // endregion

      // Here we have all the payments that is sent from the user.
      ListView sentOrders = getSentOrdersList();
      ListView pendingPaymentOrders = getPendingPaymentList();
      ListView onGoing = getOnGoingOrdersList();
      ListView done = getFinishedOrdersList();

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

    return Scaffold(
      body: Center(
        child: Text("Undefined State?!! " + currentStatus.toString()),
      ),
    );
  }

  Widget getSentOrdersList() {
    if (ordersList == null) {
      return ListView(
        children: <Widget>[
          Center(
            child: Text("Empty List"),
          ),
        ],
      );
    }
    List<Widget> ordersWidgetList = [];
    ordersList.forEach((element) {
      if (element.status == 'waitingPayment')
        ordersWidgetList.add(OrderItemWidget(element));
    });
    return ListView(
      children: ordersWidgetList.length > 0
          ? ordersWidgetList
          : <Widget>[Center(child: Text("Empty List"))],
    );
  }

  Widget getPendingPaymentList() {
    if (ordersList == null) {
      return ListView(
        children: <Widget>[
          Center(
            child: Text("Empty List"),
          ),
        ],
      );
    }
    List<Widget> ordersWidgetList = [];
    ordersList.forEach((element) {
      if (element.status == 'pendingConformation')
        ordersWidgetList.add(OrderItemWidget(element));
    });
    return ListView(
      children: ordersWidgetList.length > 0
          ? ordersWidgetList
          : <Widget>[Center(child: Text("Empty List"))],
    );
  }

  Widget getOnGoingOrdersList() {
    if (ordersList == null) {
      return ListView(
        children: <Widget>[
          Center(
            child: Text("Empty List"),
          ),
        ],
      );
    }
    List<Widget> ordersWidgetList = [];
    ordersList.forEach((element) {
      if (element.status == 'onGoing')
        ordersWidgetList.add(OrderItemWidget(element));
    });
    return ListView(
      children: ordersWidgetList.length > 0
          ? ordersWidgetList
          : <Widget>[Center(child: Text("Empty List"))],
    );
  }

  Widget getFinishedOrdersList() {
    if (ordersList == null) {
      return ListView(
        children: <Widget>[
          Center(
            child: Text("Empty List"),
          ),
        ],
      );
    }
    List<Widget> ordersWidgetList = [];
    ordersList.forEach((element) {
      if (element.status == 'finished')
        ordersWidgetList.add(OrderItemWidget(element));
    });
    return ListView(
      children: ordersWidgetList.length > 0
          ? ordersWidgetList
          : <Widget>[Center(child: Text("Empty List"))],
    );
  }
}